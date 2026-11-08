' CASTLE.EXE (1984, Kevin Bales) - lifted from IBM BASIC Compiler 1.0 output
' Labels are code addresses. V/S names are DS addresses (V=number, S=string$).

L001A:
    ' program start
    GOSUB L6F44
    GOSUB L6B39
L0039:
    ON ERROR GOTO L70EC
    WIDTH 40
    ROOM = 1
    PY = 15
    PX = 15
    DOOR68LOCKED = 1
    DOOR82LOCKED = 1
    STRENGTH = 100
    I = 1
    GOTO L00E1
L0090:
    READ OBJROOM(I), OBJNAME$(I), OBJCHAR(I), OBJROW(I), OBJCOL(I)
    I = I + 1
L00E1:
    IF I <= 22 THEN GOTO L0090
    I = 1
    GOTO L015C
L0100:
    READ MONROOM(I), MONNAME$(I), MONCHAR(I), MONROW(I), MONCOL(I), MONHP(I)
    I = I + 1
L015C:
    IF I <= 10 THEN GOTO L0100
    OPEN "R", #1, "CASTLE.RAN", 575
    FIELD #1, 24 AS FR1$, 24 AS FR2$, 24 AS FR3$, 24 AS FR4$, 24 AS FR5$, 24 AS FR6$, 24 AS FR7$, 24 AS FR8$, 24 AS FR9$, 24 AS FR10$, 24 AS FR11$, 24 AS FR12$, 24 AS FR13$, 24 AS FR14$, 24 AS FR15$, 24 AS FR16$, 24 AS FR17$, 24 AS FR18$, 125 AS FDESC$, 18 AS FEXITS$
L023E:
    PAGE = (ROOM - 1 \ 10) * 10 + 1
    SLOT = ROOM - PAGE + 1
    PAGEEND = PAGE + 9
    J = PAGE
    GOTO L0452
L029F:
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
    J = J + 1
L0452:
    IF J <= PAGEEND THEN GOTO L029F
L0469:
    CLS
    CMD$ = ""
    DEF SEG = 0
    POKE 1050, PEEK(1052)
    I = 1
    GOTO L04D2
L04A4:
    LOCATE I, 25
    PRINT "│"
    I = I + 1
L04D2:
    IF I <= 18 THEN GOTO L04A4
    I = 1
    GOTO L051F
L04F1:
    LOCATE 19, I
    PRINT "─"
    I = I + 1
L051F:
    IF I <= 24 THEN GOTO L04F1
    LOCATE 19, 25
    PRINT "┘"
    I = 1
    GOTO L05AC
L055B:
    LOCATE I, 1, 0
    PRINT ROOM$(I + -1, SLOT)
    I = I + 1
L05AC:
    IF I <= 18 THEN GOTO L055B
    T$ = ROOM$(18, SLOT)
    IF LEN(T$) >= 125 THEN GOTO L0606
    T$ = T$ + SPACE$(125 - LEN(T$))
L0606:
    I = 0
    GOTO L0668
L0611:
    DESC$(I + 1) = MID$(T$, I * 25 + 1, 25)
    I = I + 1
L0668:
    IF I <= 4 THEN GOTO L0611
    I = 1
    GOTO L06C9
L0687:
    LOCATE I + 19, 1
    PRINT DESC$(I);
    I = I + 1
L06C9:
    IF I <= 5 THEN GOTO L0687
    NOBJ = 0
    I = 1
    GOTO L07E6
L06F3:
    IF OBJROOM(I) <> ROOM THEN GOTO L0754
    LOCATE OBJROW(I), OBJCOL(I)
    PRINT CHR$(OBJCHAR(I));
L0754:
    IF OBJROOM(I) <> ROOM THEN GOTO L07DB
    NOBJ = NOBJ + 1
    IF NOBJ >= 11 THEN GOTO L07DB
    LOCATE NOBJ, 26
    PRINT CHR$(OBJCHAR(I));" ";OBJNAME$(I);
L07DB:
    I = I + 1
L07E6:
    IF I <= 22 THEN GOTO L06F3
    IF NOT ((PREVROOM <> 57) AND (ROOM = 52)) THEN GOTO L084A
    MONROOM(10) = 52
    MONROW(10) = 10
    MONCOL(10) = 1
L084A:
    IF NOT ((PREVROOM <> 57) AND (ROOM = 54)) THEN GOTO L0897
    MONROOM(10) = 54
    MONROW(10) = 1
    MONCOL(10) = 12
L0897:
    NMON = 0
    MONHERE = 0
    I = 1
    GOTO L09E3
L08B5:
    IF MONROOM(I) <> ROOM THEN GOTO L0947
    LOCATE MONROW(I), MONCOL(I)
    PRINT CHR$(MONCHAR(I));
    IF I >= 9 THEN GOTO L0947
    IF MONHP(I) <= -1 THEN GOTO L0947
    MONHERE = 1
L0947:
    IF MONROOM(I) <> ROOM THEN GOTO L09D8
    NMON = NMON + 1
    IF NMON >= 3 THEN GOTO L09D8
    LOCATE NOBJ + NMON, 26
    PRINT CHR$(MONCHAR(I));" ";MONNAME$(I);
L09D8:
    I = I + 1
L09E3:
    IF I <= 10 THEN GOTO L08B5
    IF PREVROOM <> 66 THEN GOTO L0A95
    PY = 10
    PX = 17
    UNDER = 32
    LOCATE PY, PX
    PRINT CHR$(5);
    NMSG = 4
    MSG$(1) = "There is a puff"
    MSG$(2) = "of smoke & you"
    MSG$(3) = "appear in the"
    MSG$(4) = "Sorcerers room!"
    GOTO L1BD7
L0A95:
    IF PREVROOM <> 83 THEN GOTO L0AC2
    LOCATE 18, 11
    PRINT "▌  ▐";
L0AC2:
    IF NOT ((DOOR68LOCKED = 1) AND (ROOM = 68)) THEN GOTO L0B1D
    LOCATE 15, 9
    PRINT CHR$(8);CHR$(8);
L0B1D:
    IF NOT ((DOOR82LOCKED = 1) AND (ROOM = 82)) THEN GOTO L0B8E
    LOCATE 9, 14
    PRINT CHR$(8);
    LOCATE 10, 14
    PRINT CHR$(8);
L0B8E:
    UNDER = SCREEN(PY, PX)
    LOCATE PY, PX, 0
    PRINT CHR$(5);
    DEF SEG = 0
    POKE 1050, PEEK(1052)
L0BFD:
    LOCATE 23, 26, 0
    PRINT "?";CMD$;
    IF LEN(CMD$) >= 14 THEN GOTO L0C56
    COLOR 23
    PRINT "_";
    COLOR 7
L0C56:
    IF LEN(CMD$) >= 14 THEN GOTO L0C83
    PRINT SPACE$(13 - LEN(CMD$));
L0C83:
    IDLE = IDLE + 1
    IF IDLE <> 200 THEN GOTO L0CB1
    IDLE = 0
    GOTO L1CB8
L0CB1:
    K$ = INKEY$
    IF K$ = "" THEN GOTO L0C83
    IF OBJROOM(3) = 0 THEN GOTO L0D2B
    IF NOT ((PX = 15) AND (ROOM = 76)) THEN GOTO L0D2B
    IF (PY = 14) OR (PY = 13) THEN GOTO L568A
L0D2B:
    IF OBJROOM(3) = 0 THEN GOTO L0D8B
    IF NOT ((PX = 18) AND (ROOM = 78)) THEN GOTO L0D8B
    IF (PY = 10) OR (PY = 9) THEN GOTO L57DF
L0D8B:
    IF LEN(K$) < 2 THEN GOTO L0EF1
    K$ = RIGHT$(K$, 1)
    IF K$ <> "G" THEN GOTO L0DD5
    DY = -1
    DX = -1
    GOTO L103E
L0DD5:
    IF K$ <> "H" THEN GOTO L0DFE
    DY = -1
    DX = 0
    GOTO L103E
L0DFE:
    IF K$ <> "I" THEN GOTO L0E27
    DY = -1
    DX = 1
    GOTO L103E
L0E27:
    IF K$ <> "K" THEN GOTO L0E50
    DY = 0
    DX = -1
    GOTO L103E
L0E50:
    IF K$ <> "M" THEN GOTO L0E79
    DY = 0
    DX = 1
    GOTO L103E
L0E79:
    IF K$ <> "O" THEN GOTO L0EA2
    DY = 1
    DX = -1
    GOTO L103E
L0EA2:
    IF K$ <> "P" THEN GOTO L0ECB
    DY = 1
    DX = 0
    GOTO L103E
L0ECB:
    IF K$ <> "Q" THEN GOTO L0EF1
    DY = 1
    DX = 1
    GOTO L103E
L0EF1:
    IF CHR$(13) <> K$ THEN GOTO L0F2C
    LOCATE 23, 26
    PRINT SPACE$(15);
    GOTO L142D
L0F2C:
    IF NOT ((LEN(CMD$) > 0) AND (CHR$(8) = K$)) THEN GOTO L0F7A
    CMD$ = LEFT$(CMD$, LEN(CMD$) - 1)
    GOTO L0BFD
L0F7A:
    IF LEN(CMD$) <> 14 THEN GOTO L0F98
    SOUND 150, 1
    GOTO L0BFD
L0F98:
    IF K$ = " " THEN GOTO L102A
L0FA8:
    C = ASC(K$)
    IF NOT ((C < 123) AND (C > 96)) THEN GOTO L1002
    K$ = CHR$(C - 32)
    GOTO L0FA8
