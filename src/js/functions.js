const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const gameState = document.querySelector('[data-gameState]')
const container = document.getElementById("container");

const ms = new minesweeper(testingMap);


window.onload = function () {
  generateBoard()
  setMinesCounter()
}

function generateBoard(){
  container.style.setProperty('--grid-rows', ms.rows)
  container.style.setProperty('--grid-cols', ms.cols)
  for(let i = 1; i <= ms.rows; i++){
    for(let j = 1; j <= ms.cols; j++){
      let cell = document.createElement("div")
      let cellVal = i+'-'+j
      container.appendChild(cell).className = "grid-item"
      cell.setAttribute('id',cellVal)
      cell.setAttribute('data-testId',cellVal)
      cellListener(cell,i,j);
    }
  }
}

function updateBoard(){
  for(let i = 1; i <= ms.rows; i++){
    for(let j = 1; j <= ms.cols; j++){
      let boardCell = ms.getCell(i-1,j-1)
      if(boardCell.opened == true){
        let cellVal = i+'-'+j
        let cell = document.getElementById(cellVal)
        cell.innerText = boardCell.content
      }
    }
  }
}

function checkState(){
  switch(ms.getGameState()){
    case 'lost':
      gameState.innerText = 'Game Lost';
      break;
    case 'won':
      gameState.innerText = 'Game Won';
      break;
    default:
      break;
  }
}

function setMinesCounter(){
  var mc = document.getElementById('minesCounter')
  mc.innerText = ms.getMines();
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
          ms.openCell(row-1,col-1);
          break;
        case 3:
          break;
        default:
          break;
      }
    }
    updateBoard();
    checkState();
  });
}
