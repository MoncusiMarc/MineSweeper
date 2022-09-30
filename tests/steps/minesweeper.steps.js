const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const testingUrl = 'http://127.0.0.1:5500/src/html/testing.html';



Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingUrl);
});

Then('The {string} shows: {string}', async (string, string2) =>{
    const display = await page.locator('data-testid='+string).innerText();
    expect(display).toBe(string2);
  });

  When('the user opens the cell {string}', function (string) {
    // Write code here that turns the phrase above into concrete actions
    return 'pending';
  });

  Then('the cell {string} reveals: {string}', function (string, string2) {
    // Write code here that turns the phrase above into concrete actions
    return 'pending';
  });

  Then('The game is over', function () {
    // Write code here that turns the phrase above into concrete actions
    return 'pending';
  });