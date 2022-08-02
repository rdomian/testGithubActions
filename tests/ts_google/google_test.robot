*** Settings ***
Documentation       Resource file holding endpoint wrapper keywords and related commonly used helper keywords

Resource          ../res/kwds_selenium.robot


Library           SeleniumLibrary

*** Variables ***
${url}            https://google.com
${browser}        Chrome

*** Test Cases ***
Go To Google_1 - positive - feature1
    [Tags]    positive    feature1

    Create Driver with Custom Options    ${browser}
    Go To           ${url}


Go To Google_2 - negative - feature2
    [Tags]    negative    feature2


    Create Driver with Custom Options    ${browser}
    Go To           ${url}

Go To Google_new_test - negative - feature2
    [Tags]    negative    feature2


    Create Driver with Custom Options    ${browser}
    
Go To Google_3_fail_test - negative - feature2
    [Tags]    negative    feature2


    Create Driver with Custom Options    ${browser}
    #Click button     asdasd
