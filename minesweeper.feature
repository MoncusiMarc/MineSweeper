Feature: MineSweeper

    In Minesweeper, mines are scattered throughout a board, which is divided into cells.
    Cells have three states: unopened, opened and flagged.
    An unopened cell is blank and clickable, while an opened cell is exposed. 
    Flagged cells are those marked by the player to indicate a potential mine location.
    A player selects a cell to open it. If a player opens a mined cell, the game ends.
    Otherwise, the opened cell displays either a number, indicating the number of mines 
    diagonally and/or adjacent to it, or a blank tile (or "0"), and all adjacent non-mined 
    cells will automatically be opened. 
    Players can also flag a cell, visualised by a flag being put on the location, 
    to denote that they believe a mine to be in that place. 
    Flagged cells are still considered unopened, and a player can click on them to open them.
    In some versions of the game the number of adjacent mines is equal to the number of 
    adjacent flagged cells, all adjacent non-flagged unopened cells will be opened, 
    a process known as chording.

    Background: Initial State
        Given The Webpage is initiated
        * The 8 by 8 board is shown
        * All cells from the grid are non-flagged unopened
        * The "New Game" button is shown
        * The "Mines" button displays a 10
        * The "Timer" button displays a 00:00
    
    Background: Normal State
        Given The Webpage is initiated
        * The 8 by 8 board is shown
        * The "New Game" button is shown
        * The "Mines" button displays a 10 or lower number
        * The "Timer" button doesn't display 00:00

    Scenario: "New Game" Button clicking