L1002:
    IF (C > 90) OR (C < 65) THEN GOTO L0BFD
L102A:
    CMD$ = CMD$ + K$
    GOTO L0BFD
L103E:
    NY = PY + DY
    NX = PX + DX
    CH = SCREEN(NY, NX)
    IF NY >= 1 THEN GOTO L10B4
    T$ = "N"
    PY = 18
    GOTO L123C
L10B4:
    IF NY <= 18 THEN GOTO L10DD
    T$ = "S"
    PY = 1
    GOTO L123C
L10DD:
    IF NX >= 1 THEN GOTO L1106
    T$ = "W"
    PX = 24
    GOTO L123C
L1106:
    IF NX <= 24 THEN GOTO L112F
    T$ = "E"
    PX = 1
    GOTO L123C
L112F:
    IF CHR$(CH) <> "U" THEN GOTO L1155
    T$ = "U"
    GOTO L123C
L1155:
    IF CHR$(CH) <> "D" THEN GOTO L117B
    T$ = "D"
    GOTO L123C
L117B:
    IF CH = 32 THEN GOTO L1199
    SOUND 50, 0.1
    GOTO L1911
L1199:
    LOCATE PY, PX
    PRINT CHR$(UNDER);
    UNDER = SCREEN(NY, NX)
    PY = NY
    PX = NX
    LOCATE PY, PX
    PRINT CHR$(5);
    GOTO L0BFD
L123C:
    CH = INSTR(ROOM$(19, SLOT), T$)
    W$ = ""
L126E:
    CH = CH + 1
    IF LEN(ROOM$(19, SLOT)) < CH THEN GOTO L1325
    C = ASC(MID$(ROOM$(19, SLOT), CH, 1))
    IF (C < 48) OR (C > 57) THEN GOTO L1325
    W$ = W$ + CHR$(C)
    GOTO L126E
L1325:
    IF NOT ((VAL(W$) = 68) OR (VAL(W$) = 83)) THEN GOTO L13B1
    IF OBJROOM(1) = 0 THEN GOTO L13B1
    NMSG = 2
    MSG$(1) = "It's too dark"
    MSG$(2) = "to go that way!"
    SOUND 100, 1
    IF ROOM <> 77 THEN GOTO L13AE
    PY = 18
    GOTO L1BD7
L13AE:
    GOTO L1BD7
L13B1:
    PREVROOM = ROOM
    ROOM = VAL(W$)
    IF ROOM = 0 THEN GOTO L653F
    IF (PAGE + 9 < ROOM) OR (ROOM < PAGE) THEN GOTO L023E
    SLOT = ROOM - PAGE + 1
    GOTO L0469
L142D:
    IF LEN(CMD$) <= 2 THEN GOTO L1457
    IF LEFT$(CMD$, 3) = "INV" THEN GOTO L43E5
L1457:
    IF CMD$ <> "QUIT" THEN GOTO L14A2
    CLS
    LOCATE 2, 9
    PRINT "You've ended the game!"
    SCORE = 0
    W$ = ""
    GOTO L6577
L14A2:
    NMSG = INSTR(CMD$, CHR$(32))
    IF NOT ((LEN(CMD$) <= NMSG) OR (NMSG < 2)) THEN GOTO L1506
    CMD$ = ""
    GOTO L18A5
L1506:
    VERB$ = LEFT$(CMD$, NMSG - 1)
    NOUN$ = RIGHT$(CMD$, LEN(CMD$) - NMSG)
    CMD$ = ""
    IF (VERB$ = "EXAMINE") OR ((VERB$ = "SEARCH") OR (VERB$ = "LOOK")) THEN GOTO L22EA
    IF (VERB$ = "THROW") OR (VERB$ = "DROP") THEN GOTO L3670
    IF NOT ((NOUN$ = "FLASK") AND (VERB$ = "FILL")) THEN GOTO L1624
    VERB$ = "GET"
    IF ROOM <> 68 THEN GOTO L1619
    NOUN$ = "WINE"
    GOTO L1624
L1619:
    NOUN$ = "WATER"
L1624:
    IF (VERB$ = "TAKE") OR (VERB$ = "GET") THEN GOTO L38D5
    IF VERB$ = "WEAR" THEN GOTO L44EC
    IF VERB$ = "PLAY" THEN GOTO L46EA
    IF VERB$ = "WAVE" THEN GOTO L48F6
    IF (VERB$ = "CLEAN") OR (VERB$ = "RUB") THEN GOTO L4D53
    IF VERB$ = "SAY" THEN GOTO L4EB5
    IF VERB$ <> "OPEN" THEN GOTO L16CD
    VERB$ = "UNLOCK"
L16CD:
    IF VERB$ <> "CLOSE" THEN GOTO L16E6
    VERB$ = "LOCK"
L16E6:
    IF (VERB$ = "CLOSE") OR ((VERB$ = "OPEN") OR ((VERB$ = "UNLOCK") OR (VERB$ = "LOCK"))) THEN GOTO L4FE1
    IF VERB$ = "DRINK" THEN GOTO L58F2
    IF VERB$ <> "EAT" THEN GOTO L1772
    NMSG = 2
    MSG$(1) = " I'm not"
    MSG$(2) = " hungry!"
    GOTO L1BD7
L1772:
    IF VERB$ = "READ" THEN GOTO L5509
    IF (VERB$ = "LEEP") OR (VERB$ = "JUMP") THEN GOTO L55E4
    IF VERB$ = "POUR" THEN GOTO L5A04
    IF VERB$ <> "CLIMB" THEN GOTO L17EE
    NMSG = 2
    MSG$(1) = "I don't need"
    MSG$(2) = "to climb."
    GOTO L1BD7
L17EE:
    IF ROOM <> 67 THEN GOTO L1855
    IF NOT ((NOUN$ = "MIRROR") AND (VERB$ = "MIRROR")) THEN GOTO L1855
    NMSG = 3
    MSG$(1) = " The wicked"
    MSG$(2) = "witch never"
    MSG$(3) = "lived here!!"
    GOTO L1BD7
L1855:
    IF VERB$ = "PET" THEN GOTO L5AF4
    IF VERB$ = "KILL" THEN GOTO L5C28
    IF VERB$ = "SHOW" THEN GOTO L5D46
    IF VERB$ = "SAVE" THEN GOTO L601E
    IF VERB$ = "LOAD" THEN GOTO L61A0
L18A5:
    LOCATE 25, 26
    PRINT "What???";
    BEEP
    I = 1
    GOTO L18DD
L18D2:
    I = I + 1
L18DD:
    IF I <= 500 THEN GOTO L18D2
    LOCATE 25, 26
    PRINT "       ";
    GOTO L0BFD
L1911:
    I = 1
    GOTO L1946
L191C:
    IF OBJCHAR(I) = CH THEN GOTO L1B42
    I = I + 1
L1946:
    IF I <= 22 THEN GOTO L191C
    IF CH <> 8 THEN GOTO L1999
    SOUND 50, 1.5
    NMSG = 2
    MSG$(1) = "The Door is"
    MSG$(2) = "locked."
    GOTO L1BD7
L1999:
    IF CH <> 205 THEN GOTO L19D8
    SOUND 50, 1
    NMSG = 2
    MSG$(1) = "The Gate is"
    MSG$(2) = "locked."
    GOTO L1BD7
L19D8:
    IF CH <> 5 THEN GOTO L1A2D
    SOUND 50, 1
    NMSG = 4
    MSG$(1) = "The Vampire"
    MSG$(2) = "is blocking"
    MSG$(3) = "your way. He"
    MSG$(4) = "can't be hurt."
    GOTO L1BD7
L1A2D:
    IF CH <> 246 THEN GOTO L1A82
    SOUND 50, 1
    NMSG = 4
    MSG$(1) = "The Fairy"
    MSG$(2) = "is blocking"
    MSG$(3) = "your way. He"
    MSG$(4) = "can't be hurt."
    GOTO L1BD7
L1A82:
    IF MONHERE = 0 THEN GOTO L1B1F
    I = 1
    GOTO L1B08
L1A9A:
    IF MONCHAR(I) <> CH THEN GOTO L1AFD
    IF NOT ((MONCOL(I) = NX) AND (MONROW(I) = NY)) THEN GOTO L1AFD
    TARGET = I
    GOTO L20BF
L1AFD:
    I = I + 1
L1B08:
    IF I <= 8 THEN GOTO L1A9A
L1B1F:
    DEF SEG = 0
    POKE 1050, PEEK(1052)
    GOTO L0C83
L1B42:
    SOUND 500, 1
    IF NCARRY <> 6 THEN GOTO L1B81
    NMSG = 2
    MSG$(1) = " Can't carry"
    MSG$(2) = " any more!"
    GOTO L1BD7
L1B81:
    NCARRY = NCARRY + 1
    OBJROOM(I) = 0
    LOCATE NY, NX
    PRINT " ";
    GOTO L0C83
L1BD7:
    I = 13
    GOTO L1C15
L1BE2:
    LOCATE I, 26
    PRINT SPACE$(15);
    I = I + 1
L1C15:
    IF I <= 19 THEN GOTO L1BE2
    N = NMSG
    I = 1
    GOTO L1C81
L1C3F:
    LOCATE I + 12, 26
    PRINT MSG$(I);
    I = I + 1
L1C81:
    IF I <= N THEN GOTO L1C3F
    DEF SEG = 0
    POKE 1050, PEEK(1052)
    GOTO L0BFD
L1CB8:
    I = 1
    GOTO L1D0D
