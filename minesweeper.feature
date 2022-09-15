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
    | x | A | B | C | D | E | F |
    | 1 | * | * | * | 3 | 1 | . |
    | 2 | * | 8 | * | * | 1 | . |
    | 3 | * | * | * | 5 | 2 | . |
    | 4 | 4 | 6 | * | * | 2 | . |
    | 5 | * | * | 7 | * | 3 | . |
    | 6 | 3 | * | * | * | 2 | . |
    
    '
    Background: Initial State
        Given The Testing Webpage is initiated
    
    Scenario: Mines counter
        Then The 'Mines counter' should show: '17' 

    Scenario Outline: Opening a cell to reveal adjacent mines
        When The user interacts with the cell: '<coordinates>'
        Then The cell '<coordinates>' should reveal: '<content>'

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


    Scenario: Opening a cell revealing a mine
        When The user interacts with the cell: 'A1'
        Then The cell 'A1' should reveal: '*'
        And The 'Game Over' message appears
    
    Scenario: Opening a cell and winning
        Given The game board state appears as
            |   |   |   |   | 1 | . |
            |   | 8 |   |   | 1 | . |
            |   |   |   | 5 | 2 | . |
            | 4 | 6 |   |   | 2 | . |
            |   |   | 7 |   | 3 | . |
            | 3 |   |   |   | 2 | . |
        When The user interacts with the cell: 'D1'
        Then The cell 'D1' should reveal: '3'
        And the 'Game Completed' message

    Scenario: Exploding all mines
        When The user interacts with the cell: 'A1'
        Then The game board should show
            | * | * | * |   |   |   |
            | * |   | * | * |   |   |
            | * | * | * |   |   |   |
            |   |   | * | * |   |   |
            | * | * |   | * |   |   |
            |   | * | * | * |   |   |
    
    Scenario: Marking a cell with ! where the mine is expected to be
        When The user marks the cell: 'A1'
        Then The cell 'A1' should reveal: '!'
        And The 'Mines counter' should show: '16' 
    
    Scenario: Marking a cell with !, negative numbers
        Given The game board state appears as
            | ! | ! | ! |   |   |   |
            | ! | ! | ! |   |   |   |
            | ! | ! | ! |   |   |   |
            | ! | ! | ! |   |   |   |
            | ! | ! | ! |   |   |   |
            | ! | ! |   |   |   |   |
        When The user marks the cell: 'C6'
        Then The 'Mines counter' should show: '-1'
    
    Scenario: Marking a cell with ? when you are unsure of the cell
        Given The game board state appears as
            | ! |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
        When The user marks the cell: 'A1'
        Then The cell 'A1' should reveal: '?'
        And The 'Mines counter' should show: '17' 
    
    Scenario: Unmarking a cell
        Given The game board state appears as
            | ? |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
        When The user marks the cell: 'A1'
        Then The cell 'A1' should reveal: ' '
    
    Scenario: Interacting with a '!' mark
        Given The game board state appears as
            |   |   |   |   |   |   |
            |   | ! |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
        When The user interacts with the cell 'B2'
        Then The cell 'B2' should reveal: '8'
    
    Scenario: Interacting with a '?' mark
        Given The game board state appears as
            |   |   |   |   |   |   |
            |   | ? |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
            |   |   |   |   |   |   |
        When The user interacts with the cell: 'B2'
        Then The cell 'B2' should reveal: '8'
    
    
    Scenario: Interacting with a zero opens the adjacent cells
        When The user interacts with the cell: 'F1'
        Then The game board should show
            |   |   |   |   | 1 | . |
            |   |   |   |   | 1 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 2 | . |
            |   |   |   |   | 3 | . |
            |   |   |   |   | 2 | . |
    