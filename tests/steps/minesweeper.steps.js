const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const testingUrl = 'http://127.0.0.1:5500/src/html/testing.html';


async function CellClick(cell){
    await page.click('[data-testId="${buttonId}"]', { force: true });
}

Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingUrl);
});

Then('The {string} shows: {string}', async (string, string2) =>{
    const display = await page.locator('data-testId='+string).innerText();
    expect(display).toBe(string2);
  });

  When('the user opens the cell {string}', async (string) => {
    await CellClick(string);
  });

  Then('the cell {string} reveals: {string}', async (string, string2) =>{
    const cell = await page.locator('data-testId='+string).innerText();
    expect(cell).toBe(string2);
  });

  Then('The game is over', async () => {
    const alert = await page.locator('data-testId=Game State').innerText();
    expect(alert).toBe('Game Lost');
  });