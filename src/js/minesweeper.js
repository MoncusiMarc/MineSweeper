class minesweeper {
    constructor(map=this.mapCreate()){
        this.board = map[1];
        this.rows = map[0][0];
        this.cols = map[0][1];
        this.mines = map[0][2];
    }

    mapCreate(rows=8,cols=8,mines=10){
        let mRow, mCol;
        var board = new Array(rows).fill(' ').map(() => new Array(cols).fill('.'));
        
        for (let i = 0; i < mines; i++) {
            do{
            mRow = Math.floor(Math.random() * rows);
            mCol = Math.floor(Math.random() * cols);
            }while(board[mRow][mCol] == '*');
            board[mRow][mCol] = '*';
        }
        return [[cols,rows,mines],board];
    }

    displayMap(){
        this.board.forEach(element => {
            console.log(element);
        });
    }
}