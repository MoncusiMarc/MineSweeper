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
    | x | 1 | 2 | 3 | 4 | 5 | 6 |
    | 1 | * | * | * | 3 | 1 | . |
    | 2 | * | 8 | * | * | 1 | . |
    | 3 | * | * | * | 5 | 2 | . |
    | 4 | 4 | 6 | * | * | 2 | . |
    | 5 | * | * | 7 | * | 3 | . |
    | 6 | 3 | * | * | * | 2 | . |
    
    In the scenarios, the first number represents the row, the second number represents the col
    '

    Background:
        Given The Testing Webpage is initiated

@done
    Scenario: Default mines value; number of mines - number of flags
        Then The 'Mines Counter' shows: '17' 

@done
    Scenario: Opening a mined cell and ending the game
        When The user opens the cell: '1-1'
        Then The cell '1-1' reveals: '*'
        And The game is over

@done
    Scenario Outline: Opening a numbered cell, and showing the number corresponding to the adjacent mines
        When The user opens the cell: '<coordinates>'
        Then The cell '<coordinates>' reveals: '<content>'

        Examples:
            | coordinates | content |
            |     1-6     |    0    |
            |     1-5     |    1    |
            |     3-5     |    2    |
            |     1-4     |    3    |
            |     4-1     |    4    |
            |     3-4     |    5    |
            |     4-2     |    6    |
            |     5-3     |    7    |
            |     2-2     |    8    |

@done
    Scenario: Opening a mine reveals all the other mines
        When The user opens the cell: '1-1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * |   | * | * |   |   |
            | * | * | * |   |   |   |
            |   |   | * | * |   |   |
            | * | * |   | * |   |   |
            |   | * | * | * |   |   |

@current
    Scenario: Flagging a cell when the user is certain there is a mine
        Given The 'Mines Counter' shows: '17'
        When The user flags the cell: '1-1'
        Then The cell '1-1' reveals: '!'
        And The 'Mines Counter' shows: '16'
    
    Scenario: Unflagging a cell to the normal state of the cell
        Given The cell '1-1' is flagged
        And The 'Mines Counter' shows: '16'
        When The user unflags the cell: '1-1'
        Then The cell '1-1' reveals: ' '
        And The 'Mines Counter' shows: '17'

    Scenario: Marking a cell when the user is unsure of the cell's content
        Given The 'Mines Counter' shows: '17'
        When The user marks the cell: '1-1'
        Then The cell '1-1' reveals: '?'
        And The 'Mines counter' shows: '17' 
    
    Scenario: Unmarking a cell
        Given The cell '1-1' us marked
        And The 'Mines Counter' shows: '17'
        When The user unmarks the cell: '1-1'
        Then The cell '1-1' reveals: ' '
        And The 'Mines Counter' shows: '17'
    
    Scenario: Opening a flagged cell hiding a number
        Given The cell '2-2' is flagged
        And The 'Mines Counter' shows:'16'
        When The user opens the cell: '2-2'
        Then The cell '2-2' reveals: '8'
        And The 'Mines Counter' shows: '17'

    Scenario: Opening a flagged cell hiding a mine
        Given The cell '1-1' is flagged
        And The 'Mines Counter' shows: '16'
        When The user opens the cell 'A1'
        Then The cell '2-2' reveals: '*'
        And The 'Mines Counter' shows: '16'

    Scenario: Opening a marked cell
        Given The cell '2-2' is marked
        When The user opens the cell: '2-2'
        Then The cell '2-2' reveals: '8'
    
    Scenario: Opening a mined cell with flagged cells on the board, those correctly flagged won't change, those incorrectly flagged will change to 'X'
        Given The user flaggs the cells:
        """
        1-1,2-2,3-3,4-4,5-5,6-6
        """
        And The 'Mines Counter' shows: '11'
        When The user opens the cell '1-1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * | X | * | * |   |   |
            | * | * | ! |   |   |   |
            |   |   | * | ! |   |   |
            | * | * |   | * | X |   |
            |   | * | * | * |   | X |
            And The 'Mines Counter' shows: '11'
        
    Scenario: Opening a mined cell with marked cells on the board, the mines will show, the numbered ones won't change
        Given The user marks the cells:
        """
        1-1,2-2,3-3,4-4,5-5,6-6
        """
        And The 'Mines Counter' shows: '17'
        When The user opens the cell '1-1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * | ? | * | * |   |   |
            | * | * | * |   |   |   |
            |   |   | * | * |   |   |
            | * | * |   | * | ? |   |
            |   | * | * | * |   | ? |
        And The 'Mines Counter' shows: '17'

    Scenario: Opening a cell with the number '0' opens the adjacent cells, if another '0' cell is found open adjacents (recursivity)
        When The user opens the cell: '1-6'
        Then The game board should show
            |   |   |   |   | 1 | . |
            |   |   |   |   | 1 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 3 | . |
            |   |   |   |   | 2 | . |

    Scenario: Opening the last not mined cell and winning the game
        Given The user opens the cells:
        """
        1-6,2-2,3-4,4-1,4-2,5-3,6-1
        """
        When the user opens the cell: '1-4'
        Then the cell '1-4' reveals: '3'
        And the Game is won

    Scenario: Opening a cell with the number '0' opens the adjacent cells, if a '!' cell is found cells that cell doesn't open
        Given The user flags the cells:
        """
        3-5,3-6
        """
        When The user interacts with the cell: '1-6'
        Then The game board should show
            |   |   |   |   | 1 | . |
            |   |   |   |   | 1 | . |
            |   |   |   |   | ! | ! |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |

    Scenario: Opening a cell with the number '0' opens the adjacent cells, if a '?' cell is found it gets opened normally
        Given The user marks the cells:
        """
        3-5,3-6
        """
        When The user interacts with the cell: '1-6'
        Then The game board should show
            |   |   |   |   | 1 | . |
            |   |   |   |   | 1 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 3 | . |
            |   |   |   |   | 2 | . |