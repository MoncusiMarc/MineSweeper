 const { Given, When, Then } = require('@cucumber/cucumber');
 const { expect } = require('@playwright/test');

 const testingurl = 'http://127.0.0.1:5500/Testing.html';



 Given('The Testing Webpage is initiated',async () => {
    await page.goto(testingurl);
});