L1CC3:
    IF (MONHP(I) > -1) AND (MONROOM(I) = ROOM) THEN GOTO L1D24
L1D02:
    I = I + 1
L1D0D:
    IF I <= 8 THEN GOTO L1CC3
    GOTO L0CB1
L1D24:
    MDY = 0
    MDX = 0
    IF MONROW(I) >= PY THEN GOTO L1D61
    MDY = 1
L1D61:
    IF MONROW(I) <= PY THEN GOTO L1D8B
    MDY = -1
L1D8B:
    IF MONCOL(I) >= PX THEN GOTO L1DB5
    MDX = 1
L1DB5:
    IF MONCOL(I) <= PX THEN GOTO L1DDF
    MDX = -1
L1DDF:
    T = SCREEN(MONROW(I) + MDY, MONCOL(I) + MDX)
    IF T = 5 THEN GOTO L1F1B
    IF T <> 32 THEN GOTO L1D02
    LOCATE MONROW(I), MONCOL(I)
    PRINT CHR$(32);
    MONROW(I) = MONROW(I) + MDY
    MONCOL(I) = MONCOL(I) + MDX
    LOCATE MONROW(I), MONCOL(I)
    PRINT CHR$(MONCHAR(I));
    GOTO L1D02
L1F1B:
    ROLL = INT(RND * 100) + 1
    IF OBJROOM(10) <> 0 THEN GOTO L1F5E
    ROLL = ROLL - 10
L1F5E:
    IF ROLL > 40 THEN GOTO L1F71
    GOTO L1D02
L1F71:
    MN$ = MONNAME$(I)
    T = INSTR(MN$, " ")
    IF T <= 0 THEN GOTO L1FD5
    MN$ = RIGHT$(MN$, LEN(MN$) - T)
L1FD5:
    NMSG = 2
    MSG$(1) = "The " + MN$
    MSG$(2) = "Struck you!"
    SOUND 150, 1
    SOUND 90, 0.5
    SOUND 40, 0.5
    STRENGTH = STRENGTH - INT(RND * 25) + 5
    IF STRENGTH >= 0 THEN GOTO L2083
    NMSG = 2
    MSG$(1) = "The " + MN$
    MSG$(2) = "has Killed you!"
    GOTO L63B0
L2083:
    IF OBJROOM(10) <> 0 THEN GOTO L20BC
    NMSG = 5
    MSG$(3) = ""
    MSG$(4) = "The Helmet"
    MSG$(5) = "helped."
L20BC:
    GOTO L1BD7
L20BF:
    IF OBJROOM(6) = 0 THEN GOTO L20F0
    NMSG = 2
    MSG$(1) = "You have no"
    MSG$(2) = "Weapon!"
    GOTO L1BD7
L20F0:
    ROLL = INT(RND * 100) + 1
    IF ROLL > 50 THEN GOTO L2128
    GOTO L0BFD
L2128:
    MN$ = MONNAME$(TARGET)
    T = INSTR(MN$, " ")
    IF T <= 0 THEN GOTO L218C
    MN$ = RIGHT$(MN$, LEN(MN$) - T)
L218C:
    MONHP(TARGET) = MONHP(TARGET) - INT(RND * 25) + 5
    IF MONHP(TARGET) < 0 THEN GOTO L2214
    NMSG = 2
    MSG$(1) = "You struck"
    MSG$(2) = "the " + MN$ + "!"
    GOTO L1BD7
L2214:
    NMSG = 2
    MSG$(1) = "You Killed"
    MSG$(2) = "the " + MN$ + "!"
    MONHERE = 0
    MONNAME$(TARGET) = "Dead " + MN$
    I = 1
    GOTO L22D3
L227E:
    IF NOT ((MONHP(I) > -1) AND (MONROOM(I) = ROOM)) THEN GOTO L22C8
    MONHERE = 1
L22C8:
    I = I + 1
L22D3:
    IF I <= 8 THEN GOTO L227E
    GOTO L1BD7
L22EA:
    I = 1
    GOTO L237C
L22F5:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L2361
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L2361:
    IF NOUN$ = W$ THEN GOTO L2854
    I = I + 1
L237C:
    IF I <= 22 THEN GOTO L22F5
    IF NOUN$ = "TABLE" THEN GOTO L2B15
    IF NOUN$ = "DESK" THEN GOTO L2BA1
    IF (NOUN$ = "BEDS") OR (NOUN$ = "BED") THEN GOTO L2D32
    IF (NOUN$ = "SHELVES") OR (NOUN$ = "SHELF") THEN GOTO L2ED8
    IF NOUN$ = "THRONE" THEN GOTO L315B
    IF NOUN$ = "FOUNTAIN" THEN GOTO L31B3
    IF NOUN$ = "STATUE" THEN GOTO L322C
    IF NOUN$ = "MIRROR" THEN GOTO L32CE
    IF (NOUN$ = "BARRELS") OR (NOUN$ = "BARREL") THEN GOTO L3326
    IF (NOUN$ = "CHAINS") OR (NOUN$ = "CHAIN") THEN GOTO L33BA
    IF (NOUN$ = "ARCHWAYS") OR ((NOUN$ = "ARCHWAY") OR ((NOUN$ = "CEILING") OR ((NOUN$ = "FLOOR") OR ((NOUN$ = "ROOF") OR ((NOUN$ = "WALL") OR (NOUN$ = "WALLS")))))) THEN GOTO L344E
    IF (NOUN$ = "GARDENS") OR (NOUN$ = "GARDEN") THEN GOTO L356B
    IF (NOUN$ = "STAIRCASE") OR ((NOUN$ = "STAIR") OR (NOUN$ = "STAIRS")) THEN GOTO L2FF3
    IF NOUN$ = "BALCONY" THEN GOTO L3618
    IF NOT ((ROOM = 1) AND (NOUN$ = "GATE")) THEN GOTO L25CA
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " very Strong."
    GOTO L1BD7
L25CA:
    IF NOUN$ <> "DOOR" THEN GOTO L2626
    IF NOT ((ROOM = 68) OR (ROOM = 82)) THEN GOTO L2626
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " very Strong."
    GOTO L1BD7
L2626:
    I = 1
    GOTO L26DF
L2631:
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L269A
    W$ = RIGHT$(W$, LEN(W$) - T)
L269A:
    IF (MONROOM(I) = ROOM) AND (NOUN$ = W$) THEN GOTO L2756
    I = I + 1
L26DF:
    IF I <= 10 THEN GOTO L2631
    NMSG = 5
    MSG$(1) = "I can't see"
    MSG$(2) = "a " + NOUN$ + ","
    MSG$(3) = "and I don't"
    MSG$(4) = "have a"
    MSG$(5) = NOUN$ + "!"
    GOTO L1BD7
L2756:
    IF NOT ((MONHP(I) > 0) AND (I < 10)) THEN GOTO L27B8
    NMSG = 2
    MSG$(1) = "The " + W$
    MSG$(2) = "looks Mean!"
    GOTO L1BD7
L27B8:
    IF NOT ((MONHP(I) < 1) AND (I < 10)) THEN GOTO L281D
    NMSG = 2
    MSG$(1) = "The " + W$
    MSG$(2) = "looks Dead!"
    GOTO L1BD7
L281D:
    NMSG = 3
    MSG$(1) = " The " + W$
    MSG$(2) = " looks pretty"
    MSG$(3) = " but unhappy."
    GOTO L1BD7
L2854:
    IF OBJROOM(I) = 0 THEN GOTO L2894
    NMSG = 2
    MSG$(1) = " You Don't"
    MSG$(2) = " Have it!"
    GOTO L1BD7
L2894:
    ON I GOTO L28CE, L2AA9, L28F2, L2937, L295B, L297F, L29A3, L29BC, L29E0, L2A3B, L2A5F, L2AA9, L2ACD, L2AF1, L2AF1, L2ACD, L2ACD, L2AA9, L2ACD, L2ACD, L2AA9, L2AA9
L28CE:
    NMSG = 2
    MSG$(1) = " It's lit"
    MSG$(2) = " Magically"
    GOTO L1BD7
L28F2:
    NMSG = 5
    MSG$(1) = " On the back"
    MSG$(2) = " it says:"
    MSG$(4) = "Protection from"
    MSG$(5) = "Traps."
    MSG$(3) = ""
    GOTO L1BD7
L2937:
    NMSG = 2
    MSG$(1) = " It is titled"
    MSG$(2) = "  `The Gate'"
    GOTO L1BD7
L295B:
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Magical!"
    GOTO L1BD7
L297F:
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Sharp!"
    GOTO L1BD7
L29A3:
    NMSG = 1
    MSG$(1) = " It looks Old!"
    GOTO L1BD7
L29BC:
    NMSG = 2
    MSG$(1) = " They're"
    MSG$(2) = " Bifocals"
    GOTO L1BD7
L29E0:
    NMSG = 7
    MSG$(4) = " You see a man"
    MSG$(5) = "in a winding"
    MSG$(6) = "passage,waving"
    MSG$(7) = "a Wand."
    MSG$(1) = "In the Cyrstal"
    MSG$(2) = "Ball...."
    MSG$(3) = ""
    GOTO L1BD7
L2A3B:
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Tough!"
    GOTO L1BD7
L2A5F:
    IF FLASKFULL <> 0 THEN GOTO L2A85
    NMSG = 1
    MSG$(1) = " It's empty."
    GOTO L1BD7
L2A85:
    NMSG = 2
    MSG$(1) = " It's filled"
    MSG$(2) = " with water."
    GOTO L1BD7
