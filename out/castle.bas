' CASTLE ADVENTURE (1984, Kevin Bales)
' Decompiled from CASTLE.EXE (IBM BASIC Compiler 1.0) by tools/lift.py + tools/structure.py.
' Loops and IF blocks are reconstructed; the remaining labels are named after what they do,
' and the trailing ' @XXXX is the code address (see castle_flat.bas / castle.asm).

' ============================================================================
'  A SHORT BASIC PRIMER (only what this program uses)
' ============================================================================
'  Syntax
'    X = 5            assignment.  In an IF, "=" is a comparison instead.
'    <> <= >= < >     not equal, less-or-equal, ...   AND OR NOT are logical.
'    A \ B            integer division.   A MOD B  remainder.
'    NAME$            a "$" suffix means a string variable; no suffix = number.
'    A(I), R$(I, J)   arrays (1-based by convention here; element 0 exists).
'    ' text           a comment.  "&" is not concatenation; "+" joins strings.
'    Variables need no declaration and start as 0 / "".
'
'  Control flow
'    IF c THEN stmt                     one-line IF
'    IF c THEN ... ELSE ... END IF      block IF
'    FOR I = 1 TO 22 ... NEXT I         counts 1,2,...,22 (both ends inclusive)
'    DO ... LOOP WHILE c                repeat while c is true
'    GOTO Label                         jump.  Labels end in ":".
'    GOSUB Label ... RETURN             call a subroutine and come back
'    ON N GOTO A, B, C                  jump table: N=1 -> A, N=2 -> B, ...
'    END                                stop the program
'
'  Text screen (WIDTH 40 = 40 columns x 25 rows; row 1, column 1 is top-left)
'    CLS                   clear the screen
'    LOCATE row, col       move the text cursor; the next PRINT starts there.
'                          e.g. LOCATE I, 25 : PRINT "|" draws "|" at row I,
'                          column 25.  A 3rd argument shows (1) or hides (0)
'                          the blinking cursor; LOCATE , , 0 only hides it.
'    PRINT a; b            print values.  ";" = no gap, cursor stays put;
'                          "," = jump to the next 14-column zone;
'                          no trailing ";" or "," = move to the next line.
'    COLOR 7 / COLOR 23    normal white / blinking white (16 + 7)
'    SCREEN(row, col)      FUNCTION: the character code shown at that spot.
'                          The game uses the screen itself as its collision
'                          map: walls, doors, items and monsters are found by
'                          reading characters back off the screen.
'    SCREEN 0, 0, 0, 1     STATEMENT (no parentheses): text video mode setup.
'    CHR$(n) / ASC(s$)     character for code n / code of the first character.
'                          Codes are IBM PC "code page 437": CHR$(5) is the
'                          player (a club), CHR$(8) a locked door, 32 a space.
'    KEY OFF               hide the function-key bar on row 25.
'
'  Strings (positions start at 1)
'    LEN(s$)  LEFT$(s$, n)  RIGHT$(s$, n)  MID$(s$, start, n)
'    INSTR(s$, t$)   position of t$ in s$, or 0 if absent
'    SPACE$(n)  STRING$(n, code)  STR$(number)  VAL(s$) (text -> number)
'
'  Keyboard, randomness, sound
'    INKEY$          read a key WITHOUT waiting: "" if none was pressed.
'                    Arrow/keypad keys return 2 characters, CHR$(0) + a code
'                    letter: G=Home H=Up I=PgUp K=Left M=Right O=End P=Down
'                    Q=PgDn.
'    RND             random number, 0 <= RND < 1.  INT() rounds down, so
'                    INT(RND * 100) + 1 is a random whole number 1..100.
'    RANDOMIZE       reseed the generator.
'    SOUND f, d      tone of f Hz for d clock ticks (18.2 ticks = 1 second)
'    BEEP            short beep.   PLAY "..."  music: O=octave, L=note length,
'                    T=tempo, A-G notes, # sharp, P pause, MB/MF background/
'                    foreground.
'    DEF SEG = 0 : POKE 1050, PEEK(1052)
'                    write into BIOS memory: makes the keyboard buffer's head
'                    equal its tail, i.e. throws away keys typed ahead.
'
'  Files
'    OPEN "R", #1, "CASTLE.RAN", 575   random-access file, 575-byte records
'    FIELD #1, 24 AS FR1$, ...         names the byte ranges of a record
'    GET #1, n / PUT #1, n             read / write record n via those names
'    LSET F$ = x                       store x into a FIELD variable (padded)
'    OPEN "O"/"I"/"A", #2, name        sequential output / input / append
'    PRINT #2, ... / INPUT #2, ...     write / read values in such a file
'    EOF(2)  true (-1) at end of file.  CLOSE closes; KILL name deletes.
'    READ a, b$, ...                   take the next values from DATA lines
'    ON ERROR GOTO L / ERR             error trap / error number (53 = file
'                                      not found)
'    True is -1 and false is 0 in BASIC comparisons.

' ============================================================================
'  HOW THE GAME IS ORGANISED
' ============================================================================
'  Screen: the room map is drawn at rows 1-18, columns 1-24, with a frame at
'  column 25 / row 19.  The room description is rows 20-24.  Column 26
'  onward is the side panel: visible items (rows 1-10), monsters, messages
'  (rows 13-19) and the command prompt (row 23).
'
'  Rooms come from CASTLE.RAN, 10 at a time (a "page"), into ROOM$(line,
'  slot): lines 0-17 are map rows, 18 the description, 19 the exits text
'  such as "N3S1" (north -> room 3, south -> room 1).  Room 0 = outside:
'  reaching it wins the game.
'
'  Objects (1-22) and monsters (1-10) come from the DATA lines at the end.
'    OBJROOM(i) = 0        the player carries it
'               = 1..83    it lies in that room (at OBJROW, OBJCOL)
'               = room+100 hidden in that room; then OBJROW/OBJCOL hold the
'                          character codes of the furniture it is hidden in
'    MONHP(i) < 0          the monster is dead
'  Messages: set NMSG (how many lines) and MSG$(1..NMSG), then
'  GOTO ShowMessage, which prints them and returns to the InputLoop.

' ============================================================================
'  VARIABLES
' ============================================================================
'  ROOM                          current room (1-83)
'  PREVROOM                      room the player came from
'  PY / PX                       player row / column on the map
'  UNDER                         character the player is standing on
'  STRENGTH                      player hit points (starts 100, dead below 0)
'  NCARRY                        number of items carried (max 6)
'  DOOR68LOCKED / DOOR82LOCKED   1 while the wine-cellar / dungeon door is locked
'  FLASKFULL                     1 when the flask holds water
'  DRANK                         1 after drinking (heals only once)
'  CMD$                          command being typed
'  VERB$ / NOUN$                 first / second word of the command
'  K$                            last key read
'  DY / DX                       movement direction (-1, 0, 1)
'  NY / NX                       square the player is moving to
'  CH                            character found there
'  IDLE                          counts idle input polls; at 200 the monsters move
'  MONHERE                       1 if a live monster is in the room
'  TARGET                        monster being attacked
'  MDY / MDX                     monster step direction
'  ROLL                          random roll 1-100
'  MN$                           monster name without its adjective
'  W$                            scratch string (word, exit number)
'  NMSG / MSG$()                 message lines for the side panel
'  PAGE / PAGEEND / SLOT         first / last room loaded from disk, and ROOM's slot
'  ROOM$(line, slot)             cached room records
'  DESC$()                       description split into 5 lines
'  FR1$..FR18$, FDESC$, FEXITS$  FIELD variables of a CASTLE.RAN record
'  OBJ*() / MON*()               object / monster tables (ROOM, NAME$, CHAR, ROW, COL, HP)
'  SCORE / HISCORE               final score / stored high score
'  I J K N T T2 C X T$ SC$       loop counters and scratch values

' ============================================================================
'  CONSTANTS  (not in the 1984 original, which used bare numbers; CONST is
'  QuickBASIC syntax, added here so the code says what the numbers mean)
' ============================================================================
' Counts
CONST NOBJECTS = 22                 ' objects 1-22
CONST NMONSTERS = 10                ' monsters 1-10
CONST NFIGHTERS = 8                 ' monsters 1-8 move and fight; 9-10 only block

' Special OBJROOM / MONROOM values
CONST CARRIED = 0                   ' OBJROOM(i) = CARRIED: the player has it
CONST HIDDEN = 100                  ' OBJROOM(i) = HIDDEN + room: hidden in that room
CONST RM_NONE = 0                   ' MONROOM(i) = RM_NONE: monster removed from play
CONST RM_OUTSIDE = 0                ' ROOM = RM_OUTSIDE: escaped, the game is won

' Rooms (only the ones the code refers to by number)
CONST RM_COURTYARD = 1              ' Castle Courtyard
CONST RM_KITCHEN = 9                ' Kitchen
CONST RM_CHEFS_QUARTERS = 10        ' Chef's Quarters
CONST RM_STORAGE = 11               ' Storage room
CONST RM_THRONE_ROOM = 14           ' Throne Room
CONST RM_GARDEN_SOUTH = 18          ' South end of The Castle garden
CONST RM_UPPER_HALL = 19            ' center of The upper Hall
CONST RM_VAMPIRE_CORRIDOR = 28      ' Cooridor - the vampire's corridor
CONST RM_BALCONY = 33               ' Balcony looking over the Castle Gardens
CONST RM_RED_ROOM = 37              ' Red Room
CONST RM_BLUE_ROOM = 38             ' Blue room
CONST RM_PURPLE_ROOM = 39           ' Purple room
CONST RM_YELLOW_ROOM = 40           ' Yellow room
CONST RM_FAIRY_CORRIDOR1 = 52       ' Cooridor - the fairy appears here
CONST RM_FAIRY_CORRIDOR2 = 54       ' Cooridor - the fairy appears here
CONST RM_KINGS_STUDY = 56           ' King's Study
CONST RM_EMPTY_ROOM = 57            ' totally Empty room - the diamond room
CONST RM_LIBRARY_WEST = 58          ' west end of The King's Library
CONST RM_LIBRARY_EAST = 59          ' East end of the King's Library
CONST RM_WEST_TOWER_TOP = 64        ' top of the West tower
CONST RM_EAST_TOWER_TOP = 65        ' top of the East Tower
CONST RM_SORCERERS_LAB = 66         ' Sorcerers secret laboratory
CONST RM_SORCERERS_QUARTERS = 67    ' Sorcerers Quarters
CONST RM_WINE_CELLAR = 68           ' Royal Wine Cellar
CONST RM_MAZE_WALL = 74             ' Maze - Kevin Bales was here
CONST RM_TRAP_PASSAGE1 = 76         ' Winding Passage - drowning trap
CONST RM_WINDING_PASSAGE = 77       ' Winding Passage - secret passage at row 18
CONST RM_TRAP_PASSAGE2 = 78         ' Winding passage - drowning trap
CONST RM_TORTURE_ROOM = 79          ' Toture room
CONST RM_DUNGEON_HALL = 82          ' Dungeon entrace hall
CONST RM_KINGS_SECRET_ROOM = 83     ' King's Secret room

' Objects (index into OBJROOM, OBJNAME$, OBJCHAR, OBJROW, OBJCOL)
CONST OBJ_LAMP = 1                  ' LAMP
CONST OBJ_HARP = 2                  ' HARP
CONST OBJ_NECKLACE = 3              ' NECKLACE
CONST OBJ_BOOK = 4                  ' BOOK
CONST OBJ_WAND = 5                  ' MAGIC WAND
CONST OBJ_SWORD = 6                 ' SWORD
CONST OBJ_KEY = 7                   ' KEY
CONST OBJ_GLASSES = 8               ' EYE GLASSES
CONST OBJ_BALL = 9                  ' CRYSTAL BALL
CONST OBJ_HELMET = 10               ' HELMET
CONST OBJ_FLASK = 11                ' WINE FLASK
CONST OBJ_CROSS = 12                ' HOLY CROSS
CONST OBJ_DIAMOND = 13              ' DIAMOND
CONST OBJ_SILVER_BARS = 14          ' SILVER BARS
CONST OBJ_RUBYS = 15                ' RUBYS
CONST OBJ_FIGURINE = 16             ' JADE FIGURINE
CONST OBJ_SCEPTER = 17              ' SCEPTER
CONST OBJ_HOURGLASS = 18            ' HOURGLASS
CONST OBJ_GEM = 19                  ' LARGE GEM
CONST OBJ_GOLDBAR = 20              ' GOLDBAR
CONST OBJ_GOBLET = 21               ' FANCY GOBLET
CONST OBJ_CROWN = 22                ' CROWN

