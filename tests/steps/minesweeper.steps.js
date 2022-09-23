const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const testingUrl = 'http://127.0.0.1:5500/src/html/testing.html';



Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingUrl);
});

Then('The {string} shows: {string}', async (string, string2) =>{
    const display = await page.locator('data-testId='+string).innerText();
    expect(display).toBe(string2);
  });