L2AA9:
    NMSG = 2
    MSG$(1) = " It's made of"
    MSG$(2) = " Gold!"
    GOTO L1BD7
L2ACD:
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Expensive!"
    GOTO L1BD7
L2AF1:
    NMSG = 2
    MSG$(1) = " They look"
    MSG$(2) = " Expensive!"
    GOTO L1BD7
L2B15:
    IF ROOM <> 9 THEN GOTO L2B49
    NMSG = 2
    MSG$(1) = " It's made of"
    MSG$(2) = " Stone."
    GOTO L1BD7
L2B49:
    IF ROOM <> 79 THEN GOTO L2B7D
    NMSG = 2
    MSG$(1) = " It's covered"
    MSG$(2) = " with Blood!"
    GOTO L1BD7
L2B7D:
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a Table."
    GOTO L1BD7
L2BA1:
    IF NOT ((OBJROOM(11) = 110) AND (ROOM = 10)) THEN GOTO L2BFB
    NMSG = 3
    MSG$(1) = " There is a"
    MSG$(2) = " Wine Flask"
    MSG$(3) = " on top."
    GOTO L1BD7
L2BFB:
    IF NOT ((OBJROOM(8) = 140) AND (ROOM = 40)) THEN GOTO L2C60
    NMSG = 4
    MSG$(1) = " There is a"
    MSG$(2) = " Pair of Eye"
    MSG$(3) = " Glasses on"
    MSG$(4) = " Top."
    GOTO L1BD7
L2C60:
    IF NOT ((OBJROOM(7) = 156) AND (ROOM = 56)) THEN GOTO L2CAF
    NMSG = 2
    MSG$(1) = " There is a"
    MSG$(2) = " Key on top"
    GOTO L1BD7
L2CAF:
    IF NOT ((ROOM = 56) OR ((ROOM = 40) OR (ROOM = 10))) THEN GOTO L2D0B
    NMSG = 2
    MSG$(1) = " It's made"
    MSG$(2) = " of Wood."
    GOTO L1BD7
L2D0B:
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a desk!"
    GOTO L1BD7
L2D32:
    NMSG = 1
    IF NOT ((ROOM = 37) AND (NOUN$ = "BEDS")) THEN GOTO L2D76
    MSG$(1) = " They're Red."
    GOTO L1BD7
L2D76:
    IF NOT ((ROOM = 38) AND (NOUN$ = "BEDS")) THEN GOTO L2DAF
    MSG$(1) = " They're Blue."
    GOTO L1BD7
L2DAF:
    IF NOT ((ROOM = 67) AND (NOUN$ = "BEDS")) THEN GOTO L2DE8
    MSG$(1) = " They're Old."
    GOTO L1BD7
L2DE8:
    IF NOT ((ROOM = 67) OR (ROOM = 10)) THEN GOTO L2E1E
    MSG$(1) = " It's Old."
    GOTO L1BD7
L2E1E:
    IF ROOM <> 37 THEN GOTO L2E3C
    MSG$(1) = " It's Red."
    GOTO L1BD7
L2E3C:
    IF ROOM <> 38 THEN GOTO L2E5A
    MSG$(1) = " It's Blue."
    GOTO L1BD7
L2E5A:
    IF ROOM <> 39 THEN GOTO L2E78
    MSG$(1) = " It's Purple."
    GOTO L1BD7
L2E78:
    IF ROOM <> 40 THEN GOTO L2E96
    MSG$(1) = " It's Yellow."
    GOTO L1BD7
L2E96:
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ <> "BEDS" THEN GOTO L2ECA
    MSG$(2) = " any Beds."
    GOTO L2ED5
L2ECA:
    MSG$(2) = " a Bed."
L2ED5:
    GOTO L1BD7
L2ED8:
    IF (OBJROOM(4) <> 158) OR (ROOM <> 58) THEN GOTO L2F55
    IF OBJROOM(4) <> 158 THEN GOTO L2F55
    NMSG = 2
    MSG$(1) = "There's a book"
    IF NOUN$ <> "SHELF" THEN GOTO L2F47
    MSG$(2) = "on it."
    GOTO L1BD7
L2F47:
    MSG$(2) = "on one."
    GOTO L1BD7
L2F55:
    IF NOT ((ROOM = 59) OR ((ROOM = 11) OR (ROOM = 58))) THEN GOTO L2FB1
    NMSG = 2
    MSG$(1) = " They're made"
    MSG$(2) = " of wood."
    GOTO L1BD7
L2FB1:
    NMSG = 1
    MSG$(1) = " I don't see"
    IF NOUN$ <> "SHELF" THEN GOTO L2FE5
    MSG$(2) = " one."
    GOTO L2FF0
L2FE5:
    MSG$(2) = " any."
L2FF0:
    GOTO L1BD7
L2FF3:
    T = INSTR(ROOM$(19, SLOT), "U")
    T2 = INSTR(ROOM$(19, SLOT), "D")
    IF NOT ((T2 = 0) AND (T > 0)) THEN GOTO L307C
    NMSG = 2
    MSG$(1) = " The Staircase"
    MSG$(2) = " leads up."
    GOTO L1BD7
L307C:
    IF NOT ((T = 0) AND (T2 > 0)) THEN GOTO L30C5
    NMSG = 2
    MSG$(1) = " The Staircase"
    MSG$(2) = " leads down."
    GOTO L1BD7
L30C5:
    IF NOT ((T2 > 0) AND (T > 0)) THEN GOTO L3119
    NMSG = 3
    MSG$(1) = " The Staircase"
    MSG$(2) = " leads both"
    MSG$(3) = " up & Down."
    GOTO L1BD7
L3119:
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ <> "STAIRS" THEN GOTO L314D
    MSG$(2) = " any stairs!"
    GOTO L3158
L314D:
    MSG$(2) = " a staircase!"
L3158:
    GOTO L1BD7
L315B:
    IF ROOM = 14 THEN GOTO L318F
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " A throne!"
    GOTO L1BD7
L318F:
    NMSG = 2
    MSG$(1) = " The throne is"
    MSG$(2) = " made of stone."
    GOTO L1BD7
L31B3:
    IF ROOM = 18 THEN GOTO L31E7
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " A fountain!"
    GOTO L1BD7
L31E7:
    NMSG = 5
    MSG$(1) = "The fountain"
    MSG$(2) = "is filled"
    MSG$(3) = "with water.But"
    MSG$(4) = "you can't see"
    MSG$(5) = "In it."
    GOTO L1BD7
L322C:
    IF ROOM = 19 THEN GOTO L3260
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " A Statue!"
    GOTO L1BD7
L3260:
    IF OBJROOM(3) <> 119 THEN GOTO L329F
    NMSG = 3
    MSG$(1) = " The statue is"
    MSG$(2) = " wearing a"
    MSG$(3) = " Necklace"
    GOTO L1BD7
L329F:
    NMSG = 3
    MSG$(1) = " The Statue"
    MSG$(2) = " looks like"
    MSG$(3) = " The King!"
    GOTO L1BD7
L32CE:
    IF ROOM = 67 THEN GOTO L3302
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " A Mirror!"
    GOTO L1BD7
L3302:
    NMSG = 2
    MSG$(1) = " It looks"
    MSG$(2) = " Magical!"
    GOTO L1BD7
L3326:
    IF ROOM = 68 THEN GOTO L3378
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ <> "BARRELS" THEN GOTO L336A
    MSG$(2) = " any Barrels!"
    GOTO L3375
L336A:
    MSG$(2) = " a Barrel!"
L3375:
    GOTO L1BD7
L3378:
    NMSG = 2
    MSG$(2) = " Old!"
    IF NOUN$ <> "BARRELS" THEN GOTO L33AC
    MSG$(1) = " They look"
    GOTO L33B7
L33AC:
    MSG$(1) = " It looks"
L33B7:
    GOTO L1BD7
L33BA:
    IF ROOM = 79 THEN GOTO L340C
    NMSG = 2
    MSG$(1) = " I don't see"
    IF NOUN$ <> "CHAINS" THEN GOTO L33FE
    MSG$(2) = " any Chains!"
    GOTO L3409
L33FE:
    MSG$(2) = " a Chain!"
L3409:
    GOTO L1BD7
L340C:
    NMSG = 2
    MSG$(2) = " Magical!"
    IF NOUN$ <> "CHAINS" THEN GOTO L3440
    MSG$(1) = " They look"
    GOTO L344B
L3440:
    MSG$(1) = " It looks"
L344B:
    GOTO L1BD7
L344E:
    IF ROOM <> 74 THEN GOTO L348D
    NMSG = 3
    MSG$(1) = "The Wall Says:"
    MSG$(2) = "Kevin Bales"
    MSG$(3) = "was Here!"
    GOTO L1BD7
L348D:
    IF ROOM <> 83 THEN GOTO L34C1
    NMSG = 2
    MSG$(1) = "The walls are"
    MSG$(2) = "many Colors!"
    GOTO L1BD7
L34C1:
    IF ROOM <> 1 THEN GOTO L34F9
    IF (NOUN$ = "WALLS") OR (NOUN$ = "WALL") THEN GOTO L5F75
L34F9:
    IF NOUN$ <> "WALLS" THEN GOTO L3512
    NOUN$ = "WALL"
L3512:
    IF NOUN$ <> "ARCHWAYS" THEN GOTO L352B
    NOUN$ = "ARCHWAY"
L352B:
    NMSG = 3
    MSG$(1) = "The " + NOUN$ + "S"
    MSG$(2) = "are made of"
    MSG$(3) = "Gray Stone."
    GOTO L1BD7
