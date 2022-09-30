const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const container = document.getElementById("container");

const ms = new minesweeper(testingMap);


window.onload = function () {
  generateBoard();
  ms.setMinesCounter();
}

function generateBoard(){
  container.style.setProperty('--grid-rows', ms.rows)
  container.style.setProperty('--grid-cols', ms.cols)
  for(let i = 0; i < ms.rows; i++){
    for(let j = 0; j < ms.cols; j++){
      let cell = document.createElement("div")
      container.appendChild(cell).className = "grid-item"
      cellListener(cell,i,j);
    }
  }
}
function cellListener(cell, row, col){
  cell.addEventListener('click',function(event){
    console.log('click')
    if(cell.textContent.trim() != ''){
      return;
    }
    else{
      switch(event.which){
        case 1:
          ms.openCell(row,col);
          break;
        case 3:
          break;
        default:
          break;
      }
    }
  });
}
