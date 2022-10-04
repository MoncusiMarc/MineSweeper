const defaultCell = {
    opened: false,
    state: 'none',
    content: '.'
}

class minesweeper {
    constructor(map=this.mapCreate()){
        this.board = map[1]
        this.rows = map[0][0]
        this.cols = map[0][1]
        this.mines = map[0][2]
        this.gameState = 'notFinished'
    }
    getMines(){
        return this.mines
    }
    getBoard(){
        return this.board
    }
    getCell(row,col){
        return this.board[row][col]
    }
    getGameState(){
        return this.gameState
    }

    mapCreate(rows=8,cols=8,mines=10){
        let mRow, mCol
        var board = new Array(rows)
        for(let i = 0; i<rows; i++){
            board[i] = []
            for (let j = 0; j <cols; j++) {
                board[i].push({...defaultCell})
            }
        }
        for (let i = 0; i < mines; i++) {
            do{
            mRow = Math.floor(Math.random() * rows)
            mCol = Math.floor(Math.random() * cols)
            }while(board[mRow][mCol].content == '*')
            board[mRow][mCol].content = '*'
        }
        return [[cols,rows,mines],board]
    }

    flagCell(row,col){this.board[row][col].state = 'flagged'}

    markCell(row,col){this.board[row][col].state = 'marked'}

    noStateCell(row,col){this.board[row][col].state = 'none'}

    openCell(row,col){
        this.board[row][col].opened = true
        switch(this.board[row][col].content){
            case '*':
                this.gameState = 'lost'
                this.openAllMines();
                break
            case '.':
                this.board[row][col].content = this.countAdjCells(row,col)
                if(this.board[row][col].content==0){
                    this.openAdjacentCells(row,col)
                }
                break
        }
    }

    openAdjacentCells(row,col){
        for(let i = row-1; i<=row+1; i++){
            for (let j = col-1; j <=col+1; j++) {
                if(i<0 || i>=this.rows){
                    continue}
                if(j<0 || j>=this.cols){
                    continue}
                if(!this.board[row][col].opened){
                    continue}
                this.openCell(i,j);
            }
        }
    }

    countAdjCells(row,col){
        let value=0;
        for(let i = row-1; i<=row+1; i++){
            for (let j = col-1; j <=col+1; j++) {
                if(i<0 || i>=this.rows){continue}
                if(j<0 || j>=this.cols){continue}
                if(this.board[i][j].content=='*'){
                    value++;
                }
            }
        }
        return value;
    }

    openAllMines(){
        for(let i = 0; i < this.rows; i++){
            for (let j = 0; j < this.cols; j++) {
                if(this.board[i][j].opened){
                    continue}
                if(this.board[i][j].content == '*'){
                    this.board[i][j].opened = true
                }
            }
        }
    }
}