L356B:
    IF ROOM = 33 THEN GOTO L359F
    NMSG = 2
    MSG$(1) = " I Don't see"
    MSG$(2) = " A Garden!"
    GOTO L1BD7
L359F:
    IF OBJROOM(19) = 118 THEN GOTO L35DE
    NMSG = 3
    MSG$(1) = "The Garden"
    MSG$(2) = "Has A Fountain"
    MSG$(3) = "in the middle."
    GOTO L1BD7
L35DE:
    NMSG = 4
    MSG$(1) = " There is a"
    MSG$(2) = " BIG Gem in "
    MSG$(3) = " the Garden"
    MSG$(4) = " Fountain!"
    GOTO L1BD7
L3618:
    IF ROOM = 33 THEN GOTO L364C
    NMSG = 2
    MSG$(1) = "I don't see"
    MSG$(2) = "a Balcony!"
    GOTO L1BD7
L364C:
    NMSG = 2
    MSG$(1) = "The balcony is"
    MSG$(2) = "made of stone."
    GOTO L1BD7
L3670:
    I = 1
    GOTO L3726
L367B:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L36E4
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L36E4:
    IF (OBJROOM(I) = 0) AND (NOUN$ = W$) THEN GOTO L3769
    I = I + 1
L3726:
    IF I <= 22 THEN GOTO L367B
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$
    GOTO L1BD7
L3769:
    T = SCREEN(PY + DY, PX + DX)
    IF T <> 32 THEN GOTO L38B1
    IF (PX + DX < 1) OR (PY + DY < 1) THEN GOTO L38B1
    NCARRY = NCARRY - 1
    OBJROOM(I) = ROOM
    OBJROW(I) = PY + DY
    OBJCOL(I) = PX + DX
    LOCATE OBJROW(I), OBJCOL(I)
    PRINT CHR$(OBJCHAR(I));
    SOUND 150, 1
    NMSG = 1
    MSG$(1) = " Done."
    GOTO L1BD7
L38B1:
    NMSG = 2
    MSG$(1) = " Something is"
    MSG$(2) = " in the way!"
    GOTO L1BD7
L38D5:
    IF NOUN$ <> "BLOOD" THEN GOTO L38FE
    NMSG = 1
    MSG$(1) = "Yuc!!"
    GOTO L1BD7
L38FE:
    I = 1
    GOTO L398D
L3909:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L3972
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L3972:
    IF NOUN$ = W$ THEN GOTO L3F61
    I = I + 1
L398D:
    IF I <= 22 THEN GOTO L3909
    IF (NOUN$ = "BARRELS") OR ((NOUN$ = "SHELVES") OR ((NOUN$ = "BEDS") OR ((NOUN$ = "MIRROR") OR ((NOUN$ = "BARREL") OR ((NOUN$ = "STATUE") OR ((NOUN$ = "FOUNTAIN") OR ((NOUN$ = "THRONE") OR ((NOUN$ = "SHELF") OR ((NOUN$ = "BED") OR ((NOUN$ = "DESK") OR (NOUN$ = "TABLE"))))))))))) THEN GOTO L3C13
    IF NOT ((NOUN$ = "CHAINS") OR (NOUN$ = "CHAIN")) THEN GOTO L3AD3
    IF ROOM <> 79 THEN GOTO L3AD3
    NMSG = 3
    MSG$(1) = " They're"
    MSG$(2) = " Connected to"
    MSG$(3) = " the wall."
    GOTO L1BD7
L3AD3:
    IF (NOUN$ = "WATER") OR (NOUN$ = "WINE") THEN GOTO L41C5
    I = 1
    GOTO L3BE3
L3B06:
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L3B6F
    W$ = RIGHT$(W$, LEN(W$) - T)
L3B6F:
    IF NOT ((MONROOM(I) = ROOM) AND (W$ = NOUN$)) THEN GOTO L3BD8
    NMSG = 3
    MSG$(1) = "I don't think"
    MSG$(2) = "that would be"
    MSG$(3) = "very safe!"
    GOTO L1BD7
L3BD8:
    I = I + 1
L3BE3:
    IF I <= 10 THEN GOTO L3B06
    NMSG = 1
    MSG$(1) = "Impossible!!"
    GOTO L1BD7
L3C13:
    NMSG = 2
    IF RIGHT$(NOUN$, 1) <> "S" THEN GOTO L3C46
    MSG$(1) = NOUN$
    GOTO L3C59
L3C46:
    MSG$(1) = NOUN$ + "S"
L3C59:
    MSG$(2) = "are too heavy!"
    IF NOUN$ <> "TABLE" THEN GOTO L3C9C
    IF (ROOM = 79) OR (ROOM = 9) THEN GOTO L1BD7
L3C9C:
    IF NOUN$ <> "DESK" THEN GOTO L3CE4
    IF (ROOM = 56) OR ((ROOM = 40) OR (ROOM = 10)) THEN GOTO L1BD7
L3CE4:
    IF NOT ((NOUN$ = "BEDS") OR (NOUN$ = "BED")) THEN GOTO L3D74
    IF (ROOM = 67) OR ((ROOM = 40) OR ((ROOM = 39) OR ((ROOM = 38) OR ((ROOM = 37) OR (ROOM = 10))))) THEN GOTO L1BD7
L3D74:
    IF NOT ((NOUN$ = "SHELVES") OR (NOUN$ = "SHELF")) THEN GOTO L3DD4
    IF (ROOM = 59) OR ((ROOM = 58) OR (ROOM = 11)) THEN GOTO L1BD7
L3DD4:
    IF (ROOM = 14) AND (NOUN$ = "THRONE") THEN GOTO L1BD7
    IF (ROOM = 18) AND (NOUN$ = "FOUNTAIN") THEN GOTO L1BD7
    IF (ROOM = 19) AND (NOUN$ = "STATUE") THEN GOTO L1BD7
    IF NOT ((NOUN$ = "BARRELS") OR (NOUN$ = "BARREL")) THEN GOTO L3E8D
    IF ROOM = 68 THEN GOTO L1BD7
L3E8D:
    IF NOT ((NOUN$ = "CHAINS") OR (NOUN$ = "CHAIN")) THEN GOTO L3EC5
    IF ROOM = 79 THEN GOTO L1BD7
L3EC5:
    IF (ROOM = 67) AND (NOUN$ = "MIRROR") THEN GOTO L1BD7
    NMSG = 4
    MSG$(3) = "and I don't"
    MSG$(4) = "see any!"
    GOTO L1BD7
L3F61:
    IF OBJROOM(I) <> ROOM THEN GOTO L3FA4
    NMSG = 2
    MSG$(1) = " Get it"
    MSG$(2) = " Yourself!"
    GOTO L1BD7
L3FA4:
    IF OBJROOM(I) <> 0 THEN GOTO L3FE4
    NMSG = 2
    MSG$(1) = " You already"
    MSG$(2) = " have it!"
    GOTO L1BD7
L3FE4:
    IF OBJROOM(I) = ROOM + 100 THEN GOTO L403B
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a " + NOUN$
    GOTO L1BD7
L403B:
    J = -1
    GOTO L4129
L4046:
    K = -1
    GOTO L4107
L4051:
    IF (PX + K > 18) OR (PY + J > 24) THEN GOTO L40FC
    T = SCREEN(PY + J, PX + K)
    IF (OBJCOL(I) = T) OR (OBJROW(I) = T) THEN GOTO L4164
L40FC:
    K = K + 1
L4107:
    IF K <= 1 THEN GOTO L4051
    J = J + 1
L4129:
    IF J <= 1 THEN GOTO L4046
    NMSG = 2
    MSG$(1) = " I can't"
    MSG$(2) = " reach it!"
    GOTO L1BD7
L4164:
    IF NCARRY = 6 THEN GOTO L1B42
    NCARRY = NCARRY + 1
    OBJROOM(I) = 0
    SOUND 500, 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO L1BD7
L41C5:
    IF NOUN$ <> "WINE" THEN GOTO L420C
    IF ROOM <> 68 THEN GOTO L4209
    NMSG = 2
    MSG$(1) = " The Barrels"
    MSG$(2) = " are empty."
    GOTO L1BD7
L4209:
    GOTO L3B6F
L420C:
    IF ROOM <> 18 THEN GOTO L3B6F
    IF OBJROOM(11) = 0 THEN GOTO L424D
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a Container!"
    GOTO L1BD7
L424D:
    IF FLASKFULL <> 1 THEN GOTO L4281
    NMSG = 2
    MSG$(1) = "The flask is"
    MSG$(2) = "full!"
    GOTO L1BD7
L4281:
    I = -1
    GOTO L43AA
L428C:
    J = -1
    GOTO L4388
L4297:
    IF NOT ((PX = 24) OR ((PY = 18) OR ((PX + J < 1) OR (PY + I < 1)))) THEN GOTO L42FE
L42FE:
    T = SCREEN(PY + I, PX + J)
    IF NOT ((T = 196) OR (T = 179)) THEN GOTO L437D
    FLASKFULL = 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO L1BD7
L437D:
    J = J + 1
L4388:
    IF J <= 1 THEN GOTO L4297
    I = I + 1
L43AA:
    IF I <= 1 THEN GOTO L428C
    NMSG = 2
    MSG$(1) = " I can't"
    MSG$(2) = " reach it!"
    GOTO L1BD7
L43E5:
    NMSG = 1
    MSG$(1) = "- Inventory -"
    I = 1
    GOTO L4497
L4406:
    IF OBJROOM(I) <> 0 THEN GOTO L447C
    NMSG = NMSG + 1
    MSG$(NMSG) = CHR$(OBJCHAR(I)) + " " + OBJNAME$(I)