' Monsters (index into MONROOM, MONNAME$, MONCHAR, MONROW, MONCOL, MONHP)
CONST MON_OGRE1 = 1                 ' UGLY OGRE
CONST MON_OGRE2 = 2                 ' UGLY OGRE
CONST MON_DEMON1 = 3                ' ANGRY DEMON
CONST MON_DEMON2 = 4                ' ANGRY DEMON
CONST MON_BIG_SPIDER = 5            ' BIG SPIDER
CONST MON_SMALL_SPIDER = 6          ' SMALL SPIDER
CONST MON_BAT = 7                   ' BAT
CONST MON_SNAKE = 8                 ' SNAKE
CONST MON_VAMPIRE = 9               ' VAMPIRE
CONST MON_FAIRY = 10                ' FAIRY

' Screen characters the game looks for with SCREEN(row, col)
CONST CH_PLAYER = 5                 ' ♣  the player (the vampire uses it too)
CONST CH_DOOR = 8                   ' ◘  a locked door
CONST CH_SPACE = 32                 '    empty floor
CONST CH_VLINE = 179                ' │  furniture edge
CONST CH_HLINE = 196                ' ─  furniture edge
CONST CH_GATE = 205                 ' ═  the courtyard gate
CONST CH_FAIRY = 246                ' ÷  the fairy

' Keys
CONST KEY_BACKSPACE = 8
CONST KEY_ENTER = 13

' Program entry: freeware notice, title screen, then a new game.
Start:                       ' @001A
    GOSUB FreewareNotice
    GOSUB TitleScreen

' Reset the player and load the object and monster tables (DATA).
NewGame:                     ' @0039
    ON ERROR GOTO ErrorHandler
    WIDTH 40
    ROOM = RM_COURTYARD
    PY = 15
    PX = 15
    DOOR68LOCKED = 1
    DOOR82LOCKED = 1
    STRENGTH = 100
    FOR I = 1 TO NOBJECTS
        READ OBJROOM(I), OBJNAME$(I), OBJCHAR(I), OBJROW(I), OBJCOL(I)
    NEXT I
    FOR I = 1 TO NMONSTERS
        READ MONROOM(I), MONNAME$(I), MONCHAR(I), MONROW(I), MONCOL(I), MONHP(I)
    NEXT I
    OPEN "R", #1, "CASTLE.RAN", 575
    FIELD #1, 24 AS FR1$, 24 AS FR2$, 24 AS FR3$, 24 AS FR4$, 24 AS FR5$, 24 AS FR6$, 24 AS FR7$, 24 AS FR8$, 24 AS FR9$, 24 AS FR10$, 24 AS FR11$, 24 AS FR12$, 24 AS FR13$, 24 AS FR14$, 24 AS FR15$, 24 AS FR16$, 24 AS FR17$, 24 AS FR18$, 125 AS FDESC$, 18 AS FEXITS$

' Read the 10 rooms around ROOM from CASTLE.RAN into ROOM$().
LoadRoomPage:                ' @023E
    PAGE = ((ROOM - 1) \ 10) * 10 + 1
    SLOT = ROOM - PAGE + 1
    PAGEEND = PAGE + 9
    FOR J = PAGE TO PAGEEND
        GET #1, J
        I = J - PAGE + 1
        ROOM$(0, I) = FR1$
        ROOM$(1, I) = FR2$
        ROOM$(2, I) = FR3$
        ROOM$(3, I) = FR4$
        ROOM$(4, I) = FR5$
        ROOM$(5, I) = FR6$
        ROOM$(6, I) = FR7$
        ROOM$(7, I) = FR8$
        ROOM$(8, I) = FR9$
        ROOM$(9, I) = FR10$
        ROOM$(10, I) = FR11$
        ROOM$(11, I) = FR12$
        ROOM$(12, I) = FR13$
        ROOM$(13, I) = FR14$
        ROOM$(14, I) = FR15$
        ROOM$(15, I) = FR16$
        ROOM$(16, I) = FR17$
        ROOM$(17, I) = FR18$
        ROOM$(18, I) = FDESC$
        ROOM$(19, I) = FEXITS$
    NEXT J

' Draw the room map, description, items and monsters, then the player.
' Also places the fairy (monster 10) in rooms 52/54 and handles special arrivals.
DrawRoom:                    ' @0469
    CLS
    CMD$ = ""
    DEF SEG = 0                                              ' PEEK/POKE address BIOS memory
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead
    FOR I = 1 TO 18
        LOCATE I, 25
        PRINT "│"
    NEXT I
    FOR I = 1 TO 24
        LOCATE 19, I
        PRINT "─"
    NEXT I
    LOCATE 19, 25
    PRINT "┘"
    FOR I = 1 TO 18
        LOCATE I, 1, 0
        PRINT ROOM$(I - 1, SLOT)
    NEXT I
    T$ = ROOM$(18, SLOT)
    IF LEN(T$) < 125 THEN T$ = T$ + SPACE$(125 - LEN(T$))
    FOR I = 0 TO 4
        DESC$(I + 1) = MID$(T$, I * 25 + 1, 25)
    NEXT I
    FOR I = 1 TO 5
        LOCATE I + 19, 1
        PRINT DESC$(I);
    NEXT I
    NOBJ = 0
    FOR I = 1 TO NOBJECTS
        IF OBJROOM(I) = ROOM THEN
            LOCATE OBJROW(I), OBJCOL(I)
            PRINT CHR$(OBJCHAR(I));
        END IF
        IF OBJROOM(I) = ROOM THEN
            NOBJ = NOBJ + 1
            IF NOBJ < 11 THEN
                LOCATE NOBJ, 26
                PRINT CHR$(OBJCHAR(I));" ";OBJNAME$(I);
            END IF
        END IF
    NEXT I
    IF PREVROOM <> RM_EMPTY_ROOM AND ROOM = RM_FAIRY_CORRIDOR1 THEN
        MONROOM(MON_FAIRY) = RM_FAIRY_CORRIDOR1
        MONROW(MON_FAIRY) = 10
        MONCOL(MON_FAIRY) = 1
    END IF
    IF PREVROOM <> RM_EMPTY_ROOM AND ROOM = RM_FAIRY_CORRIDOR2 THEN
        MONROOM(MON_FAIRY) = RM_FAIRY_CORRIDOR2
        MONROW(MON_FAIRY) = 1
        MONCOL(MON_FAIRY) = 12
    END IF
    NMON = 0
    MONHERE = 0
    FOR I = 1 TO NMONSTERS
        IF MONROOM(I) = ROOM THEN
            LOCATE MONROW(I), MONCOL(I)
            PRINT CHR$(MONCHAR(I));
            IF I < MON_VAMPIRE THEN
                IF MONHP(I) > -1 THEN MONHERE = 1
            END IF
        END IF
        IF MONROOM(I) = ROOM THEN
            NMON = NMON + 1
            IF NMON < 3 THEN
                LOCATE NOBJ + NMON, 26
                PRINT CHR$(MONCHAR(I));" ";MONNAME$(I);
            END IF
        END IF
    NEXT I
    IF PREVROOM = RM_SORCERERS_LAB THEN
        PY = 10
        PX = 17
        UNDER = 32
        LOCATE PY, PX
        PRINT CHR$(CH_PLAYER);
        NMSG = 4
        MSG$(1) = "There is a puff"
        MSG$(2) = "of smoke & you"
        MSG$(3) = "appear in the"
        MSG$(4) = "Sorcerers room!"
        GOTO ShowMessage
    END IF
    IF PREVROOM = RM_KINGS_SECRET_ROOM THEN
        LOCATE 18, 11
        PRINT "▌  ▐";
    END IF
    IF DOOR68LOCKED = 1 AND ROOM = RM_WINE_CELLAR THEN
        LOCATE 15, 9
        PRINT CHR$(CH_DOOR);CHR$(CH_DOOR);
    END IF
    IF DOOR82LOCKED = 1 AND ROOM = RM_DUNGEON_HALL THEN
        LOCATE 9, 14
        PRINT CHR$(CH_DOOR);
        LOCATE 10, 14
        PRINT CHR$(CH_DOOR);
    END IF
    UNDER = SCREEN(PY, PX)                                   ' remember what the player stands on
    LOCATE PY, PX, 0
    PRINT CHR$(CH_PLAYER);
    DEF SEG = 0                                              ' PEEK/POKE address BIOS memory
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead

' Show the prompt and wait for a key.  Typing builds CMD$;
' keypad keys move the player; Enter runs the command.
InputLoop:                   ' @0BFD
    LOCATE 23, 26, 0
    PRINT "?";CMD$;
    IF LEN(CMD$) < 14 THEN
        COLOR 23                                             ' blinking
        PRINT "_";
        COLOR 7                                              ' normal
    END IF
    IF LEN(CMD$) < 14 THEN PRINT SPACE$(13 - LEN(CMD$));

' Each idle poll counts toward a monster turn (every 200 polls).
WaitKey:                     ' @0C83
    IDLE = IDLE + 1
    IF IDLE = 200 THEN                                       ' monsters move every 200 idle polls
        IDLE = 0
        GOTO MonsterTurn
    END IF

' Check the traps (rooms 76/78 without the necklace), then handle the key.
ReadKey:                     ' @0CB1
    K$ = INKEY$
    IF K$ = "" THEN GOTO WaitKey
    IF OBJROOM(OBJ_NECKLACE) <> CARRIED THEN
        IF PX = 15 AND ROOM = RM_TRAP_PASSAGE1 THEN
            IF PY = 14 OR PY = 13 THEN GOTO TrapRoom76
        END IF
    END IF
    IF OBJROOM(OBJ_NECKLACE) <> CARRIED THEN
        IF PX = 18 AND ROOM = RM_TRAP_PASSAGE2 THEN
            IF PY = 10 OR PY = 9 THEN GOTO TrapRoom78
        END IF
    END IF
    IF LEN(K$) >= 2 THEN
        K$ = RIGHT$(K$, 1)
        IF K$ = "G" THEN
            DY = -1
            DX = -1
            GOTO MovePlayer
        END IF
        IF K$ = "H" THEN
            DY = -1
            DX = 0
            GOTO MovePlayer
        END IF
        IF K$ = "I" THEN
            DY = -1
            DX = 1
            GOTO MovePlayer
        END IF
        IF K$ = "K" THEN
            DY = 0
            DX = -1
            GOTO MovePlayer
        END IF
        IF K$ = "M" THEN
            DY = 0
            DX = 1
            GOTO MovePlayer
        END IF
        IF K$ = "O" THEN
            DY = 1
            DX = -1
            GOTO MovePlayer
        END IF
        IF K$ = "P" THEN
            DY = 1
            DX = 0
            GOTO MovePlayer
        END IF
        IF K$ = "Q" THEN
            DY = 1
            DX = 1
            GOTO MovePlayer
        END IF
    END IF
    IF CHR$(KEY_ENTER) = K$ THEN
        LOCATE 23, 26
        PRINT SPACE$(15);
        GOTO DoCommand
    END IF
    IF LEN(CMD$) > 0 AND CHR$(KEY_BACKSPACE) = K$ THEN
        CMD$ = LEFT$(CMD$, LEN(CMD$) - 1)
        GOTO InputLoop
    END IF
    IF LEN(CMD$) = 14 THEN
        SOUND 150, 1
        GOTO InputLoop
    END IF
    IF K$ <> " " THEN

