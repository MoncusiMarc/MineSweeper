const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const testingUrl = 'http://127.0.0.1:5500/src/html/testing.html';


async function interactCell(interaction,cell){
  switch(interaction){
    case 'opens':
      await page.click(`[data-testid="${cell}"]`, { force: true });
      break;
    case 'flags':
    case 'flagged':
        while( await page.locator('data-testid='+cell).innerText() != '!'){
        await page.click(`[data-testid="${cell}"]`, { button: 'right', force: true });}
      break
    case 'marks':
    case 'marked':
      while( await page.locator('data-testid='+cell).innerText() != '?'){
        await page.click(`[data-testid="${cell}"]`, { button: 'right', force: true });}
      break
    case 'unflags':
    case 'unmarks':
      while( await page.locator('data-testid='+cell).innerText() != ''){
        await page.click(`[data-testid="${cell}"]`, { button: 'right', force: true });}
      break
    default:
      return 'pending'
  }
}

async function CheckTable(twoDTable){
  for(let i=1;i<=twoDTable.length;i++){
    for(let j=1;j<=twoDTable[0].length;j++){
      var cell = await page.locator('data-testid='+i+'-'+j).innerText()
      if(twoDTable[i-1][j-1] ==  cell) {return 'failed'}
    }
  }
  return 'passed'
}

async function SplitDocString(interaction,docString){
  const CellArray = await docString.split(",")
  for(let i=0;i<CellArray.length;i++){
    await interactCell(interaction,CellArray[i])
  }
}

Given('The Testing Webpage is initiated',async () => {
  await page.goto(testingUrl);
});

Given('The cell {string} is {string}', async (string, string2) => {
  await interactCell(string2,string)
});

Given('The user {string} the cells:', async (string,docString) => {
  await SplitDocString(string,docString)
});

Then('The {string} shows: {string}', async (string, string2) =>{
  const display = await page.locator('data-testid='+string).innerText();
  expect(display).toBe(string2);
});

When('The user {string} the cell: {string}', async (string, string2) => {
    await interactCell(string,string2)
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

Then('The Game is won', async () => {
  const alert = await page.locator('data-testid=Game State').innerText();
  expect(alert).toBe('Game Won');
});