L447C:
    IF NMSG = 7 THEN GOTO L44AE
    I = I + 1
L4497:
    IF I <= 22 THEN GOTO L4406
L44AE:
    IF NMSG <> 1 THEN GOTO L44DE
    NMSG = 3
    MSG$(2) = ""
    MSG$(3) = "   Nothing."
L44DE:
    CMD$ = ""
    GOTO L1BD7
L44EC:
    I = 1
    GOTO L457B
L44F7:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L4560
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L4560:
    IF NOUN$ = W$ THEN GOTO L45C7
    I = I + 1
L457B:
    IF I <= 22 THEN GOTO L44F7
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L45C7:
    IF OBJROOM(I) = 0 THEN GOTO L4607
    NMSG = 2
    MSG$(1) = " You don't"
    MSG$(2) = " have it!"
    GOTO L1BD7
L4607:
    IF NOT ((I = 10) OR (I = 3)) THEN GOTO L4653
    NMSG = 2
    MSG$(1) = "Ok."
    MSG$(2) = "I'm wearing it."
    GOTO L1BD7
L4653:
    IF I <> 22 THEN GOTO L4687
    NMSG = 2
    MSG$(1) = " The crown is"
    MSG$(2) = " too Heavy!"
    GOTO L1BD7
L4687:
    IF I <> 8 THEN GOTO L46C6
    NMSG = 3
    MSG$(1) = " Ok."
    MSG$(2) = " I'm wearing"
    MSG$(3) = " them."
    GOTO L1BD7
L46C6:
    NMSG = 2
    MSG$(1) = "That could be"
    MSG$(2) = "Difficult!"
    GOTO L1BD7
L46EA:
    I = 1
    GOTO L4779
L46F5:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L475E
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L475E:
    IF NOUN$ = W$ THEN GOTO L47C5
    I = I + 1
L4779:
    IF I <= 22 THEN GOTO L46F5
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L47C5:
    IF OBJROOM(I) = 0 THEN GOTO L4805
    NMSG = 2
    MSG$(1) = " You don't"
    MSG$(2) = " have it!"
    GOTO L1BD7
L4805:
    IF I = 2 THEN GOTO L484C
    NMSG = 3
    MSG$(1) = "The " + NOUN$
    MSG$(2) = "makes Horrible"
    MSG$(3) = "music!!"
    GOTO L1BD7
L484C:
    PLAY "MB O3 L24 C D E F# G# A# O4 C O3 A# G# F# E D C6"
    NMSG = 3
    MSG$(1) = "The Harp makes"
    MSG$(2) = "Beautiful"
    MSG$(3) = "Music!"
    IF MONROOM(10) <> ROOM THEN GOTO L1BD7
    LOCATE MONROW(10), MONCOL(10)
    PRINT CHR$(32);
    MONROOM(10) = 0
    NMSG = 6
    MSG$(4) = "The fairy"
    MSG$(5) = "likes the music"
    MSG$(6) = "and leaves!"
    GOTO L1BD7
L48F6:
    I = 1
    GOTO L4985
L4901:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L496A
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L496A:
    IF NOUN$ = W$ THEN GOTO L49D1
    I = I + 1
L4985:
    IF I <= 22 THEN GOTO L4901
L499C:
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L49D1:
    IF OBJROOM(I) <> 0 THEN GOTO L499C
    IF I = 5 THEN GOTO L4ADD
    IF NOT ((ROOM = 28) AND (I = 12)) THEN GOTO L4A96
    NMSG = 4
    MSG$(1) = "The vampire"
    MSG$(2) = "sees the holy"
    MSG$(3) = "cross and"
    MSG$(4) = "disappears!"
    LOCATE MONROW(9), MONCOL(9)
    PRINT CHR$(32);
    MONROOM(9) = 0
    GOTO L1BD7
L4A96:
    IF I = 17 THEN GOTO L4C94
    NMSG = 3
    MSG$(1) = "You look awful"
    MSG$(2) = "Silly waving"
    MSG$(3) = "that " + NOUN$
    GOTO L1BD7
L4ADD:
    NMSG = 5
    MSG$(1) = "As you wave the"
    MSG$(2) = NOUN$ + "...."
    MSG$(3) = ""
    MSG$(4) = "  Nothing"
    MSG$(5) = "  Happens!"
    IF (ROOM <> 67) AND (ROOM <> 77) THEN GOTO L1BD7
    IF ROOM = 77 THEN GOTO L4C5E
    I = 7
    GOTO L4B98
L4B6A:
    LOCATE I, 19
    PRINT " ";
    I = I + 1
L4B98:
    IF I <= 12 THEN GOTO L4B6A
    LOCATE 8, 20
    PRINT "▓▓▓▓▓"
    LOCATE 11, 20
    PRINT "▓▓▓▓▓"
    LOCATE 9, 20
    PRINT " ";
    LOCATE 10, 20
    PRINT " ";
L4C24:
    NMSG = 7
    MSG$(4) = "  There is a"
    MSG$(5) = "*Puff* of smoke"
    MSG$(6) = "Revealing a"
    MSG$(7) = "Secret passage!"
    GOTO L1BD7
L4C5E:
    IF SCREEN(18, 12) = 32 THEN GOTO L1BD7
    LOCATE 18, 11
    PRINT "▌  ▐";
    GOTO L4C24
L4C94:
    IF ROOM = 1 THEN GOTO L4CF1
    NMSG = 5
    MSG$(1) = "As you wave the"
    MSG$(2) = NOUN$ + "...."
    MSG$(3) = ""
    MSG$(4) = "  Nothing"
    MSG$(5) = "  Happens!"
    GOTO L1BD7
L4CF1:
    LOCATE 18, 11
    PRINT "    ";
    NMSG = 5
    MSG$(1) = "As you wave the"
    MSG$(2) = "scepter..."
    MSG$(3) = ""
    MSG$(4) = "The Gate opens"
    MSG$(5) = "by itself!"
    GOTO L1BD7
L4D53:
    I = 1
    GOTO L4DE2
L4D5E:
    W$ = OBJNAME$(I)
    NMSG = INSTR(W$, CHR$(32))
    IF NMSG <= 0 THEN GOTO L4DC7
    W$ = RIGHT$(W$, LEN(W$) - NMSG)
L4DC7:
    IF NOUN$ = W$ THEN GOTO L4E2E
    I = I + 1
L4DE2:
    IF I <= 22 THEN GOTO L4D5E
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L4E2E:
    IF OBJROOM(I) <> 0 THEN GOTO L499C
    IF I <> 1 THEN GOTO L4E89
    NMSG = 3
    MSG$(1) = " There's no"
    MSG$(2) = " Genii in this"
    MSG$(3) = " Lamp!"
    GOTO L1BD7
L4E89:
    NMSG = 2
    MSG$(1) = "The " + NOUN$
    MSG$(2) = "is cleaner now."
    GOTO L1BD7
L4EB5:
    NMSG = 1
    MSG$(1) = CHR$(34) + NOUN$ + CHR$(34)
L4EEA:
    I = 1
    GOTO L4F1F
L4EF5:
    IF MONROOM(I) = ROOM THEN GOTO L4F36
    I = I + 1
L4F1F:
    IF I <= 10 THEN GOTO L4EF5
    GOTO L1BD7
L4F36:
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L4F9F
    W$ = RIGHT$(W$, LEN(W$) - T)
L4F9F:
    MSG$(2) = ""
    MSG$(3) = "The " + W$
    MSG$(4) = "looks at you"
    MSG$(5) = "Funny!"
    NMSG = 5
    GOTO L1BD7
L4FE1:
    IF OBJROOM(7) = 0 THEN GOTO L5012
    NMSG = 2
    MSG$(1) = " You don't"
    MSG$(2) = " have a Key!"
    GOTO L1BD7
L5012:
    IF NOUN$ = "DOOR" THEN GOTO L50D7
    IF NOUN$ = "GATE" THEN GOTO L504B
    NMSG = 1
    MSG$(1) = "Impossible!!"
    GOTO L1BD7
L504B:
    IF ROOM = 1 THEN GOTO L507F
    NMSG = 2
    MSG$(1) = " I don't see"
    MSG$(2) = " a Gate!"
    GOTO L1BD7
L507F:
    NMSG = 3
    MSG$(1) = " The Gate"
    IF VERB$ <> "UNLOCK" THEN GOTO L50BE
    MSG$(2) = " is locked"
    MSG$(3) = " Magically."
    GOTO L1BD7
L50BE:
    MSG$(2) = " is already"
    MSG$(3) = " locked!"
    GOTO L1BD7
L50D7:
    IF NOT ((ROOM <> 82) AND (ROOM <> 68)) THEN GOTO L5123
    NMSG = 2
    MSG$(1) = "I don't see"
    MSG$(2) = "a door!"
    GOTO L1BD7
L5123:
    IF VERB$ = "LOCK" THEN GOTO L521F
    I = -1
    GOTO L51E4
L513E:
    J = -1
    GOTO L51C2
L5149:
    IF (PX + J < 1) OR (PY + I < 1) THEN GOTO L51B7
    IF SCREEN(PY + I, PX + J) = 8 THEN GOTO L521F
L51B7:
    J = J + 1
L51C2:
    IF J <= 1 THEN GOTO L5149
    I = I + 1
L51E4:
    IF I <= 1 THEN GOTO L513E
    NMSG = 2
    MSG$(1) = " I can't"
    MSG$(2) = " reach it!"
    GOTO L1BD7