' Convert a lower-case letter to upper case; only A-Z and space are typed.
Uppercase:                   ' @0FA8
        C = ASC(K$)
        IF C < 123 AND C > 96 THEN
            K$ = CHR$(C - 32)
            GOTO Uppercase
        END IF
        IF C > 90 OR C < 65 THEN GOTO InputLoop
    END IF
    CMD$ = CMD$ + K$
    GOTO InputLoop

' Try to move one square.  Leaving the map edge or stepping on U/D
' means a room exit; anything that is not a space is a bump.
MovePlayer:                  ' @103E
    NY = PY + DY
    NX = PX + DX
    CH = SCREEN(NY, NX)
    IF NY < 1 THEN
        T$ = "N"
        PY = 18
        GOTO TakeExit
    END IF
    IF NY > 18 THEN
        T$ = "S"
        PY = 1
        GOTO TakeExit
    END IF
    IF NX < 1 THEN
        T$ = "W"
        PX = 24
        GOTO TakeExit
    END IF
    IF NX > 24 THEN
        T$ = "E"
        PX = 1
        GOTO TakeExit
    END IF
    IF CHR$(CH) = "U" THEN
        T$ = "U"
        GOTO TakeExit
    END IF
    IF CHR$(CH) = "D" THEN
        T$ = "D"
        GOTO TakeExit
    END IF
    IF CH <> CH_SPACE THEN
        SOUND 50, 0.1
        GOTO Bump
    END IF
    LOCATE PY, PX
    PRINT CHR$(UNDER);
    UNDER = SCREEN(NY, NX)                                   ' remember what the player stands on
    PY = NY
    PX = NX
    LOCATE PY, PX
    PRINT CHR$(CH_PLAYER);
    GOTO InputLoop

' Look up the exit letter T$ in the room's exits text and read the room number.
TakeExit:                    ' @123C
    CH = INSTR(ROOM$(19, SLOT), T$)
    W$ = ""

' Collect the digits after the exit letter.
ExitDigits:                  ' @126E
    CH = CH + 1
    IF LEN(ROOM$(19, SLOT)) >= CH THEN
        C = ASC(MID$(ROOM$(19, SLOT), CH, 1))
        IF C >= 48 AND C <= 57 THEN
            W$ = W$ + CHR$(C)
            GOTO ExitDigits
        END IF
    END IF
    IF VAL(W$) = RM_WINE_CELLAR OR VAL(W$) = RM_KINGS_SECRET_ROOM THEN
        IF OBJROOM(OBJ_LAMP) <> CARRIED THEN
            NMSG = 2
            MSG$(1) = "It's too dark"
            MSG$(2) = "to go that way!"
            SOUND 100, 1
            IF ROOM = RM_WINDING_PASSAGE THEN
                PY = 18
                GOTO ShowMessage
            END IF
            GOTO ShowMessage
        END IF
    END IF
    PREVROOM = ROOM
    ROOM = VAL(W$)
    IF ROOM = RM_OUTSIDE THEN GOTO Escaped
    IF PAGE + 9 < ROOM OR ROOM < PAGE THEN GOTO LoadRoomPage
    SLOT = ROOM - PAGE + 1
    GOTO DrawRoom

' Split CMD$ into VERB$ and NOUN$ and dispatch on the verb.
DoCommand:                   ' @142D
    IF LEN(CMD$) > 2 THEN
        IF LEFT$(CMD$, 3) = "INV" THEN GOTO CmdInventory
    END IF
    IF CMD$ = "QUIT" THEN
        CLS
        LOCATE 2, 9
        PRINT "You've ended the game!"
        SCORE = 0
        W$ = ""
        GOTO FinalScore
    END IF
    NMSG = INSTR(CMD$, CHR$(32))
    IF LEN(CMD$) <= NMSG OR NMSG < 2 THEN
        CMD$ = ""
    ELSE
        VERB$ = LEFT$(CMD$, NMSG - 1)
        NOUN$ = RIGHT$(CMD$, LEN(CMD$) - NMSG)
        CMD$ = ""
        IF VERB$ = "EXAMINE" OR VERB$ = "SEARCH" OR VERB$ = "LOOK" THEN GOTO CmdLook
        IF VERB$ = "THROW" OR VERB$ = "DROP" THEN GOTO CmdDrop
        IF NOUN$ = "FLASK" AND VERB$ = "FILL" THEN
            VERB$ = "GET"
            IF ROOM = RM_WINE_CELLAR THEN
                NOUN$ = "WINE"
            ELSE
                NOUN$ = "WATER"
            END IF
        END IF
        IF VERB$ = "TAKE" OR VERB$ = "GET" THEN GOTO CmdGet
        IF VERB$ = "WEAR" THEN GOTO CmdWear
        IF VERB$ = "PLAY" THEN GOTO CmdPlay
        IF VERB$ = "WAVE" THEN GOTO CmdWave
        IF VERB$ = "CLEAN" OR VERB$ = "RUB" THEN GOTO CmdClean
        IF VERB$ = "SAY" THEN GOTO CmdSay
        IF VERB$ = "OPEN" THEN VERB$ = "UNLOCK"
        IF VERB$ = "CLOSE" THEN VERB$ = "LOCK"
        IF VERB$ = "CLOSE" OR VERB$ = "OPEN" OR VERB$ = "UNLOCK" OR VERB$ = "LOCK" THEN GOTO CmdLockUnlock
        IF VERB$ = "DRINK" THEN GOTO CmdDrink
        IF VERB$ = "EAT" THEN
            NMSG = 2
            MSG$(1) = " I'm not"
            MSG$(2) = " hungry!"
            GOTO ShowMessage
        END IF
        IF VERB$ = "READ" THEN GOTO CmdRead
        IF VERB$ = "LEEP" OR VERB$ = "JUMP" THEN GOTO CmdJump
        IF VERB$ = "POUR" THEN GOTO CmdPour
        IF VERB$ = "CLIMB" THEN
            NMSG = 2
            MSG$(1) = "I don't need"
            MSG$(2) = "to climb."
            GOTO ShowMessage
        END IF
        IF ROOM = RM_SORCERERS_QUARTERS THEN
            IF NOUN$ = "MIRROR" AND VERB$ = "MIRROR" THEN
                NMSG = 3
                MSG$(1) = " The wicked"
                MSG$(2) = "witch never"
                MSG$(3) = "lived here!!"
                GOTO ShowMessage
            END IF
        END IF
        IF VERB$ = "PET" THEN GOTO CmdPet
        IF VERB$ = "KILL" THEN GOTO CmdKill
        IF VERB$ = "SHOW" THEN GOTO CmdShow
        IF VERB$ = "SAVE" THEN GOTO CmdSave
        IF VERB$ = "LOAD" THEN GOTO CmdLoad
    END IF
    LOCATE 25, 26
    PRINT "What???";
    BEEP
    FOR I = 1 TO 500
    NEXT I
    LOCATE 25, 26
    PRINT "       ";
    GOTO InputLoop

' The player walked into something: an item (pick it up), a door, the
' gate, the vampire or fairy (blocked), or a monster (attack).
Bump:                        ' @1911
    FOR I = 1 TO NOBJECTS
        IF OBJCHAR(I) = CH THEN GOTO PickUpBumped
    NEXT I
    IF CH = CH_DOOR THEN
        SOUND 50, 1.5
        NMSG = 2
        MSG$(1) = "The Door is"
        MSG$(2) = "locked."
        GOTO ShowMessage
    END IF
    IF CH = CH_GATE THEN
        SOUND 50, 1
        NMSG = 2
        MSG$(1) = "The Gate is"
        MSG$(2) = "locked."
        GOTO ShowMessage
    END IF
    IF CH = CH_PLAYER THEN
        SOUND 50, 1
        NMSG = 4
        MSG$(1) = "The Vampire"
        MSG$(2) = "is blocking"
        MSG$(3) = "your way. He"
        MSG$(4) = "can't be hurt."
        GOTO ShowMessage
    END IF
    IF CH = CH_FAIRY THEN
        SOUND 50, 1
        NMSG = 4
        MSG$(1) = "The Fairy"
        MSG$(2) = "is blocking"
        MSG$(3) = "your way. He"
        MSG$(4) = "can't be hurt."
        GOTO ShowMessage
    END IF
    IF MONHERE <> 0 THEN
        FOR I = 1 TO NFIGHTERS
            IF MONCHAR(I) = CH THEN
                IF MONCOL(I) = NX AND MONROW(I) = NY THEN
                    TARGET = I
                    GOTO PlayerAttacks
                END IF
            END IF
        NEXT I
    END IF
    DEF SEG = 0                                              ' PEEK/POKE address BIOS memory
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead
    GOTO WaitKey

' Pick up the item walked into (limit 6 items).
PickUpBumped:                ' @1B42
    SOUND 500, 1
    IF NCARRY = 6 THEN
        NMSG = 2
        MSG$(1) = " Can't carry"
        MSG$(2) = " any more!"
        GOTO ShowMessage
    END IF
    NCARRY = NCARRY + 1
    OBJROOM(I) = CARRIED
    LOCATE NY, NX
    PRINT " ";
    GOTO WaitKey

' Print MSG$(1..NMSG) in the side panel and go back to the InputLoop.
ShowMessage:                 ' @1BD7
    FOR I = 13 TO 19
        LOCATE I, 26
        PRINT SPACE$(15);
    NEXT I
    N = NMSG
    FOR I = 1 TO N
        LOCATE I + 12, 26
        PRINT MSG$(I);
    NEXT I
    DEF SEG = 0                                              ' PEEK/POKE address BIOS memory
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead
    GOTO InputLoop

' Monster turn: every live monster 1-8 in this room takes a step.
MonsterTurn:                 ' @1CB8
    I = 1
    GOTO MonsterLoopTest

' Loop over monsters 1-8 (body is MonsterStep).
MonsterLoop:                 ' @1CC3
    IF MONHP(I) > -1 AND MONROOM(I) = ROOM THEN GOTO MonsterStep

MonsterNext:                 ' @1D02
    I = I + 1

MonsterLoopTest:             ' @1D0D
    IF I <= NFIGHTERS THEN GOTO MonsterLoop
    GOTO ReadKey

' Step one square toward the player (diagonals allowed) if that square
' is empty.  If the player is there, attack instead.
MonsterStep:                 ' @1D24
    MDY = 0
    MDX = 0
    IF MONROW(I) < PY THEN MDY = 1
    IF MONROW(I) > PY THEN MDY = -1
    IF MONCOL(I) < PX THEN MDX = 1
    IF MONCOL(I) > PX THEN MDX = -1
    T = SCREEN(MONROW(I) + MDY, MONCOL(I) + MDX)
    IF T <> CH_PLAYER THEN
        IF T <> CH_SPACE THEN GOTO MonsterNext
        LOCATE MONROW(I), MONCOL(I)
        PRINT CHR$(CH_SPACE);
        MONROW(I) = MONROW(I) + MDY
        MONCOL(I) = MONCOL(I) + MDX
        LOCATE MONROW(I), MONCOL(I)
        PRINT CHR$(MONCHAR(I));
        GOTO MonsterNext
    END IF
    ROLL = INT(RND * 100) + 1
    IF OBJROOM(OBJ_HELMET) = CARRIED THEN ROLL = ROLL - 10
    IF ROLL <= 40 THEN GOTO MonsterNext
    MN$ = MONNAME$(I)
    T = INSTR(MN$, " ")
    IF T > 0 THEN MN$ = RIGHT$(MN$, LEN(MN$) - T)
    NMSG = 2
    MSG$(1) = "The " + MN$
    MSG$(2) = "Struck you!"
    SOUND 150, 1
    SOUND 90, 0.5
    SOUND 40, 0.5
    STRENGTH = STRENGTH - INT(RND * 25) + 5                  ' as written: -5..+19 damage
    IF STRENGTH < 0 THEN
        NMSG = 2
        MSG$(1) = "The " + MN$
        MSG$(2) = "has Killed you!"
        GOTO PlayerDied
    END IF
    IF OBJROOM(OBJ_HELMET) = CARRIED THEN
        NMSG = 5
        MSG$(3) = ""
        MSG$(4) = "The Helmet"
        MSG$(5) = "helped."
    END IF
    GOTO ShowMessage

