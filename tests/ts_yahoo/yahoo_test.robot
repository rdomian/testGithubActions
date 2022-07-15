*** Settings ***
Documentation       Resource file holding endpoint wrapper keywords and related commonly used helper keywords

Resource          ../res/kwds_selenium.robot
Suite Teardown        Run Keyword   Delete All Sessions


Library           SeleniumLibrary

*** Variables ***
${url}            https://yahoo.com
${browser}        Chrome

*** Test Cases ***
Go To Yahoo - positive - feature1
    [Tags]    positive    feature1

    Create Driver with Custom Options    ${browser}
    Go To           ${url}

Go To Yahoo - fail - feature2
    [Tags]    fail    feature2


    Create Driver with Custom Options    ${browser}
    Go To           ${url}
    Click Button     id:next