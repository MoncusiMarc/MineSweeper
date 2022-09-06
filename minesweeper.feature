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

    //Rule: The Game is 
        Background: Initial State
            Given The Webpage is initiated
            * The 8 by 8 board is shown
            * All cells from the grid are non-flagged unopened and clickable
            * The New Game button is shown
            * The Mines counter displays a 10
            * The Timer counter displays a 00:00

    
    //Rule: The Game is in a Normal State
    //    Background: 
    //        Given The Webpage is initiated
    //        * The 8 by 8 board is shown
    //        * The New Game button is shown
    //        * The Mines counter displays a 10 or lower number
    //        * The Timer counter doesn't display 00:00
    
    Scenario:
        


    Scenario: New Game Button clicking
        When The user left-clicks on the New Game button
        Then The Webpage returns to the Initial State
    
    Scenario: Timer Starting
        When The user clicks on a cell
        Then The Timer starts running
    
    Scenario: Flag a cell
        When The user right-clicks on a non-flagged unopened cell
        Then The cell becomes a flagged unopened cell
        * The Mines counter drops by 1

    Scenario: Unflag a cell
        When The user right-clicks on a flagged unopened cell
        Then The cell becomes a non-flagged unopened cell
        * The Mines counter increases by 1
    
    Scenario: Opening a mined cell
        When The user left-clicks on a mined cell
        Then The cell opens
        * The Timer stops
        * The non-flagged unopened mined cells open
        * The flagged unopened numbered cells open and display a cross
        * The cells become unclickable
    
    Scenario: Opening a numbered cell
        When The user left-clicks on a numbered cell
        Then The cell opens
        * The cell becomes unclickable
    
    Scenario: Opening a numbered cell equal to 0
        When A "0" numbered cell opens
        Then The 8 adjacent cells open
        * The cells become unclickable    