' The player hits monster TARGET: needs the sword, 50% to hit.
PlayerAttacks:               ' @20BF
    IF OBJROOM(OBJ_SWORD) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = "You have no"
        MSG$(2) = "Weapon!"
        GOTO ShowMessage
    END IF
    ROLL = INT(RND * 100) + 1
    IF ROLL <= 50 THEN GOTO InputLoop
    MN$ = MONNAME$(TARGET)
    T = INSTR(MN$, " ")
    IF T > 0 THEN MN$ = RIGHT$(MN$, LEN(MN$) - T)
    MONHP(TARGET) = MONHP(TARGET) - INT(RND * 25) + 5        ' as written: -5..+19 damage
    IF MONHP(TARGET) >= 0 THEN
        NMSG = 2
        MSG$(1) = "You struck"
        MSG$(2) = "the " + MN$ + "!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = "You Killed"
    MSG$(2) = "the " + MN$ + "!"
    MONHERE = 0
    MONNAME$(TARGET) = "Dead " + MN$
    FOR I = 1 TO NFIGHTERS
        IF MONHP(I) > -1 AND MONROOM(I) = ROOM THEN MONHERE = 1
    NEXT I
    GOTO ShowMessage

' LOOK / EXAMINE / SEARCH: objects first, then furniture, then monsters.
CmdLook:                     ' @22EA
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO LookObject
    NEXT I
    IF NOUN$ = "TABLE" THEN GOTO CmdLookTable
    IF NOUN$ = "DESK" THEN GOTO CmdLookDesk
    IF NOUN$ = "BEDS" OR NOUN$ = "BED" THEN GOTO CmdLookBed
    IF NOUN$ = "SHELVES" OR NOUN$ = "SHELF" THEN GOTO CmdLookShelf
    IF NOUN$ = "THRONE" THEN GOTO CmdLookThrone
    IF NOUN$ = "FOUNTAIN" THEN GOTO CmdLookFountain
    IF NOUN$ = "STATUE" THEN GOTO CmdLookStatue
    IF NOUN$ = "MIRROR" THEN GOTO CmdLookMirror
    IF NOUN$ = "BARRELS" OR NOUN$ = "BARREL" THEN GOTO CmdLookBarrel
    IF NOUN$ = "CHAINS" OR NOUN$ = "CHAIN" THEN GOTO CmdLookChain
    IF NOUN$ = "ARCHWAYS" OR NOUN$ = "ARCHWAY" OR NOUN$ = "CEILING" OR NOUN$ = "FLOOR" OR NOUN$ = "ROOF" OR NOUN$ = "WALL" OR NOUN$ = "WALLS" THEN GOTO CmdLookWalls
    IF NOUN$ = "GARDENS" OR NOUN$ = "GARDEN" THEN GOTO CmdLookGarden
    IF NOUN$ = "STAIRCASE" OR NOUN$ = "STAIR" OR NOUN$ = "STAIRS" THEN GOTO CmdLookStairs
    IF NOUN$ = "BALCONY" THEN GOTO CmdLookBalcony
    IF ROOM = RM_COURTYARD AND NOUN$ = "GATE" THEN
        NMSG = 2
        MSG$(1) = " It looks"
        MSG$(2) = " very Strong."
        GOTO ShowMessage
    END IF
    IF NOUN$ = "DOOR" THEN
        IF ROOM = RM_WINE_CELLAR OR ROOM = RM_DUNGEON_HALL THEN
            NMSG = 2
            MSG$(1) = " It looks"
            MSG$(2) = " very Strong."
            GOTO ShowMessage
        END IF
    END IF
    FOR I = 1 TO NMONSTERS
        W$ = MONNAME$(I)
        T = INSTR(W$, CHR$(32))
        IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)
        IF MONROOM(I) = ROOM AND NOUN$ = W$ THEN GOTO LookMonster
    NEXT I
    NMSG = 5
    MSG$(1) = "I can't see"
    MSG$(2) = "a " + NOUN$ + ","
    MSG$(3) = "and I don't"
    MSG$(4) = "have a"
    MSG$(5) = NOUN$ + "!"
    GOTO ShowMessage

' Describe a monster in the room.
LookMonster:                 ' @2756
    IF MONHP(I) > 0 AND I < MON_FAIRY THEN
        NMSG = 2
        MSG$(1) = "The " + W$
        MSG$(2) = "looks Mean!"
        GOTO ShowMessage
    END IF
    IF MONHP(I) < 1 AND I < MON_FAIRY THEN
        NMSG = 2
        MSG$(1) = "The " + W$
        MSG$(2) = "looks Dead!"
        GOTO ShowMessage
    END IF
    NMSG = 3
    MSG$(1) = " The " + W$
    MSG$(2) = " looks pretty"
    MSG$(3) = " but unhappy."
    GOTO ShowMessage

' Describe object I (only if carried): one line per object via ON I GOTO.
LookObject:                  ' @2854
    IF OBJROOM(I) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = " You Don't"
        MSG$(2) = " Have it!"
        GOTO ShowMessage
    END IF
    ON I GOTO DescLamp, DescHarp, DescNecklace, DescBook, DescWand, DescSword, DescKey, DescGlasses, DescBall, DescHelmet, DescFlask, DescHarp, DescDiamond, DescBars, DescBars, DescDiamond, DescDiamond, DescHarp, DescDiamond, DescDiamond, DescHarp, DescHarp

DescLamp:                    ' @28CE
    NMSG = 2
    MSG$(1) = " It's lit"
    MSG$(2) = " Magically"
    GOTO ShowMessage

DescNecklace:                ' @28F2
    NMSG = 5
    MSG$(1) = " On the back"
    MSG$(2) = " it says:"
    MSG$(4) = "Protection from"
    MSG$(5) = "Traps."
    MSG$(3) = ""
    GOTO ShowMessage

DescBook:                    ' @2937
    NMSG = 2
    MSG$(1) = " It is titled"
    MSG$(2) = "  `The Gate'"
    GOTO ShowMessage

DescWand:                    ' @295B
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Magical!"
    GOTO ShowMessage

DescSword:                   ' @297F
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Sharp!"
    GOTO ShowMessage

DescKey:                     ' @29A3
    NMSG = 1
    MSG$(1) = " It looks Old!"
    GOTO ShowMessage

DescGlasses:                 ' @29BC
    NMSG = 2
    MSG$(1) = " They're"
    MSG$(2) = " Bifocals"
    GOTO ShowMessage

DescBall:                    ' @29E0
    NMSG = 7
    MSG$(4) = " You see a man"
    MSG$(5) = "in a winding"
    MSG$(6) = "passage,waving"
    MSG$(7) = "a Wand."
    MSG$(1) = "In the Cyrstal"
    MSG$(2) = "Ball...."
    MSG$(3) = ""
    GOTO ShowMessage

DescHelmet:                  ' @2A3B
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Tough!"
    GOTO ShowMessage

DescFlask:                   ' @2A5F
    IF FLASKFULL = 0 THEN
        NMSG = 1
        MSG$(1) = " It's empty."
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " It's filled"
    MSG$(2) = " with water."
    GOTO ShowMessage

DescHarp:                    ' @2AA9
    NMSG = 2
    MSG$(1) = " It's made of"
    MSG$(2) = " Gold!"
    GOTO ShowMessage

DescDiamond:                 ' @2ACD
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Expensive!"
    GOTO ShowMessage

DescBars:                    ' @2AF1
    NMSG = 2
    MSG$(1) = " They look"
    MSG$(2) = " Expensive!"
    GOTO ShowMessage

CmdLookTable:                ' @2B15
    IF ROOM = RM_KITCHEN THEN
        NMSG = 2
        MSG$(1) = " It's made of"
        MSG$(2) = " Stone."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_TORTURE_ROOM THEN
        NMSG = 2
        MSG$(1) = " It's covered"
        MSG$(2) = " with Blood!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a Table."
    GOTO ShowMessage

CmdLookDesk:                 ' @2BA1
    IF OBJROOM(OBJ_FLASK) = HIDDEN + RM_CHEFS_QUARTERS AND ROOM = RM_CHEFS_QUARTERS THEN
        NMSG = 3
        MSG$(1) = " There is a"
        MSG$(2) = " Wine Flask"
        MSG$(3) = " on top."
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_GLASSES) = HIDDEN + RM_YELLOW_ROOM AND ROOM = RM_YELLOW_ROOM THEN
        NMSG = 4
        MSG$(1) = " There is a"
        MSG$(2) = " Pair of Eye"
        MSG$(3) = " Glasses on"
        MSG$(4) = " Top."
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_KEY) = HIDDEN + RM_KINGS_STUDY AND ROOM = RM_KINGS_STUDY THEN
        NMSG = 2
        MSG$(1) = " There is a"
        MSG$(2) = " Key on top"
        GOTO ShowMessage
    END IF
    IF ROOM = RM_KINGS_STUDY OR ROOM = RM_YELLOW_ROOM OR ROOM = RM_CHEFS_QUARTERS THEN
        NMSG = 2
        MSG$(1) = " It's made"
        MSG$(2) = " of Wood."
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a desk!"
    GOTO ShowMessage

CmdLookBed:                  ' @2D32
    NMSG = 1
    IF ROOM = RM_RED_ROOM AND NOUN$ = "BEDS" THEN
        MSG$(1) = " They're Red."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_BLUE_ROOM AND NOUN$ = "BEDS" THEN
        MSG$(1) = " They're Blue."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_SORCERERS_QUARTERS AND NOUN$ = "BEDS" THEN
        MSG$(1) = " They're Old."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_SORCERERS_QUARTERS OR ROOM = RM_CHEFS_QUARTERS THEN
        MSG$(1) = " It's Old."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_RED_ROOM THEN
        MSG$(1) = " It's Red."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_BLUE_ROOM THEN
        MSG$(1) = " It's Blue."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_PURPLE_ROOM THEN
        MSG$(1) = " It's Purple."
        GOTO ShowMessage
    END IF
    IF ROOM = RM_YELLOW_ROOM THEN
        MSG$(1) = " It's Yellow."
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ = "BEDS" THEN
        MSG$(2) = " any Beds."
    ELSE
        MSG$(2) = " a Bed."
    END IF
    GOTO ShowMessage

CmdLookShelf:                ' @2ED8
    IF OBJROOM(OBJ_BOOK) = HIDDEN + RM_LIBRARY_WEST AND ROOM = RM_LIBRARY_WEST THEN
        IF OBJROOM(OBJ_BOOK) = HIDDEN + RM_LIBRARY_WEST THEN
            NMSG = 2
            MSG$(1) = "There's a book"
            IF NOUN$ = "SHELF" THEN
                MSG$(2) = "on it."
                GOTO ShowMessage
            END IF
            MSG$(2) = "on one."
            GOTO ShowMessage
        END IF
    END IF
    IF ROOM = RM_LIBRARY_EAST OR ROOM = RM_STORAGE OR ROOM = RM_LIBRARY_WEST THEN
        NMSG = 2
        MSG$(1) = " They're made"
        MSG$(2) = " of wood."
        GOTO ShowMessage
    END IF
    NMSG = 1
    MSG$(1) = " I don't see"
    IF NOUN$ = "SHELF" THEN
        MSG$(2) = " one."
    ELSE
        MSG$(2) = " any."
    END IF
    GOTO ShowMessage

