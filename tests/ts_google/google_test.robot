*** Settings ***
Documentation       Resource file holding endpoint wrapper keywords and related commonly used helper keywords

Resource          ../res/kwds_selenium.robot


Library           SeleniumLibrary

*** Variables ***
${url}            https://google.com
${browser}        Chrome

*** Test Cases ***
Go To Google - positive - feature1
    [Tags]    positive    feature1

    Create Driver with Custom Options    ${browser}
    Go To           ${url}


Go To Google - negative - feature2
    [Tags]    negative    feature2
    
    


    Create Driver with Custom Options    ${browser}
    Go To           ${url}

# Some fail test - negative - feature2
#     [Tags]    negative    feature2


#     Create Driver with Custom Options    ${browser}
#     Click Button         asdasd
