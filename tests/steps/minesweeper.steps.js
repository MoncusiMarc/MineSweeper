const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const testingUrl = 'http://127.0.0.1:5500/src/html/testing.html';


async function clickCell(cell){
    await page.click(`[data-testId="${cell}"]`, { force: true });
}
async function flagCell(cell){
    while(page.locator('data-testid='+cell).innerText() != '!'){
    await page.click(`[data-testId="${cell}"]`, { button: "right" }, { force: true });}
}
async function markCell(cell){
  while(page.locator('data-testid='+cell).innerText() != '?'){
    await page.click(`[data-testId="${cell}"]`, { button: "right" }, { force: true });}
}
async function unflagCell(cell){
  while(page.locator('data-testid='+cell).innerText() != ''){
  await page.click(`[data-testId="${cell}"]`, { button: "right" }, { force: true });}
}
async function unmarkCell(cell){
while(page.locator('data-testid='+cell).innerText() != ''){
  await page.click(`[data-testId="${cell}"]`, { button: "right" }, { force: true });}
}

async function CheckTable(twoDTable){ //TODO: check for ! when they appear
  for(let i=1;i<=twoDTable.length;i++){
    for(let j=1;j<=twoDTable[0].length;j++){
      var cell = await page.locator('data-testid='+i+'-'+j).innerText();
      if(twoDTable[i-1][j-1] == '*' && cell != '*'){return 'failed'}
    }
  }
  return 'passed'
}



Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingUrl);
});

Then('The {string} shows: {string}', async (string, string2) =>{
    const display = await page.locator('data-testid='+string).innerText();
    expect(display).toBe(string2);
  });

When('The user opens the cell: {string}', async (string) => {
  await clickCell(string);
});

When('The user flags the cell: {string}', async (string) =>{
  await flagCell(string);
});

Then('The cell {string} reveals: {string}', async (string, string2) =>{
  const cell = await page.locator('data-testid='+string).innerText();
  expect(cell).toBe(string2);
});

Then('The game board should show', async (dataTable) => {
  return CheckTable(dataTable.raw());;
});

Then('The game is over', async () => {
  const alert = await page.locator('data-testid=Game State').innerText();
  expect(alert).toBe('Game Lost');
});