CmdLookStairs:               ' @2FF3
    T = INSTR(ROOM$(19, SLOT), "U")
    T2 = INSTR(ROOM$(19, SLOT), "D")
    IF T2 = 0 AND T > 0 THEN
        NMSG = 2
        MSG$(1) = " The Staircase"
        MSG$(2) = " leads up."
        GOTO ShowMessage
    END IF
    IF T = 0 AND T2 > 0 THEN
        NMSG = 2
        MSG$(1) = " The Staircase"
        MSG$(2) = " leads down."
        GOTO ShowMessage
    END IF
    IF T2 > 0 AND T > 0 THEN
        NMSG = 3
        MSG$(1) = " The Staircase"
        MSG$(2) = " leads both"
        MSG$(3) = " up & Down."
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ = "STAIRS" THEN
        MSG$(2) = " any stairs!"
    ELSE
        MSG$(2) = " a staircase!"
    END IF
    GOTO ShowMessage

CmdLookThrone:               ' @315B
    IF ROOM <> RM_THRONE_ROOM THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        MSG$(2) = " A throne!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " The throne is"
    MSG$(2) = " made of stone."
    GOTO ShowMessage

CmdLookFountain:             ' @31B3
    IF ROOM <> RM_GARDEN_SOUTH THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        MSG$(2) = " A fountain!"
        GOTO ShowMessage
    END IF
    NMSG = 5
    MSG$(1) = "The fountain"
    MSG$(2) = "is filled"
    MSG$(3) = "with water.But"
    MSG$(4) = "you can't see"
    MSG$(5) = "In it."
    GOTO ShowMessage

CmdLookStatue:               ' @322C
    IF ROOM <> RM_UPPER_HALL THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        MSG$(2) = " A Statue!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_NECKLACE) = HIDDEN + RM_UPPER_HALL THEN
        NMSG = 3
        MSG$(1) = " The statue is"
        MSG$(2) = " wearing a"
        MSG$(3) = " Necklace"
        GOTO ShowMessage
    END IF
    NMSG = 3
    MSG$(1) = " The Statue"
    MSG$(2) = " looks like"
    MSG$(3) = " The King!"
    GOTO ShowMessage

CmdLookMirror:               ' @32CE
    IF ROOM <> RM_SORCERERS_QUARTERS THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        MSG$(2) = " A Mirror!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Magical!"
    GOTO ShowMessage

CmdLookBarrel:               ' @3326
    IF ROOM <> RM_WINE_CELLAR THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        IF NOUN$ = "BARRELS" THEN
            MSG$(2) = " any Barrels!"
        ELSE
            MSG$(2) = " a Barrel!"
        END IF
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(2) = " Old!"
    IF NOUN$ = "BARRELS" THEN
        MSG$(1) = " They look"
    ELSE
        MSG$(1) = " It looks"
    END IF
    GOTO ShowMessage

CmdLookChain:                ' @33BA
    IF ROOM <> RM_TORTURE_ROOM THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        IF NOUN$ = "CHAINS" THEN
            MSG$(2) = " any Chains!"
        ELSE
            MSG$(2) = " a Chain!"
        END IF
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(2) = " Magical!"
    IF NOUN$ = "CHAINS" THEN
        MSG$(1) = " They look"
    ELSE
        MSG$(1) = " It looks"
    END IF
    GOTO ShowMessage

CmdLookWalls:                ' @344E
    IF ROOM = RM_MAZE_WALL THEN
        NMSG = 3
        MSG$(1) = "The Wall Says:"
        MSG$(2) = "Kevin Bales"
        MSG$(3) = "was Here!"
        GOTO ShowMessage
    END IF
    IF ROOM = RM_KINGS_SECRET_ROOM THEN
        NMSG = 2
        MSG$(1) = "The walls are"
        MSG$(2) = "many Colors!"
        GOTO ShowMessage
    END IF
    IF ROOM = RM_COURTYARD THEN
        IF NOUN$ = "WALLS" OR NOUN$ = "WALL" THEN GOTO HighScoreWall
    END IF
    IF NOUN$ = "WALLS" THEN NOUN$ = "WALL"
    IF NOUN$ = "ARCHWAYS" THEN NOUN$ = "ARCHWAY"
    NMSG = 3
    MSG$(1) = "The " + NOUN$ + "S"
    MSG$(2) = "are made of"
    MSG$(3) = "Gray Stone."
    GOTO ShowMessage

CmdLookGarden:               ' @356B
    IF ROOM <> RM_BALCONY THEN
        NMSG = 2
        MSG$(1) = " I Don't see"
        MSG$(2) = " A Garden!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_GEM) <> HIDDEN + RM_GARDEN_SOUTH THEN
        NMSG = 3
        MSG$(1) = "The Garden"
        MSG$(2) = "Has A Fountain"
        MSG$(3) = "in the middle."
        GOTO ShowMessage
    END IF
    NMSG = 4
    MSG$(1) = " There is a"
    MSG$(2) = " BIG Gem in "
    MSG$(3) = " the Garden"
    MSG$(4) = " Fountain!"
    GOTO ShowMessage

CmdLookBalcony:              ' @3618
    IF ROOM <> RM_BALCONY THEN
        NMSG = 2
        MSG$(1) = "I don't see"
        MSG$(2) = "a Balcony!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = "The balcony is"
    MSG$(2) = "made of stone."
    GOTO ShowMessage

' DROP / THROW: put a carried object on the square in front of the player.
CmdDrop:                     ' @3670
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF OBJROOM(I) = CARRIED AND NOUN$ = W$ THEN GOTO DropHere
    NEXT I
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$
    GOTO ShowMessage

DropHere:                    ' @3769
    T = SCREEN(PY + DY, PX + DX)
    IF T = CH_SPACE THEN
        IF PX + DX >= 1 AND PY + DY >= 1 THEN
            NCARRY = NCARRY - 1
            OBJROOM(I) = ROOM
            OBJROW(I) = PY + DY
            OBJCOL(I) = PX + DX
            LOCATE OBJROW(I), OBJCOL(I)
            PRINT CHR$(OBJCHAR(I));
            SOUND 150, 1
            NMSG = 1
            MSG$(1) = " Done."
            GOTO ShowMessage
        END IF
    END IF
    NMSG = 2
    MSG$(1) = " Something is"
    MSG$(2) = " in the way!"
    GOTO ShowMessage

' GET / TAKE: objects, liquids, and refusals for furniture and monsters.
CmdGet:                      ' @38D5
    IF NOUN$ = "BLOOD" THEN
        NMSG = 1
        MSG$(1) = "Yuc!!"
        GOTO ShowMessage
    END IF
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO GetObject
    NEXT I
    IF NOUN$ = "BARRELS" OR NOUN$ = "SHELVES" OR NOUN$ = "BEDS" OR NOUN$ = "MIRROR" OR NOUN$ = "BARREL" OR NOUN$ = "STATUE" OR NOUN$ = "FOUNTAIN" OR NOUN$ = "THRONE" OR NOUN$ = "SHELF" OR NOUN$ = "BED" OR NOUN$ = "DESK" OR NOUN$ = "TABLE" THEN GOTO TooHeavy
    IF NOUN$ = "CHAINS" OR NOUN$ = "CHAIN" THEN
        IF ROOM = RM_TORTURE_ROOM THEN
            NMSG = 3
            MSG$(1) = " They're"
            MSG$(2) = " Connected to"
            MSG$(3) = " the wall."
            GOTO ShowMessage
        END IF
    END IF
    IF NOUN$ = "WATER" OR NOUN$ = "WINE" THEN GOTO GetLiquid
    I = 1
    GOTO GetMonsterLoopTest

GetMonsterLoop:              ' @3B06
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)

GetMonsterCheck:             ' @3B6F
    IF MONROOM(I) = ROOM AND W$ = NOUN$ THEN
        NMSG = 3
        MSG$(1) = "I don't think"
        MSG$(2) = "that would be"
        MSG$(3) = "very safe!"
        GOTO ShowMessage
    END IF
    I = I + 1

GetMonsterLoopTest:          ' @3BE3
    IF I <= 10 THEN GOTO GetMonsterLoop
    NMSG = 1
    MSG$(1) = "Impossible!!"
    GOTO ShowMessage

TooHeavy:                    ' @3C13
    NMSG = 2
    IF RIGHT$(NOUN$, 1) = "S" THEN
        MSG$(1) = NOUN$
    ELSE
        MSG$(1) = NOUN$ + "S"
    END IF
    MSG$(2) = "are too heavy!"
    IF NOUN$ = "TABLE" THEN
        IF ROOM = RM_TORTURE_ROOM OR ROOM = RM_KITCHEN THEN GOTO ShowMessage
    END IF
    IF NOUN$ = "DESK" THEN
        IF ROOM = RM_KINGS_STUDY OR ROOM = RM_YELLOW_ROOM OR ROOM = RM_CHEFS_QUARTERS THEN GOTO ShowMessage
    END IF
    IF NOUN$ = "BEDS" OR NOUN$ = "BED" THEN
        IF ROOM = RM_SORCERERS_QUARTERS OR ROOM = RM_YELLOW_ROOM OR ROOM = RM_PURPLE_ROOM OR ROOM = RM_BLUE_ROOM OR ROOM = RM_RED_ROOM OR ROOM = RM_CHEFS_QUARTERS THEN GOTO ShowMessage
    END IF
    IF NOUN$ = "SHELVES" OR NOUN$ = "SHELF" THEN
        IF ROOM = RM_LIBRARY_EAST OR ROOM = RM_LIBRARY_WEST OR ROOM = RM_STORAGE THEN GOTO ShowMessage
    END IF
    IF ROOM = RM_THRONE_ROOM AND NOUN$ = "THRONE" THEN GOTO ShowMessage
    IF ROOM = RM_GARDEN_SOUTH AND NOUN$ = "FOUNTAIN" THEN GOTO ShowMessage
    IF ROOM = RM_UPPER_HALL AND NOUN$ = "STATUE" THEN GOTO ShowMessage
    IF NOUN$ = "BARRELS" OR NOUN$ = "BARREL" THEN
        IF ROOM = RM_WINE_CELLAR THEN GOTO ShowMessage
    END IF
    IF NOUN$ = "CHAINS" OR NOUN$ = "CHAIN" THEN
        IF ROOM = RM_TORTURE_ROOM THEN GOTO ShowMessage
    END IF
    IF ROOM = RM_SORCERERS_QUARTERS AND NOUN$ = "MIRROR" THEN GOTO ShowMessage
    NMSG = 4
    MSG$(3) = "and I don't"
    MSG$(4) = "see any!"
    GOTO ShowMessage

' GET a hidden object: it must be in this room (room+100) and the player
' must stand next to the furniture it is hidden in.
GetObject:                   ' @3F61
    IF OBJROOM(I) = ROOM THEN
        NMSG = 2
        MSG$(1) = " Get it"
        MSG$(2) = " Yourself!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(I) = CARRIED THEN
        NMSG = 2
        MSG$(1) = " You already"
        MSG$(2) = " have it!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(I) <> HIDDEN + ROOM THEN
        NMSG = 2
        MSG$(1) = " I don't see"
        MSG$(2) = " a " + NOUN$
        GOTO ShowMessage
    END IF
    FOR J = -1 TO 1
        FOR K = -1 TO 1
            IF PX + K <= 18 AND PY + J <= 24 THEN
                T = SCREEN(PY + J, PX + K)
                IF OBJCOL(I) = T OR OBJROW(I) = T THEN GOTO TakeHidden
            END IF
        NEXT K
    NEXT J
    NMSG = 2
    MSG$(1) = " I can't"
    MSG$(2) = " reach it!"
    GOTO ShowMessage

TakeHidden:                  ' @4164
    IF NCARRY = 6 THEN GOTO PickUpBumped
    NCARRY = NCARRY + 1
    OBJROOM(I) = CARRIED
    SOUND 500, 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO ShowMessage

