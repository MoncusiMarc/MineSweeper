const minesCounter = document.querySelector('[data-mCounter]')
const timerCounter = document.querySelector('[data-tCounter]')
const newGame = document.querySelector('[data-newGame]')
const gameState = document.querySelector('[data-gameState]')
const container = document.getElementById('container')

var ms = null
if (window.location.href.indexOf('testing') > -1)  ms = new minesweeper(testingMap)
else  ms = new minesweeper()


window.onload = function () {
    generateBoard()
    updateMinesCounter()
}

function generateBoard() {
    container.style.setProperty('--grid-rows', ms.rows)
    container.style.setProperty('--grid-cols', ms.cols)
    for (let i = 1; i <= ms.rows; i++) {
        for (let j = 1; j <= ms.cols; j++) {
            let cell = document.createElement('div')
            let cellVal = i + '-' + j
            container.appendChild(cell).className = 'grid-item'
            cell.setAttribute('id', cellVal)
            cell.setAttribute('data-testid', cellVal)
            cellListener(cell, i, j)
        }
    }
}

function updateGame() {
    updateState()
    updateMinesCounter()
    updateBoard()
}

function updateBoard() {
    for (let i = 1; i <= ms.rows; i++) {
        for (let j = 1; j <= ms.cols; j++) {
            let boardCell = ms.getCell(i - 1, j - 1)
            let cellVal = i + '-' + j
            let cell = document.getElementById(cellVal)
            if (!boardCell.opened) {
                switch (boardCell.state) {
                    case 'flagged':
                        if (
                            boardCell.content != '*' &&
                            ms.getGameState() == 'lost'
                        ){
                            cell.innerText = 'X'
                            cell.setAttribute('data-ms','ex')
                        }
                        else{
                            cell.innerText = '!'
                            cell.setAttribute('data-ms','flagged')
                        }
                        break
                    case 'marked':
                        cell.innerText = '?'
                        cell.setAttribute('data-ms', 'marked')
                        break
                    case 'none':
                        cell.innerText = ''
                        cell.removeAttribute('data-ms')
                        break
                }
            } else {
                if (boardCell.content == '*' && boardCell.state == 'flagged') {
                    cell.innerText = '!'
                    cell.setAttribute('data-ms','flagged')
                }
                else {
                    cell.innerText = boardCell.content
                    cell.setAttribute('data-ms','opened')
                }
            }
        }
    }
}

function updateMinesCounter() {
    minesCounter.innerText = ms.getMines()
}

function nextCellState(cell, row, col) {
    switch (cell.innerText) {
        case '!':
            ms.markCell(row - 1, col - 1)
            break
        case '':
            ms.flagCell(row - 1, col - 1)
            break
        case '?':
            ms.noStateCell(row - 1, col - 1)
            break
    }
}

function updateState() {
    switch (ms.getGameState()) {
        case 'lost':
            gameState.innerText = 'Game Lost'
            break
        case 'won':
            gameState.innerText = 'Game Won'
            break
        default:
            gameState.innerText = ''
            break
    }
}

function cellListener(cell, row, col) {
    cell.addEventListener('contextmenu', (e) => e.preventDefault())
    cell.addEventListener('mousedown', function (event) {
        if(ms.getGameState() != 'lost'){
            if (!ms.getCell(row - 1, col - 1).opened) {
                switch (event.which) {
                    case 1:
                        ms.openCell(row - 1, col - 1)
                        break
                    case 3:
                        nextCellState(cell, row, col)
                        break
                    default:
                        break
                }
                updateGame()
            }
        }
    })
}

newGame.addEventListener('click', () => {
    if (window.location.href.indexOf('testing') > -1) ms = new minesweeper(testingMap)
    else  ms = new minesweeper()
    updateGame()
})
