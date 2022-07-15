*** Settings ***
Documentation       Resource file holding endpoint wrapper keywords and related commonly used helper keywords


Library           SeleniumLibrary

*** Keywords ***
Create Driver with Custom Options
    [Arguments]     ${browser}

    Run Keyword If  '${browser}'=='Chrome'      Run Keyword     Chrome
    ...  ELSE       Fail       Unable to create driver for unrecognized browser "${browser}"

Chrome
    ${options}=     Evaluate        sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method     ${options}      add_argument                                         incognito
    Call Method     ${options}      add_argument                                         headless
    Call Method     ${options}      add_argument                                         no-sandbox
    Create WebDriver    Chrome      chrome_options=${options}

Login Using Browser
    [Arguments]    ${url}    ${browser}=

    Create Driver with Custom Options    Chrome
    Go To           ${url}