' GET WATER (fills the flask at the fountain) or GET WINE.
GetLiquid:                   ' @41C5
    IF NOUN$ = "WINE" THEN
        IF ROOM = RM_WINE_CELLAR THEN
            NMSG = 2
            MSG$(1) = " The Barrels"
            MSG$(2) = " are empty."
            GOTO ShowMessage
        END IF
        GOTO GetMonsterCheck
    END IF
    IF ROOM <> RM_GARDEN_SOUTH THEN GOTO GetMonsterCheck
    IF OBJROOM(OBJ_FLASK) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = "You don't have"
        MSG$(2) = "a Container!"
        GOTO ShowMessage
    END IF
    IF FLASKFULL = 1 THEN
        NMSG = 2
        MSG$(1) = "The flask is"
        MSG$(2) = "full!"
        GOTO ShowMessage
    END IF
    FOR I = -1 TO 1
        FOR J = -1 TO 1
            IF PX = 24 OR PY = 18 OR PX + J < 1 OR PY + I < 1 THEN
            END IF
            T = SCREEN(PY + I, PX + J)
            IF T = CH_HLINE OR T = CH_VLINE THEN
                FLASKFULL = 1
                NMSG = 1
                MSG$(1) = "Done."
                GOTO ShowMessage
            END IF
        NEXT J
    NEXT I
    NMSG = 2
    MSG$(1) = " I can't"
    MSG$(2) = " reach it!"
    GOTO ShowMessage

' INV...: list carried objects.
CmdInventory:                ' @43E5
    NMSG = 1
    MSG$(1) = "- Inventory -"
    FOR I = 1 TO NOBJECTS
        IF OBJROOM(I) = CARRIED THEN
            NMSG = NMSG + 1
            MSG$(NMSG) = CHR$(OBJCHAR(I)) + " " + OBJNAME$(I)
        END IF
        IF NMSG = 7 THEN GOTO InventoryDone
    NEXT I

InventoryDone:               ' @44AE
    IF NMSG = 1 THEN
        NMSG = 3
        MSG$(2) = ""
        MSG$(3) = "   Nothing."
    END IF
    CMD$ = ""
    GOTO ShowMessage

' WEAR: helmet, necklace, glasses (flavour text only).
CmdWear:                     ' @44EC
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO WearIt
    NEXT I
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

WearIt:                      ' @45C7
    IF OBJROOM(I) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = " You don't"
        MSG$(2) = " have it!"
        GOTO ShowMessage
    END IF
    IF I = OBJ_HELMET OR I = OBJ_NECKLACE THEN
        NMSG = 2
        MSG$(1) = "Ok."
        MSG$(2) = "I'm wearing it."
        GOTO ShowMessage
    END IF
    IF I = OBJ_CROWN THEN
        NMSG = 2
        MSG$(1) = " The crown is"
        MSG$(2) = " too Heavy!"
        GOTO ShowMessage
    END IF
    IF I = OBJ_GLASSES THEN
        NMSG = 3
        MSG$(1) = " Ok."
        MSG$(2) = " I'm wearing"
        MSG$(3) = " them."
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = "That could be"
    MSG$(2) = "Difficult!"
    GOTO ShowMessage

' PLAY HARP: music; drives the fairy away if it is here.
CmdPlay:                     ' @46EA
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO PlayIt
    NEXT I
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

PlayIt:                      ' @47C5
    IF OBJROOM(I) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = " You don't"
        MSG$(2) = " have it!"
        GOTO ShowMessage
    END IF
    IF I <> OBJ_HARP THEN
        NMSG = 3
        MSG$(1) = "The " + NOUN$
        MSG$(2) = "makes Horrible"
        MSG$(3) = "music!!"
        GOTO ShowMessage
    END IF
    PLAY "MB O3 L24 C D E F# G# A# O4 C O3 A# G# F# E D C6"
    NMSG = 3
    MSG$(1) = "The Harp makes"
    MSG$(2) = "Beautiful"
    MSG$(3) = "Music!"
    IF MONROOM(MON_FAIRY) <> ROOM THEN GOTO ShowMessage
    LOCATE MONROW(MON_FAIRY), MONCOL(MON_FAIRY)
    PRINT CHR$(CH_SPACE);
    MONROOM(MON_FAIRY) = RM_NONE
    NMSG = 6
    MSG$(4) = "The fairy"
    MSG$(5) = "likes the music"
    MSG$(6) = "and leaves!"
    GOTO ShowMessage

' WAVE: wand (secret passages in rooms 67/77), cross (vampire),
' scepter (opens the gate in room 1).
CmdWave:                     ' @48F6
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO WaveIt
    NEXT I

DontHaveIt:                  ' @499C
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

WaveIt:                      ' @49D1
    IF OBJROOM(I) <> CARRIED THEN GOTO DontHaveIt
    IF I <> OBJ_WAND THEN
        IF ROOM = RM_VAMPIRE_CORRIDOR AND I = OBJ_CROSS THEN
            NMSG = 4
            MSG$(1) = "The vampire"
            MSG$(2) = "sees the holy"
            MSG$(3) = "cross and"
            MSG$(4) = "disappears!"
            LOCATE MONROW(MON_VAMPIRE), MONCOL(MON_VAMPIRE)
            PRINT CHR$(CH_SPACE);
            MONROOM(MON_VAMPIRE) = RM_NONE
            GOTO ShowMessage
        END IF
        IF I = OBJ_SCEPTER THEN GOTO WaveScepter
        NMSG = 3
        MSG$(1) = "You look awful"
        MSG$(2) = "Silly waving"
        MSG$(3) = "that " + NOUN$
        GOTO ShowMessage
    END IF
    NMSG = 5
    MSG$(1) = "As you wave the"
    MSG$(2) = NOUN$ + "...."
    MSG$(3) = ""
    MSG$(4) = "  Nothing"
    MSG$(5) = "  Happens!"
    IF ROOM <> RM_SORCERERS_QUARTERS AND ROOM <> RM_WINDING_PASSAGE THEN GOTO ShowMessage
    IF ROOM = RM_WINDING_PASSAGE THEN GOTO WaveWandRoom77
    FOR I = 7 TO 12
        LOCATE I, 19
        PRINT " ";
    NEXT I
    LOCATE 8, 20
    PRINT "▓▓▓▓▓"
    LOCATE 11, 20
    PRINT "▓▓▓▓▓"
    LOCATE 9, 20
    PRINT " ";
    LOCATE 10, 20
    PRINT " ";

SecretPassage:               ' @4C24
    NMSG = 7
    MSG$(4) = "  There is a"
    MSG$(5) = "*Puff* of smoke"
    MSG$(6) = "Revealing a"
    MSG$(7) = "Secret passage!"
    GOTO ShowMessage

WaveWandRoom77:              ' @4C5E
    IF SCREEN(18, 12) = CH_SPACE THEN GOTO ShowMessage
    LOCATE 18, 11
    PRINT "▌  ▐";
    GOTO SecretPassage

WaveScepter:                 ' @4C94
    IF ROOM <> RM_COURTYARD THEN
        NMSG = 5
        MSG$(1) = "As you wave the"
        MSG$(2) = NOUN$ + "...."
        MSG$(3) = ""
        MSG$(4) = "  Nothing"
        MSG$(5) = "  Happens!"
        GOTO ShowMessage
    END IF
    LOCATE 18, 11
    PRINT "    ";
    NMSG = 5
    MSG$(1) = "As you wave the"
    MSG$(2) = "scepter..."
    MSG$(3) = ""
    MSG$(4) = "The Gate opens"
    MSG$(5) = "by itself!"
    GOTO ShowMessage

' CLEAN / RUB: flavour text.
CmdClean:                    ' @4D53
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        NMSG = INSTR(W$, CHR$(32))
        IF NMSG > 0 THEN W$ = RIGHT$(W$, LEN(W$) - NMSG)
        IF NOUN$ = W$ THEN GOTO CleanIt
    NEXT I
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

CleanIt:                     ' @4E2E
    IF OBJROOM(I) <> CARRIED THEN GOTO DontHaveIt
    IF I = OBJ_LAMP THEN
        NMSG = 3
        MSG$(1) = " There's no"
        MSG$(2) = " Genii in this"
        MSG$(3) = " Lamp!"
        GOTO ShowMessage
    END IF
    NMSG = 2
    MSG$(1) = "The " + NOUN$
    MSG$(2) = "is cleaner now."
    GOTO ShowMessage

' SAY: echo the word; monsters look at you funny.
CmdSay:                      ' @4EB5
    NMSG = 1
    MSG$(1) = CHR$(34) + NOUN$ + CHR$(34)

MonstersReact:               ' @4EEA
    FOR I = 1 TO NMONSTERS
        IF MONROOM(I) = ROOM THEN GOTO MonsterLooksFunny
    NEXT I
    GOTO ShowMessage

MonsterLooksFunny:           ' @4F36
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)
    MSG$(2) = ""
    MSG$(3) = "The " + W$
    MSG$(4) = "looks at you"
    MSG$(5) = "Funny!"
    NMSG = 5
    GOTO ShowMessage

' OPEN / UNLOCK / CLOSE / LOCK the doors in rooms 68 and 82 (needs the key).
CmdLockUnlock:               ' @4FE1
    IF OBJROOM(OBJ_KEY) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = " You don't"
        MSG$(2) = " have a Key!"
        GOTO ShowMessage
    END IF
    IF NOUN$ <> "DOOR" THEN
        IF NOUN$ <> "GATE" THEN
            NMSG = 1
            MSG$(1) = "Impossible!!"
            GOTO ShowMessage
        END IF
        IF ROOM <> RM_COURTYARD THEN
            NMSG = 2
            MSG$(1) = " I don't see"
            MSG$(2) = " a Gate!"
            GOTO ShowMessage
        END IF
        NMSG = 3
        MSG$(1) = " The Gate"
        IF VERB$ = "UNLOCK" THEN
            MSG$(2) = " is locked"
            MSG$(3) = " Magically."
            GOTO ShowMessage
        END IF
        MSG$(2) = " is already"
        MSG$(3) = " locked!"
        GOTO ShowMessage
    END IF
    IF ROOM <> RM_DUNGEON_HALL AND ROOM <> RM_WINE_CELLAR THEN
        NMSG = 2
        MSG$(1) = "I don't see"
        MSG$(2) = "a door!"
        GOTO ShowMessage
    END IF
    IF VERB$ <> "LOCK" THEN
        FOR I = -1 TO 1
            FOR J = -1 TO 1
                IF PX + J >= 1 AND PY + I >= 1 THEN
                    IF SCREEN(PY + I, PX + J) = CH_DOOR THEN GOTO DoorRoom68
                END IF
            NEXT J
        NEXT I
        NMSG = 2
        MSG$(1) = " I can't"
        MSG$(2) = " reach it!"
        GOTO ShowMessage
    END IF

DoorRoom68:                  ' @521F
    IF ROOM <> RM_DUNGEON_HALL THEN
        IF VERB$ = "LOCK" THEN
            LOCATE 15, 9
            PRINT CHR$(CH_DOOR);CHR$(CH_DOOR);
            DOOR68LOCKED = 1
            NMSG = 1
            MSG$(1) = "Done."
            SOUND 50, 1
            GOTO ShowMessage
        END IF
        LOCATE PY, PX
        PRINT CHR$(UNDER);
        IF PY > 15 THEN
            PY = 16
        ELSE
            PY = 14
        END IF
        PX = 9
        LOCATE PY, PX
        PRINT CHR$(CH_PLAYER);
        LOCATE 15, 9
        PRINT "  ";
        DOOR68LOCKED = 0
        SOUND 50, 1
        NMSG = 1
        MSG$(1) = "Done."
        GOTO ShowMessage
    END IF
    IF VERB$ = "LOCK" THEN
        LOCATE 9, 14
        PRINT CHR$(CH_DOOR)
        LOCATE 10, 14
        PRINT CHR$(CH_DOOR);
        DOOR82LOCKED = 1
        NMSG = 1
        MSG$(1) = "Done."
        SOUND 50, 1
        GOTO ShowMessage
    END IF
    LOCATE PY, PX
    PRINT CHR$(UNDER);
    IF PX < 14 THEN
        PX = 13
    ELSE
        PX = 15
    END IF
    PY = 9
    LOCATE PY, PX
    PRINT CHR$(CH_PLAYER);
    LOCATE 9, 14
    PRINT " ";
    LOCATE 10, 14
    PRINT " ";
    DOOR82LOCKED = 0
    SOUND 50, 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO ShowMessage

