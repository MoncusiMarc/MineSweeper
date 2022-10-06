const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const gameState = document.querySelector('[data-gameState]')
const container = document.getElementById("container")

const ms = new minesweeper(testingMap);

window.onload = function () {
  generateBoard()
  updateMinesCounter()
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
      cell.setAttribute('data-testid',cellVal)
      cellListener(cell,i,j);
    }
  }
}

function updateGame(){
  updateState()
  updateMinesCounter()
  updateBoard()
}

function updateBoard(){
  console.log('hi')
  for(let i = 1; i <= ms.rows; i++){
    for(let j = 1; j <= ms.cols; j++){
      let boardCell = ms.getCell(i-1,j-1)
      let cellVal = i+'-'+j
      let cell = document.getElementById(cellVal)
      if(!boardCell.opened){
        switch(boardCell.state){
          case 'flagged':
            if(boardCell.content != '*' && ms.getGameState() == 'lost') cell.innerText = 'X'
            else cell.innerText = '!'
            break
          case 'marked':
            cell.innerText = '?'
            break
          case 'none':
            cell.innerText = ''
            break
        }
      }else{
        console.log('hi2')
        if(boardCell.content == '*' && boardCell.state == 'flagged'){
          cell.innerText = '!'
        }
        else cell.innerText = boardCell.content
      }
    }
  }
}
function updateMinesCounter(){
  var mc = document.getElementById('minesCounter')
  mc.innerText = ms.getMines();
}

function nextCellState(cell,row,col){
  switch(cell.innerText){
    case '!':
      ms.markCell(row-1,col-1)
      break;
    case '':
      ms.flagCell(row-1,col-1)
      break;
    case '?':
      ms.noStateCell(row-1,col-1)
      break;
  }
}
function updateState(){
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

function cellListener(cell, row, col){
  cell.addEventListener('contextmenu', e=> e.preventDefault())
  cell.addEventListener('mousedown',function(event){
    console.log(event)
    if(!ms.getCell(row-1,col-1).opened){
    switch(event.which){
        case 1:
          ms.openCell(row-1,col-1)
          break
        case 3:
          nextCellState(cell,row,col)
          break
        default:
          break
    }
    updateGame()
  }
  });
}
