Feature: Minesweeper Testing Features

    'In Minesweeper, mines are scattered throughout a board, which is divided into cells.
    Cells have 2 categories: Their State and their Content
    
    The State of a cell can be divided in opened, hidden and flagged.
    
    Hidden cells are blank and clickable and can be flagged or not.
    
    Opened cells are exposed and reveal the content of that cell.
    
    Flagged cells are those marked by the player to indicate a potential mine location.
    Flagged cells are still considered hidden, and a player can click on them to open them.
    Players can flag a hidden cell by right clicking the cell.
    Players can unflag a hidden cell by right clicking the flagged cell.

    The Content of the cell can be a mine or a number.
    If a player opens a mined cell, the game ends.
    Mines are represented by : "*"

    Otherwise, the opened cell displays a number, indicating the number of mines diagonally and orthogonally adjacent to it.
    When the number of mines adjacent is  "0" it is represented by a blank tile ("."), and all adjacent cells will automatically open.

    Simbology:
    "*" Represents a mine
    
    "." Represents there are . mines around the number
    "1" Represents there is 1 mine around the number
    "2" Represents there are 2 mines around the number
    "3" Represents there are 3 mines around the number
    "4" Represents there are 4 mines around the number
    "5" Represents there are 5 mines around the number
    "6" Represents there are 6 mines around the number
    "7" Represents there are 7 mines around the number
    "8" Represents there are 8 mines around the number
    "F" Represents a flagged cell
    "X" Represents a not mined cell flagged, shown when the game ends

    Testing board:
        A B C D E F G H
       ________________
    1 | * * * * * * * *
    2 | * 8 * 7 6 5 4 2
    3 | * * * * * * 1 .
    4 | 2 3 3 3 3 2 1 .
    5 | . . . . . . . .
    6 | . . . . . . . .
    7 | . . . . . . . .
    8 | . . . . . . . .
    
    '

    Background: Initial State
        Given The Testing Webpage is initiated
        And The board is shown
        And The counter modifier is shown

    Scenario Outline: Opening a cell
        When The user left-clicks the cell: '<coordinates>'
        Then The cell '<coordinates>' should reveal: '<content>'

        Examples:
            | coordinates | content |
            |     A1      |    *    |
            |     B2      |    8    |
            |     A5      |    .    |
    
    Scenario: Exploding a mine
        When The user left-clicks the cell: 'A1'
        Then The cell 'A1' should reveal: '*'
        And The cell 'B1' should reveal: '*'
        And The cell 'C1' should reveal: '*'
        And The cell 'D1' should reveal: '*'
        And The cell 'E1' should reveal: '*'
        And The cell 'F1' should reveal: '*'
        And The cell 'G1' should reveal: '*'
        And The cell 'H1' should reveal: '*'
        And The cell 'A3' should reveal: '*'
        And The cell 'B3' should reveal: '*'
        And The cell 'C3' should reveal: '*'
        And The cell 'D3' should reveal: '*'
        And The cell 'E3' should reveal: '*'
        And The cell 'F3' should reveal: '*'
    
    Scenario: Exploding a mine with flags
        Given The user right-clicks the cell: 'A1'
        And The user right-clicks the cell: 'B2'
        When The user left-clicks the cell: 'A2'
        Then The cell 'A1' should reveal: 'F'
        And The cell 'B1' should reveal: '*'
        And The cell 'C1' should reveal: '*'
        And The cell 'D1' should reveal: '*'
        And The cell 'E1' should reveal: '*'
        And The cell 'F1' should reveal: '*'
        And The cell 'G1' should reveal: '*'
        And The cell 'H1' should reveal: '*'
        And The cell 'A3' should reveal: '*'
        And The cell 'B3' should reveal: '*'
        And The cell 'C3' should reveal: '*'
        And The cell 'D3' should reveal: '*'
        And The cell 'E3' should reveal: '*'
        And The cell 'F3' should reveal: '*'
        And The cell 'B2' should reveal: 'X'

    Scenario: Flag a cell
        When The user right-clicks the cell: 'A1'
        Then The cell 'A1' should reveal: 'F'
        And The mines counter modifies by "-1"
    
    Scenario: Unflag a cell
        Given The user right-clicks the cell: 'A1'
        When The user right-clicks the cell 'A1'
        Then The cell 'A1' should reveal: 'F'
        And The mines counter modifies by "1"