L521F:
    IF ROOM = 82 THEN GOTO L5375
    IF VERB$ <> "LOCK" THEN GOTO L529A
    LOCATE 15, 9
    PRINT CHR$(8);CHR$(8);
    DOOR68LOCKED = 1
    NMSG = 1
    MSG$(1) = "Done."
    SOUND 50, 1
    GOTO L1BD7
L529A:
    LOCATE PY, PX
    PRINT CHR$(UNDER);
    IF PY <= 15 THEN GOTO L52E9
    PY = 16
    GOTO L52F4
L52E9:
    PY = 14
L52F4:
    PX = 9
    LOCATE PY, PX
    PRINT CHR$(5);
    LOCATE 15, 9
    PRINT "  ";
    DOOR68LOCKED = 0
    SOUND 50, 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO L1BD7
L5375:
    IF VERB$ <> "LOCK" THEN GOTO L53F6
    LOCATE 9, 14
    PRINT CHR$(8)
    LOCATE 10, 14
    PRINT CHR$(8);
    DOOR82LOCKED = 1
    NMSG = 1
    MSG$(1) = "Done."
    SOUND 50, 1
    GOTO L1BD7
L53F6:
    LOCATE PY, PX
    PRINT CHR$(UNDER);
    IF PX >= 14 THEN GOTO L5445
    PX = 13
    GOTO L5450
L5445:
    PX = 15
L5450:
    PY = 9
    LOCATE PY, PX
    PRINT CHR$(5);
    LOCATE 9, 14
    PRINT " ";
    LOCATE 10, 14
    PRINT " ";
    DOOR82LOCKED = 0
    SOUND 50, 1
    NMSG = 1
    MSG$(1) = "Done."
    GOTO L1BD7
L5509:
    IF NOUN$ = "BOOK" THEN GOTO L553D
    NMSG = 2
    MSG$(1) = " You can't"
    MSG$(2) = " read That!"
    GOTO L1BD7
L553D:
    IF OBJROOM(4) = 0 THEN GOTO L556E
    NMSG = 2
    MSG$(1) = " You don't"
    MSG$(2) = " have a book!"
    GOTO L1BD7
L556E:
    IF OBJROOM(8) = 0 THEN GOTO L55B5
    NMSG = 4
    MSG$(1) = " You can't see"
    MSG$(2) = " well enough."
    MSG$(3) = " It's all"
    MSG$(4) = " Blurry."
    GOTO L1BD7
L55B5:
    NMSG = 3
    MSG$(1) = "The book reads:"
    MSG$(2) = ""
    MSG$(3) = "  Wave Scepter"
    GOTO L1BD7
L55E4:
    IF NOUN$ <> "DOWN" THEN GOTO L565B
    IF NOT ((ROOM = 65) OR ((ROOM = 64) OR (ROOM = 33))) THEN GOTO L565B
    NMSG = 3
    MSG$(1) = " I don't think"
    MSG$(2) = " it's safe to"
    MSG$(3) = " Jump here!"
    GOTO L1BD7
L565B:
    NMSG = 3
    MSG$(1) = "I Jumped."
    MSG$(2) = ""
    MSG$(3) = "This is boring."
    GOTO L1BD7
L568A:
    LOCATE 13, 11
    PRINT "▓";
    LOCATE 14, 11
    PRINT "▓";
    LOCATE 13, 17
    PRINT "▓";
    LOCATE 14, 17
    PRINT "▓";
    I = 12
    GOTO L5783
L570D:
    J = 1
    GOTO L5723
L5718:
    J = J + 1
L5723:
    IF J <= 200 THEN GOTO L5718
    LOCATE 13, I
    PRINT "░";
    LOCATE 14, I
    PRINT "░";
    I = I + 1
L5783:
    IF I <= 16 THEN GOTO L570D
L579A:
    NMSG = 5
    MSG$(1) = "You have sprung"
    MSG$(2) = "a Trap!! The"
    MSG$(3) = "room has filled"
    MSG$(4) = "with water and"
    MSG$(5) = "you drowned!"
    GOTO L63B0
L57DF:
    LOCATE 9, 12
    PRINT "▓";
    LOCATE 9, 24
    PRINT "▓";
    LOCATE 10, 12
    PRINT "▓";
    LOCATE 10, 24
    PRINT "▓";
    I = 13
    GOTO L58D8
L5862:
    J = 1
    GOTO L5878
L586D:
    J = J + 1
L5878:
    IF J <= 200 THEN GOTO L586D
    LOCATE 9, I
    PRINT "░";
    LOCATE 10, I
    PRINT "░";
    I = I + 1
L58D8:
    IF I <= 23 THEN GOTO L5862
    GOTO L579A
L58F2:
    IF NOUN$ = "WATER" THEN GOTO L5935
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "any " + NOUN$ + "!"
    GOTO L1BD7
L5935:
    IF NOT ((OBJROOM(11) <> 0) OR (FLASKFULL = 0)) THEN GOTO L598F
    NMSG = 2
    MSG$(1) = "You don't have"
    MSG$(2) = "any " + NOUN$ + "!"
    GOTO L1BD7
L598F:
    IF DRANK <> 0 THEN GOTO L59EB
    DRANK = 1
    STRENGTH = 100
    FLASKFULL = 0
    NMSG = 3
    MSG$(1) = "That was good!"
    MSG$(2) = "I feel much"
    MSG$(3) = "better now!"
    GOTO L1BD7
L59EB:
    NMSG = 1
    MSG$(1) = "That was good."
    GOTO L1BD7
L5A04:
    IF NOUN$ = "WATER" THEN GOTO L5A38
    NMSG = 2
    MSG$(1) = " You don't"
    MSG$(2) = " have any."
    GOTO L1BD7
L5A38:
    IF NOT ((OBJROOM(11) <> 0) OR (FLASKFULL = 0)) THEN GOTO L5A81
    NMSG = 2
    MSG$(1) = "You don't"
    MSG$(2) = "have any."
    GOTO L1BD7
L5A81:
    FLASKFULL = 0
    NMSG = 4
    MSG$(1) = "You pour the"
    MSG$(2) = "water & it"
    MSG$(3) = "spills on"
    MSG$(4) = "the ground."
    IF OBJROOM(21) <> 0 THEN GOTO L5AF1
    NMSG = 6
    MSG$(5) = "The goblet had"
    MSG$(6) = "a hole in it!"
L5AF1:
    GOTO L1BD7
L5AF4:
    I = 1
    GOTO L5BDC
L5AFF:
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L5B68
    W$ = RIGHT$(W$, LEN(W$) - T)
L5B68:
    IF NOT ((MONROOM(I) = ROOM) AND (W$ = NOUN$)) THEN GOTO L5BD1
    NMSG = 3
    MSG$(1) = "I don't think"
    MSG$(2) = "that would be"
    MSG$(3) = "advisable!"
    GOTO L1BD7
L5BD1:
    I = I + 1
L5BDC:
    IF I <= 10 THEN GOTO L5AFF
    NMSG = 2
    MSG$(1) = "I can't pet"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L5C28:
    I = 1
    GOTO L5CFA
L5C33:
    W$ = MONNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L5C9C
    W$ = RIGHT$(W$, LEN(W$) - T)
L5C9C:
    IF NOT ((MONROOM(I) = ROOM) AND (W$ = NOUN$)) THEN GOTO L5CEF
    NMSG = 1
    MSG$(1) = "Do it yourself!"
    GOTO L1BD7
L5CEF:
    I = I + 1
L5CFA:
    IF I <= 10 THEN GOTO L5C33
    NMSG = 2
    MSG$(1) = "I can't kill"
    MSG$(2) = "a " + NOUN$ + "!"
    GOTO L1BD7
L5D46:
    I = 1
    GOTO L5DFC
L5D51:
    W$ = OBJNAME$(I)
    T = INSTR(W$, CHR$(32))
    IF T <= 0 THEN GOTO L5DBA
    W$ = RIGHT$(W$, LEN(W$) - T)
L5DBA:
    IF (OBJROOM(I) = 0) AND (W$ = NOUN$) THEN GOTO L5E48
    I = I + 1
L5DFC:
    IF I <= 22 THEN GOTO L5D51
    NMSG = 2
    MSG$(1) = "I don't have"
    MSG$(2) = "a " + NOUN$ + "."
    GOTO L1BD7
L5E48:
    IF I <> 12 THEN GOTO L5EDC
    IF MONROOM(9) <> ROOM THEN GOTO L5EDC
    NMSG = 4
    MSG$(1) = "The vampire"
    MSG$(2) = "sees the holy"
    MSG$(3) = "cross and"
    MSG$(4) = "disappears!"
    LOCATE MONROW(9), MONCOL(9)
    PRINT CHR$(32);
    MONROOM(9) = 0
    GOTO L1BD7
L5EDC:
    IF NOT ((MONROOM(10) = ROOM) OR (MONROOM(9) = ROOM)) THEN GOTO L5F1D
    NMSG = 5
    MSG$(1) = ""
    GOTO L4EEA
L5F1D:
    IF MONHERE <> 1 THEN GOTO L5F46
    NMSG = 5
    MSG$(1) = ""
    GOTO L4EEA
L5F46:
    NMSG = 3
    MSG$(1) = "There's not"
    MSG$(2) = "anyone to"
    MSG$(3) = "show it to!"
    GOTO L1BD7
L5F75:
    GET #1, 84
    NMSG = 5
    MSG$(1) = "Writing on the"
    MSG$(2) = "wall says..."
    MSG$(3) = ""
    IF STRING$(24, 0) <> FR1$ THEN GOTO L5FDD
    MSG$(4) = " No high score"
    MSG$(5) = ""
    GOTO L1BD7
