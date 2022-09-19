Feature: Minesweeper Testing Features

    '
    Simbology:
    " " Represents a hidden cell
    "*" Represents a mine
    "." Represents there are 0 mines around the number
    "1" Represents there is 1 mine around the number
    "2" Represents there are 2 mines around the number
    "3" Represents there are 3 mines around the number
    "4" Represents there are 4 mines around the number
    "5" Represents there are 5 mines around the number
    "6" Represents there are 6 mines around the number
    "7" Represents there are 7 mines around the number
    "8" Represents there are 8 mines around the number
    "!" Represents a cell when the user is sure the content of the cell is a mine
    "?" Represents a cell when the user is not sure about the content of the cell
    "X" Represents a not mined cell flagged with a "!" when the game is over

    Testing board:
    | x | A | B | C | D | E | F |
    | 1 | * | * | * | 3 | 1 | . |
    | 2 | * | 8 | * | * | 1 | . |
    | 3 | * | * | * | 5 | 2 | . |
    | 4 | 4 | 6 | * | * | 2 | . |
    | 5 | * | * | 7 | * | 3 | . |
    | 6 | 3 | * | * | * | 2 | . |
    
    '

    Background:
        Given The Testing Webpage is initiated

    Scenario: Default mines value; number of mines - number of flags
        Then The 'Mines Counter' shows: '17' 

    Scenario: Revealing a cell with the mouse
        When The user left-clicks with the mouse the cell: 'A1'
        Then The cell 'A1' opens

    //can we right click from a cell's state?
    Scenario: Flagging a cell with the mouse, '!'
        When The user right-clicks with the mouse the cell: 'A1'
        Then The cell 'A1' is flagged

    Scenario: UnFlagging a cell with the mouse, '!'
        Given The user right-clicks with the mouse the cell: 'A1'
        And The user right-clicks with the mouse the cell: 'A1'
        When The user right-clicks with the mouse the cell: 'A1'
        Then The cell 'A1' is unflagged

    Scenario: Marking a cell with the mouse, '?'
        Given The user right-clicks with the mouse the cell: 'A1'
        When The user right-clicks with the mouse the cell: 'A1'
        Then The cell 'A1' is marked

    Scenario: Unmarking a cell with the mouse, '?'
        Given The user right-clicks with the mouse the cell: 'A1'
        And The user right-clicks with the mouse the cell: 'A1'
        And The user right-clicks with the mouse the cell: 'A1'
        When The user right-clicks with the mouse the cell: 'A1'
        Then The cell 'A1' is unmarked

    Scenario: Opening a mined cell and ending the game
        When the user opens the cell 'A1'
        Then the cell 'A1' reveals: '*'
        And The game is over

    Scenario Outline: Opening a numbered cell, and showing the number corresponding to the adjacent mines
        When The user opens the cell: '<coordinates>'
        Then The cell '<coordinates>' reveals: '<content>'

        Examples:
            | coordinates | content |
            |     F1      |    .    |
            |     E1      |    1    |
            |     E3      |    2    |
            |     D1      |    3    |
            |     A4      |    4    |
            |     D3      |    5    |
            |     B4      |    6    |
            |     C5      |    7    |
            |     B2      |    8    |

    Scenario: Opening the last not mined cell and winning the game
        Given The user opens the cells:
        '''
        F1 , B2 , D3 , A4 , B4 , C5 , A6
        '''
        When the user opens the cell: 'D1'
        Then the cell 'D1' reveals: '3'
        And the Game is won
    //F1 assume 0 bomb recursivity is already implemented

    Scenario: Opening a mine reveals all the other mines
        When The user interacts with the cell: 'A1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * |   | * | * |   |   |
            | * | * | * |   |   |   |
            |   |   | * | * |   |   |
            | * | * |   | * |   |   |
            |   | * | * | * |   |   |

    Scenario: Flagging a cell when the user is certain there is a mine
        Given The 'Mines Counter' shows: '17'
        When The user flags the cell: 'A1'
        Then The cell 'A1' reveals: '!'
        And The 'Mines Counter' shows: '16'
    
    Scenario: Unflagging a cell to the normal state of the cell
        Given The cell 'A1' is flagged
        And The 'Mines Counter' shows: '16'
        When The user unflags the cell: 'A1'
        Then The cell 'A1' reveals: ' '
        And The 'Mines Counter' shows: '17'

    Scenario: Marking a cell when the user is unsure of the cell's content
        Given The 'Mines Counter' shows: '17'
        When The user marks the cell: 'A1'
        Then The cell 'A1' reveals: '?'
        And The 'Mines counter' shows: '17' 
    
    Scenario: Unmarking a cell
        Given The cell 'A1' us marked
        And The 'Mines Counter' shows: '17'
        When The user unmarks the cell: 'A1'
        Then The cell 'A1' reveals: ' '
        And The 'Mines Counter' shows: '17'
    
    Scenario: Opening a flagged cell hiding a number
        Given The cell 'B2' is flagged
        And The 'Mines Counter' shows:'16'
        When The user opens the cell: 'B2'
        Then The cell 'B2' reveals: '8'
        And The 'Mines Counter' shows: '17'

    Scenario: Opening a flagged cell hiding a mine
        Given The cell 'A1' is flagged
        And The 'Mines Counter' shows: '16'
        When The user opens the cell 'A1'
        Then The cell 'B2' reveals: '*'
        And The 'Mines Counter' shows: '16'

    Scenario: Opening a marked cell
        Given The cell 'B2' is marked
        When The user opens the cell: 'B2'
        Then The cell 'B2' reveals: '8'
    
    Scenario: Opening a mined cell with flagged cells on the board, those correctly flagged won't change, those incorrectly flagged will change to 'X'
        Given The user flaggs the cell:
        '''
        A1, B2, C3, D4, E5, F6
        '''
        And The 'Mines Counter' shows: '11'
        When The user opens the cell 'A1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * | X | * | * |   |   |
            | * | * | ! |   |   |   |
            |   |   | * | ! |   |   |
            | * | * |   | * | X |   |
            |   | * | * | * |   | X |
            And The 'Mines Counter' shows: '11'
        
    Scenario: Opening a mined cell with marked cells on the board, the mines will show, the numbered ones won't change
        Given The user marks the cell:
        '''
        A1, B2, C3, D4, E5, F6
        '''
        And The 'Mines Counter' shows: '17'
        When The user opens the cell 'A1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * | ? | * | * |   |   |
            | * | * | * |   |   |   |
            |   |   | * | * |   |   |
            | * | * |   | * | ? |   |
            |   | * | * | * |   | ? |
        And The 'Mines Counter' shows: '17'

    Scenario: Interacting with a zero opens the adjacent cells, and the opened cells if are zero 
        When The user interacts with the cell: 'F1'
        Then The game board should show
            |   |   |   |   | 1 | . |
            |   |   |   |   | 1 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 3 | . |
            |   |   |   |   | 2 | . |
    