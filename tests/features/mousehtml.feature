Feature: Mouse Features

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