' READ BOOK: needs the eye glasses.
CmdRead:                     ' @5509
    IF NOUN$ <> "BOOK" THEN
        NMSG = 2
        MSG$(1) = " You can't"
        MSG$(2) = " read That!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_BOOK) <> CARRIED THEN
        NMSG = 2
        MSG$(1) = " You don't"
        MSG$(2) = " have a book!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_GLASSES) <> CARRIED THEN
        NMSG = 4
        MSG$(1) = " You can't see"
        MSG$(2) = " well enough."
        MSG$(3) = " It's all"
        MSG$(4) = " Blurry."
        GOTO ShowMessage
    END IF
    NMSG = 3
    MSG$(1) = "The book reads:"
    MSG$(2) = ""
    MSG$(3) = "  Wave Scepter"
    GOTO ShowMessage

' JUMP / LEEP: flavour text.
CmdJump:                     ' @55E4
    IF NOUN$ = "DOWN" THEN
        IF ROOM = RM_EAST_TOWER_TOP OR ROOM = RM_WEST_TOWER_TOP OR ROOM = RM_BALCONY THEN
            NMSG = 3
            MSG$(1) = " I don't think"
            MSG$(2) = " it's safe to"
            MSG$(3) = " Jump here!"
            GOTO ShowMessage
        END IF
    END IF
    NMSG = 3
    MSG$(1) = "I Jumped."
    MSG$(2) = ""
    MSG$(3) = "This is boring."
    GOTO ShowMessage

' Trap: the room fills with water (animated) and the player drowns.
TrapRoom76:                  ' @568A
    LOCATE 13, 11
    PRINT "▓";
    LOCATE 14, 11
    PRINT "▓";
    LOCATE 13, 17
    PRINT "▓";
    LOCATE 14, 17
    PRINT "▓";
    FOR I = 12 TO 16
        FOR J = 1 TO 200
        NEXT J
        LOCATE 13, I
        PRINT "░";
        LOCATE 14, I
        PRINT "░";
    NEXT I

' Death message for the traps.
Drowned:                     ' @579A
    NMSG = 5
    MSG$(1) = "You have sprung"
    MSG$(2) = "a Trap!! The"
    MSG$(3) = "room has filled"
    MSG$(4) = "with water and"
    MSG$(5) = "you drowned!"
    GOTO PlayerDied

' Same trap in room 78.
TrapRoom78:                  ' @57DF
    LOCATE 9, 12
    PRINT "▓";
    LOCATE 9, 24
    PRINT "▓";
    LOCATE 10, 12
    PRINT "▓";
    LOCATE 10, 24
    PRINT "▓";
    FOR I = 13 TO 23
        FOR J = 1 TO 200
        NEXT J
        LOCATE 9, I
        PRINT "░";
        LOCATE 10, I
        PRINT "░";
    NEXT I
    GOTO Drowned

' DRINK WATER: restores STRENGTH to 100, once.
CmdDrink:                    ' @58F2
    IF NOUN$ <> "WATER" THEN
        NMSG = 2
        MSG$(1) = "You don't have"
        MSG$(2) = "any " + NOUN$ + "!"
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_FLASK) <> CARRIED OR FLASKFULL = 0 THEN
        NMSG = 2
        MSG$(1) = "You don't have"
        MSG$(2) = "any " + NOUN$ + "!"
        GOTO ShowMessage
    END IF
    IF DRANK = 0 THEN
        DRANK = 1
        STRENGTH = 100
        FLASKFULL = 0
        NMSG = 3
        MSG$(1) = "That was good!"
        MSG$(2) = "I feel much"
        MSG$(3) = "better now!"
        GOTO ShowMessage
    END IF
    NMSG = 1
    MSG$(1) = "That was good."
    GOTO ShowMessage

' POUR WATER: empties the flask.
CmdPour:                     ' @5A04
    IF NOUN$ <> "WATER" THEN
        NMSG = 2
        MSG$(1) = " You don't"
        MSG$(2) = " have any."
        GOTO ShowMessage
    END IF
    IF OBJROOM(OBJ_FLASK) <> CARRIED OR FLASKFULL = 0 THEN
        NMSG = 2
        MSG$(1) = "You don't"
        MSG$(2) = "have any."
        GOTO ShowMessage
    END IF
    FLASKFULL = 0
    NMSG = 4
    MSG$(1) = "You pour the"
    MSG$(2) = "water & it"
    MSG$(3) = "spills on"
    MSG$(4) = "the ground."
    IF OBJROOM(OBJ_GOBLET) = CARRIED THEN
        NMSG = 6
        MSG$(5) = "The goblet had"
        MSG$(6) = "a hole in it!"
    END IF
    GOTO ShowMessage

' PET: refusal.
CmdPet:                      ' @5AF4
    FOR I = 1 TO NMONSTERS
        W$ = MONNAME$(I)
        T = INSTR(W$, CHR$(32))
        IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)
        IF MONROOM(I) = ROOM AND W$ = NOUN$ THEN
            NMSG = 3
            MSG$(1) = "I don't think"
            MSG$(2) = "that would be"
            MSG$(3) = "advisable!"
            GOTO ShowMessage
        END IF
    NEXT I
    NMSG = 2
    MSG$(1) = "I can't pet"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

' KILL: refusal.
CmdKill:                     ' @5C28
    FOR I = 1 TO NMONSTERS
        W$ = MONNAME$(I)
        T = INSTR(W$, CHR$(32))
        IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)
        IF MONROOM(I) = ROOM AND W$ = NOUN$ THEN
            NMSG = 1
            MSG$(1) = "Do it yourself!"
            GOTO ShowMessage
        END IF
    NEXT I
    NMSG = 2
    MSG$(1) = "I can't kill"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO ShowMessage

' SHOW CROSS: the vampire disappears.
CmdShow:                     ' @5D46
    FOR I = 1 TO NOBJECTS
        W$ = OBJNAME$(I)
        T = INSTR(W$, CHR$(32))
        IF T > 0 THEN W$ = RIGHT$(W$, LEN(W$) - T)
        IF OBJROOM(I) = CARRIED AND W$ = NOUN$ THEN GOTO ShowIt
    NEXT I
    NMSG = 2
    MSG$(1) = "I don't have"
    MSG$(2) = "a " + NOUN$ + "."
    GOTO ShowMessage

ShowIt:                      ' @5E48
    IF I = OBJ_CROSS THEN
        IF MONROOM(MON_VAMPIRE) = ROOM THEN
            NMSG = 4
            MSG$(1) = "The vampire"
            MSG$(2) = "sees the holy"
            MSG$(3) = "cross and"
            MSG$(4) = "disappears!"
            LOCATE MONROW(MON_VAMPIRE), MONCOL(MON_VAMPIRE)
            PRINT CHR$(CH_SPACE);
            MONROOM(MON_VAMPIRE) = RM_NONE
            GOTO ShowMessage
        END IF
    END IF
    IF MONROOM(MON_FAIRY) = ROOM OR MONROOM(MON_VAMPIRE) = ROOM THEN
        NMSG = 5
        MSG$(1) = ""
        GOTO MonstersReact
    END IF
    IF MONHERE = 1 THEN
        NMSG = 5
        MSG$(1) = ""
        GOTO MonstersReact
    END IF
    NMSG = 3
    MSG$(1) = "There's not"
    MSG$(2) = "anyone to"
    MSG$(3) = "show it to!"
    GOTO ShowMessage

' LOOK WALL in the courtyard: show the high score (record 84).
HighScoreWall:               ' @5F75
    GET #1, 84                                               ' record 84 holds the high score
    NMSG = 5
    MSG$(1) = "Writing on the"
    MSG$(2) = "wall says..."
    MSG$(3) = ""
    IF STRING$(24, 0) = FR1$ THEN
        MSG$(4) = " No high score"
        MSG$(5) = ""
        GOTO ShowMessage
    END IF
    MSG$(4) = FR1$
    MSG$(5) = FR2$
    MSG$(4) = LEFT$(MSG$(4), 14)
    MSG$(5) = LEFT$(MSG$(5), 14)
    GOTO ShowMessage

' SAVE name: write the game state to a text file.
CmdSave:                     ' @601E
    OPEN "O", #2, NOUN$
    PRINT #2, ROOM
    PRINT #2, DOOR68LOCKED
    PRINT #2, DOOR82LOCKED
    PRINT #2, STRENGTH, PY, PX, UNDER, NCARRY
    FOR I = 1 TO NOBJECTS
        PRINT #2, OBJROOM(I), OBJROW(I), OBJCOL(I)
    NEXT I
    FOR I = 1 TO NMONSTERS
        PRINT #2, MONROOM(I)
        PRINT #2, MONNAME$(I)
        PRINT #2, MONHP(I), MONROW(I), MONCOL(I)
    NEXT I
    CLOSE #2
    NMSG = 1
    MSG$(1) = " Game Saved"
    GOTO ShowMessage

' LOAD name: read it back.  (Bug: reads only MONHP per monster.)
CmdLoad:                     ' @61A0
    OPEN "A", #2, NOUN$
    CLOSE #2
    OPEN "I", #2, NOUN$
    IF EOF(2) = -1 THEN
        CLOSE #2
        KILL NOUN$
        NMSG = 3
        MSG$(1) = " There is no"
        MSG$(2) = " file named"
        MSG$(3) = " " + NOUN$
        GOTO ShowMessage
    END IF
    INPUT #2, ROOM
    INPUT #2, DOOR68LOCKED
    INPUT #2, DOOR82LOCKED
    INPUT #2, STRENGTH, PY, PX, UNDER, NCARRY
    FOR I = 1 TO NOBJECTS
        INPUT #2, OBJROOM(I), OBJROW(I), OBJCOL(I)
    NEXT I
    FOR I = 1 TO NMONSTERS
        INPUT #2, MONROOM(I)
        INPUT #2, MONNAME$(I)
        INPUT #2, MONHP(I)
    NEXT I
    CLOSE #2
    GOTO LoadRoomPage

' Death: show the message, wait for a key, then score.
PlayerDied:                  ' @63B0
    FOR I = 13 TO 19
        LOCATE I, 26
        PRINT SPACE$(15);
    NEXT I
    N2 = NMSG
    FOR I = 1 TO N2
        LOCATE I + 12, 26
        PRINT MSG$(I);
    NEXT I
    DO WHILE INKEY$ <> "": LOOP
    FOR I = 20 TO 25
        LOCATE I, 1
        PRINT SPACE$(39);
    NEXT I
    LOCATE 25, 8, 0
    PRINT "Press any key to continue";
    DO WHILE INKEY$ = "": LOOP
    CLS
    LOCATE 2, 6
    PRINT "You're have failed to Escape!"
    SCORE = 0
    W$ = ""
    GOTO FinalScore

' Win: the player left the castle (room 0).
Escaped:                     ' @653F
    CLS
    LOCATE 2, 7
    PRINT "You've Escaped the Castle!"
    SCORE = 100
    W$ = ""

