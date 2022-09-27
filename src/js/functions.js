const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const container = document.getElementById("container");

const ms = new minesweeper();

window.onload = function () {
    generateBoard();
    ms.setMines();
}

function generateBoard(){
    container.style.setProperty('--grid-rows', ms.rows)
    container.style.setProperty('--grid-cols', ms.cols)
    for (c = 1; c <= (ms.rows * ms.cols); c++) {
      let cell = document.createElement("div")
      cell.innerText = (c)
      container.appendChild(cell).className = "grid-item"
    for(i=0; i< ms.rows;i++)
    };
}