L5FDD:
    MSG$(4) = FR1$
    MSG$(5) = FR2$
    MSG$(4) = LEFT$(MSG$(4), 14)
    MSG$(5) = LEFT$(MSG$(5), 14)
    GOTO L1BD7
L601E:
    OPEN "O", #2, NOUN$
    PRINT #2, ROOM
    PRINT #2, DOOR68LOCKED
    PRINT #2, DOOR82LOCKED
    PRINT #2, STRENGTH, PY, PX, UNDER, NCARRY
    I = 1
    GOTO L60E0
L609D:
    PRINT #2, OBJROOM(I), OBJROW(I), OBJCOL(I)
    I = I + 1
L60E0:
    IF I <= 22 THEN GOTO L609D
    I = 1
    GOTO L616B
L60FF:
    PRINT #2, MONROOM(I)
    PRINT #2, MONNAME$(I)
    PRINT #2, MONHP(I), MONROW(I), MONCOL(I)
    I = I + 1
L616B:
    IF I <= 10 THEN GOTO L60FF
    CLOSE #2
    NMSG = 1
    MSG$(1) = " Game Saved"
    GOTO L1BD7
L61A0:
    OPEN "A", #2, NOUN$
    CLOSE #2
    OPEN "I", #2, NOUN$
    IF EOF(2) <> -1 THEN GOTO L6221
    CLOSE #2
    KILL NOUN$
    NMSG = 3
    MSG$(1) = " There is no"
    MSG$(2) = " file named"
    MSG$(3) = " " + NOUN$
    GOTO L1BD7
L6221:
    INPUT #2, ROOM
    INPUT #2, DOOR68LOCKED
    INPUT #2, DOOR82LOCKED
    INPUT #2, STRENGTH, PY, PX, UNDER, NCARRY
    I = 1
    GOTO L62F8
L62AC:
    INPUT #2, OBJROOM(I), OBJROW(I), OBJCOL(I)
    I = I + 1
L62F8:
    IF I <= 22 THEN GOTO L62AC
    I = 1
    GOTO L638E
L6317:
    INPUT #2, MONROOM(I)
    INPUT #2, MONNAME$(I)
    INPUT #2, MONHP(I)
    I = I + 1
L638E:
    IF I <= 10 THEN GOTO L6317
    CLOSE #2
    GOTO L023E
L63B0:
    I = 13
    GOTO L63EE
L63BB:
    LOCATE I, 26
    PRINT SPACE$(15);
    I = I + 1
L63EE:
    IF I <= 19 THEN GOTO L63BB
    N2 = NMSG
    I = 1
    GOTO L645A
L6418:
    LOCATE I + 12, 26
    PRINT MSG$(I);
    I = I + 1
L645A:
    IF I <= N2 THEN GOTO L6418
L646E:
    IF INKEY$ <> "" THEN GOTO L646E
    I = 20
    GOTO L64BC
L6489:
    LOCATE I, 1
    PRINT SPACE$(39);
    I = I + 1
L64BC:
    IF I <= 25 THEN GOTO L6489
    LOCATE 25, 8, 0
    PRINT "Press any key to continue";
L64F4:
    IF INKEY$ = "" THEN GOTO L64F4
    CLS
    LOCATE 2, 6
    PRINT "You're have failed to Escape!"
    SCORE = 0
    W$ = ""
    GOTO L6577
L653F:
    CLS
    LOCATE 2, 7
    PRINT "You've Escaped the Castle!"
    SCORE = 100
    W$ = ""
L6577:
    I = 13
    GOTO L65FD
L6582:
    IF NOT ((OBJROOM(I) = 0) OR (OBJROOM(I) = 1)) THEN GOTO L65F2
    SCORE = SCORE + 50
    W$ = W$ + CHR$(OBJCHAR(I)) + " "
L65F2:
    I = I + 1
L65FD:
    IF I <= 22 THEN GOTO L6582
    IF NOT ((OBJROOM(2) = 0) OR (OBJROOM(2) = 1)) THEN GOTO L6670
    SCORE = SCORE + 50
    W$ = W$ + CHR$(OBJCHAR(2)) + " "
L6670:
    IF NOT ((OBJROOM(3) = 0) OR (OBJROOM(3) = 1)) THEN GOTO L66CC
    SCORE = SCORE + 50
    W$ = W$ + CHR$(OBJCHAR(3)) + " "
L66CC:
    IF NOT ((OBJROOM(12) = 0) OR (OBJROOM(12) = 1)) THEN GOTO L6728
    SCORE = SCORE + 50
    W$ = W$ + CHR$(OBJCHAR(12)) + " "
L6728:
    LOCATE 5, 2
    PRINT "You have collected these Treasues..."
    IF W$ <> "" THEN GOTO L675E
    W$ = "NONE"
L675E:
    X = 20 - LEN(W$) * 0.5
    LOCATE 7, X
    PRINT W$;
    W$ = ""
    I = 1
    GOTO L681E
L67BB:
    IF MONHP(I) >= 0 THEN GOTO L6813
    SCORE = SCORE + 100
    W$ = W$ + CHR$(MONCHAR(I)) + " "
L6813:
    I = I + 1
L681E:
    IF I <= 8 THEN GOTO L67BB
    LOCATE 10, 2
    PRINT "You have killed these Monsters......"
    IF W$ <> "" THEN GOTO L6868
    W$ = "NONE"
L6868:
    X = 20 - LEN(W$) * 0.5
    LOCATE 12, X
    PRINT W$;
    LOCATE 20, 12
    PRINT "Your Score:";SCORE;
    W$ = "MFT200O2L12DGBO3D4O2B4G4GABO3CO2BAGABO3C4"
    TUNE2$ = "MFT200O2L12DF#AO3C4O2A4D4F#GABAGF#AF#G4"
    IF SCORE <> 1550 THEN GOTO L6927
    LOCATE 21, 12
    PRINT "    PERFECT!"
    PLAY W$ + TUNE2$
L6927:
    IF SCORE >= 1550 THEN GOTO L6954
    LOCATE 21, 8
    PRINT "   (1550 is perfect)"
L6954:
    LOCATE 25, 10
    PRINT " - Press any key -";
L6971:
    IF INKEY$ <> "" THEN GOTO L6971
L6981:
    IF INKEY$ = "" THEN GOTO L6981
    GET #1, 84
    HISCORE = VAL(FR2$)
    IF SCORE > HISCORE THEN GOTO L6A42
    LOCATE 25, 10
    PRINT "Play Again (Y/N)?  ";
L69DE:
    K$ = INKEY$
    IF K$ = "" THEN GOTO L69DE
    IF NOT ((K$ = "y") OR (K$ = "Y")) THEN GOTO L6A38
    RANDOMIZE
    CLS
    PRINT "Loading...";
    GOTO L0039
L6A38:
    CLOSE
    END
L6A42:
    CLS
    LOCATE 2, 6
    PRINT "You have made the High Score!"
    LOCATE 5, 6
    PRINT "          ";SCORE
    LOCATE 15, 3, 1
    PRINT "Enter Your Name - ";
    NOUN$ = ""
    INPUT "", NOUN$
    IF LEN(NOUN$) <= 14 THEN GOTO L6B05
    LOCATE 15, 21
    PRINT SPACE$(LEN(NOUN$));
    GOTO L3769
L6B05:
    SC$ = STR$(SCORE)
    LSET FR1$ = NOUN$
    LSET FR2$ = SC$
    PUT #1, 84
    GOTO L6A38
L6B39:
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
    POKE 1050, PEEK(1052)
    PLAY "MF MS T200 P1"
    IF INKEY$ <> "" THEN GOTO L6D47
    PLAY "MF MS T200 O2 L12 D D D G2 P4"
    IF INKEY$ <> "" THEN GOTO L6D47
    PLAY "L12 D D D G2 P4"
    IF INKEY$ <> "" THEN GOTO L6D47
    PLAY "L12 D D D L8 G D G B A G A B O3 C2 P3"
    IF INKEY$ <> "" THEN GOTO L6D47
    PLAY "O2 L12 D D D L8 G D G B A G O3 C O2 A G2"
L6D47:
    LOCATE 25, 1
    PRINT "  P - to play    I - for instructions";
L6D64:
    K$ = INKEY$
    IF K$ = "" THEN GOTO L6D64
    IF NOT ((K$ = "p") OR (K$ = "P")) THEN GOTO L6DBB
    CLS
    PRINT "Loading...";
    RETURN
L6DBB:
    IF (K$ <> "i") AND (K$ <> "I") THEN GOTO L6D64
    I = 1
    GOTO L6E08
L6DEB:
    PRINT SPACE$(39)
    I = I + 1
L6E08:
    IF I <= 6 THEN GOTO L6DEB
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
    GOTO L6D47
L6F44:
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
L70D7:
    IF INKEY$ = "" THEN GOTO L70D7
    RETURN
L70EC:
    IF ERR = 53 THEN GOTO L710E
    CLS
    PRINT "UNRECOVERABLE ERROR! GET NEW COPY"
    GOTO L715A
L710E:
    CLS
    LOCATE 10, 2
    PRINT "You are missing the file CASTLE.RAN"
    LOCATE 12, 2
    PRINT "Call Kevin Bales at 321-3841 for"
    PRINT " a copy of this required data file."
L715A:
    POKE 1050, PEEK(1052)
L7173:
    K$ = INKEY$
    IF K$ = "" THEN GOTO L7173
    SCREEN 0, 0, 0
    CLS
    END