' Score: 50 per treasure carried or left in room 1, 100 per dead monster,
' 100 for escaping.  1550 is perfect.  Then high score / play again.
FinalScore:                  ' @6577
    FOR I = 13 TO 22
        IF OBJROOM(I) = CARRIED OR OBJROOM(I) = RM_COURTYARD THEN
            SCORE = SCORE + 50
            W$ = W$ + CHR$(OBJCHAR(I)) + " "
        END IF
    NEXT I
    IF OBJROOM(OBJ_HARP) = CARRIED OR OBJROOM(OBJ_HARP) = RM_COURTYARD THEN
        SCORE = SCORE + 50
        W$ = W$ + CHR$(OBJCHAR(OBJ_HARP)) + " "
    END IF
    IF OBJROOM(OBJ_NECKLACE) = CARRIED OR OBJROOM(OBJ_NECKLACE) = RM_COURTYARD THEN
        SCORE = SCORE + 50
        W$ = W$ + CHR$(OBJCHAR(OBJ_NECKLACE)) + " "
    END IF
    IF OBJROOM(OBJ_CROSS) = CARRIED OR OBJROOM(OBJ_CROSS) = RM_COURTYARD THEN
        SCORE = SCORE + 50
        W$ = W$ + CHR$(OBJCHAR(OBJ_CROSS)) + " "
    END IF
    LOCATE 5, 2
    PRINT "You have collected these Treasues..."
    IF W$ = "" THEN W$ = "NONE"
    X = 20 - LEN(W$) * 0.5
    LOCATE 7, X
    PRINT W$;
    W$ = ""
    FOR I = 1 TO NFIGHTERS
        IF MONHP(I) < 0 THEN
            SCORE = SCORE + 100
            W$ = W$ + CHR$(MONCHAR(I)) + " "
        END IF
    NEXT I
    LOCATE 10, 2
    PRINT "You have killed these Monsters......"
    IF W$ = "" THEN W$ = "NONE"
    X = 20 - LEN(W$) * 0.5
    LOCATE 12, X
    PRINT W$;
    LOCATE 20, 12
    PRINT "Your Score:";SCORE;
    W$ = "MFT200O2L12DGBO3D4O2B4G4GABO3CO2BAGABO3C4"
    TUNE2$ = "MFT200O2L12DF#AO3C4O2A4D4F#GABAGF#AF#G4"
    IF SCORE = 1550 THEN
        LOCATE 21, 12
        PRINT "    PERFECT!"
        PLAY W$ + TUNE2$
    END IF
    IF SCORE < 1550 THEN
        LOCATE 21, 8
        PRINT "   (1550 is perfect)"
    END IF
    LOCATE 25, 10
    PRINT " - Press any key -";
    DO WHILE INKEY$ <> "": LOOP
    DO WHILE INKEY$ = "": LOOP
    GET #1, 84                                               ' record 84 holds the high score
    HISCORE = VAL(FR2$)
    IF SCORE > HISCORE THEN GOTO NewHighScore
    LOCATE 25, 10
    PRINT "Play Again (Y/N)?  ";
    DO
        K$ = INKEY$
    LOOP WHILE K$ = ""
    IF K$ = "y" OR K$ = "Y" THEN
        RANDOMIZE
        CLS
        PRINT "Loading...";
        GOTO NewGame
    END IF

Quit:                        ' @6A38
    CLOSE
    END

' Ask for a name.  (Bug: a name over 14 characters jumps to DropHere.)
NewHighScore:                ' @6A42
    CLS
    LOCATE 2, 6
    PRINT "You have made the High Score!"
    LOCATE 5, 6
    PRINT "          ";SCORE
    LOCATE 15, 3, 1
    PRINT "Enter Your Name - ";
    NOUN$ = ""
    INPUT "", NOUN$
    IF LEN(NOUN$) > 14 THEN
        LOCATE 15, 21
        PRINT SPACE$(LEN(NOUN$));
        GOTO DropHere
    END IF
    SC$ = STR$(SCORE)
    LSET FR1$ = NOUN$
    LSET FR2$ = SC$
    PUT #1, 84
    GOTO Quit

' Title picture and tune; P plays, I shows the instructions.
TitleScreen:                 ' @6B39
    KEY OFF
    WIDTH 40
    CLS
    SCREEN 0, 0, 0, 1
    PRINT ""
    LOCATE , , 0
    PRINT "           Castle Adventure"
    PRINT ""
    PRINT ""
    PRINT "    █ █ █ █                 █ █ █ █"
    PRINT "    ▓▓▓▓▓▓▓                 ▓▓▓▓▓▓▓"
    PRINT "     ▓▓▓▓▓                   ▓▓▓▓▓"
    PRINT "     ▓▓▓▓▓ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▓▓▓▓▓"
    PRINT "     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓"
    PRINT "       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓"
    PRINT "_______________________________________";
    SCREEN 0, 0, 0, 0
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead
    PLAY "MF MS T200 P1"
    IF INKEY$ = "" THEN
        PLAY "MF MS T200 O2 L12 D D D G2 P4"
        IF INKEY$ = "" THEN
            PLAY "L12 D D D G2 P4"
            IF INKEY$ = "" THEN
                PLAY "L12 D D D L8 G D G B A G A B O3 C2 P3"
                IF INKEY$ = "" THEN PLAY "O2 L12 D D D L8 G D G B A G O3 C O2 A G2"
            END IF
        END IF
    END IF

TitleMenu:                   ' @6D47
    LOCATE 25, 1
    PRINT "  P - to play    I - for instructions";

TitleMenuKey:                ' @6D64
    K$ = INKEY$
    IF K$ = "" THEN GOTO TitleMenuKey
    IF K$ = "p" OR K$ = "P" THEN
        CLS
        PRINT "Loading...";
        RETURN
    END IF
    IF K$ <> "i" AND K$ <> "I" THEN GOTO TitleMenuKey
    FOR I = 1 TO 6
        PRINT SPACE$(39)
    NEXT I
    PRINT "   You are trapped in a deserted Castle"
    PRINT "and you must escape. It is rumored that"
    PRINT "the  castle is  full of treasures.  Can"
    PRINT "you find them all?                     "
    PRINT SPACE$(39)
    PRINT " Use the cursor keypad to move your man"
    PRINT "around the rooms.  To pick up a visible"
    PRINT "item,  just run into it.  To pick up an"
    PRINT "item not displayed  on  the screen, use"
    PRINT "the command  GET.  To  attack  monsters"
    PRINT "just  run  into  them,  but only if you"
    PRINT "have a weapon.The computer accepts most"
    PRINT "two word commands. There are 83 rooms &"
    PRINT "13 treasures.  To  see the High Score ,"
    PRINT "look at the wall in the courtyard.     "
    PRINT SPACE$(39)
    PRINT " one hint:Look at everything carefully!"
    PRINT SPACE$(39)
    PRINT " To save a game type   SAVE filename "
    PRINT " To load a game type   LOAD filename "
    PRINT SPACE$(39)
    GOTO TitleMenu

' Shareware notice (80 columns).
FreewareNotice:              ' @6F44
    WIDTH 80
    SCREEN 0, 0, 0
    SCREEN 0, 0, 0, 1
    CLS
    PRINT ""
    PRINT "     ╓──────────────────────────────────────────────────────────────╖"
    PRINT "     ║                    ┌──────────────────┐                      ║"
    PRINT "     ║                    │  FREEWARE GAMES  │                      ║"
    PRINT "     ║                    └──────────────────┘                      ║"
    PRINT "     ║                   User Supported Software                    ║"
    PRINT "     ║                                                              ║"
    PRINT "     ║                      CASTLE ADVENTURE                        ║"
    PRINT "     ║                                                              ║"
    PRINT "     ║       You are  encouraged to share  this  program with other ║"
    PRINT "     ║  users on the conditions that the program is not distributed ║"
    PRINT "     ║  in modified form, that no fee or consideration  is  charged ║"
    PRINT "     ║  and that this notice is not bypassed or removed. If you are ║"
    PRINT "     ║  using this program and finding if enjoyable , or  of  value ║"
    PRINT "     ║  then your contribution ( $10 suggested )  will  be  greatly ║"
    PRINT "     ║  appreciated.                                                ║"
    PRINT "     ║                                                              ║"
    PRINT "     ║             FREEWARE GAMES: written by Kevin Bales           ║"
    PRINT "     ║                             1250 Lindenwood Lane             ║"
    PRINT "     ║                             Atlanta,Georgia 30319            ║"
    PRINT "     ║                             Phone# (404) 321-3841            ║"
    PRINT "     ╙──────────────────────────────────────────────────────────────╜"
    SCREEN 0, 0, 0
    SOUND 800, 0.1
    LOCATE 24, 26, 0
    PRINT "Press any key to continue...";
    DO WHILE INKEY$ = "": LOOP
    RETURN

' ON ERROR target: explains a missing CASTLE.RAN, otherwise gives up.
ErrorHandler:                ' @70EC
    IF ERR <> 53 THEN
        CLS
        PRINT "UNRECOVERABLE ERROR! GET NEW COPY"
    ELSE
        CLS
        LOCATE 10, 2
        PRINT "You are missing the file CASTLE.RAN"
        LOCATE 12, 2
        PRINT "Call Kevin Bales at 321-3841 for"
        PRINT " a copy of this required data file."
    END IF
    POKE 1050, PEEK(1052)                                    ' discard keys typed ahead
    DO
        K$ = INKEY$
    LOOP WHILE K$ = ""
    SCREEN 0, 0, 0
    CLS
    END

' ============================================================================
'  DATA read by NewGame (stored in CASTLE.EXE as text)
' ============================================================================
' Objects: room, name, character code, row, column   (room > 100 = hidden)
    DATA 17, "LAMP", 6, 14, 19                      '  1 ♠
    DATA 65, "HARP", 14, 8, 16                      '  2 ♫
    DATA 119, "NECKLACE", 21, 196, 179              '  3 §
    DATA 158, "BOOK", 22, 219, 219                  '  4 ▬
    DATA 24, "MAGIC WAND", 45, 9, 4                 '  5 -
    DATA 12, "SWORD", 197, 5, 11                    '  6 ┼
    DATA 156, "KEY", 231, 196, 179                  '  7 τ
    DATA 140, "EYE GLASSES", 236, 196, 179          '  8 ∞
    DATA 66, "CRYSTAL BALL", 248, 13, 10            '  9 °
    DATA 22, "HELMET", 155, 5, 12                   ' 10 ¢
    DATA 110, "WINE FLASK", 33, 196, 179            ' 11 !
    DATA 37, "HOLY CROSS", 116, 13, 15              ' 12 t
    DATA 57, "DIAMOND", 4, 10, 13                   ' 13 ♦
    DATA 26, "SILVER BARS", 240, 8, 7               ' 14 ≡
    DATA 60, "RUBYS", 58, 16, 4                     ' 15 :
    DATA 29, "JADE FIGURINE", 157, 10, 13           ' 16 ¥
    DATA 83, "SCEPTER", 225, 10, 12                 ' 17 ß
    DATA 20, "HOURGLASS", 232, 14, 6                ' 18 Φ
    DATA 118, "LARGE GEM", 233, 196, 179            ' 19 Θ
    DATA 74, "GOLDBAR", 254, 14, 23                 ' 20 ■
    DATA 8, "FANCY GOBLET", 230, 14, 6              ' 21 µ
    DATA 14, "CROWN", 127, 5, 9                     ' 22 ⌂
' Monsters: room, name, character code, row, column, hit points
    DATA 4, "UGLY OGRE", 1, 9, 13, 80               '  1 ☺
    DATA 21, "UGLY OGRE", 1, 12, 12, 80             '  2 ☺
    DATA 14, "ANGRY DEMON", 2, 7, 13, 120           '  3 ☻
    DATA 24, "ANGRY DEMON", 2, 10, 6, 120           '  4 ☻
    DATA 73, "BIG SPIDER", 15, 14, 18, 80           '  5 ☼
    DATA 70, "SMALL SPIDER", 42, 5, 17, 40          '  6 *
    DATA 68, "BAT", 40, 7, 18, 10                   '  7 (
    DATA 17, "SNAKE", 235, 14, 17, 60               '  8 δ
    DATA 28, "VAMPIRE", 5, 10, 24, 1                '  9 ♣
    DATA 0, "FAIRY", 246, 0, 0, 1                   ' 10 ÷
