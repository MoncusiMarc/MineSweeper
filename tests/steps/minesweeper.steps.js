 const { Given, When, Then } = require('@cucumber/cucumber');
 const { expect } = require('@playwright/test');

 const testingUrl = 'http://127.0.0.1:5500/src/testing.html';



 Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingUrl);
});
