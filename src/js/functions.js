const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const container = document.getElementById("container");

const ms = new minesweeper(testingMap);

window.onload = function () {
  generateBoard();
  ms.setMines();
}

function generateBoard(){
  container.style.setProperty('--grid-rows', ms.rows)
  container.style.setProperty('--grid-cols', ms.cols)
  for(i = 0; i < ms.rows; i++){
    for(j = 0; j < ms.cols; j++){
      let cell = document.createElement("div")
      cell.innerText = ms.board[i][j]
      container.appendChild(cell).className = "grid-item"
      cellListener(cell,i,j);
    }
  }
}
function cellListener(cell, i, j){
  cell.addEventListener('click',function(event){

  });
}
