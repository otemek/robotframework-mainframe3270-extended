*** Settings ***
Library    ExtendedMainframe3270       
Library    Collections    
Test Setup    Open mainframe connection
Test Teardown    Close mainframe connection


*** Variables ***
${pub400Host}    pub400.com
${sessionFile}    ${CURDIR}\\..\\resources\\pub400.wc3270


*** Keywords ***
Open mainframe connection
    Open Connection    host=${pub400Host}    isSessionFile=${False}

Close mainframe connection
    Close Connection


*** Test Cases ***
Open std host connection
    Sleep    2s
    
Open session connection
    [Setup]    NONE
    [Teardown]    NONE
    Open Connection    host=${sessionFile}    isSessionFile=${True}
    Sleep    2s
    Close Connection
    
Do a mainframe screenshot
    Sleep    2s
    Set Screenshot Folder    ${CURDIR}\\..\\Results\\
    Take Screenshot    format=jpg

Read cursor position 
    ${password_field}    Create List    6    25
    ${username_field}    Create List    ${5}    ${25}
    Move Next Field
    ${cur_position}    Get Current Cursor Position    
    Lists Should Be Equal    ${cur_position}    ${password_field}
    Move Next Field
    ${next_cur_position}    Get Current Cursor Position    return_type=int
    Lists Should Be Equal    ${next_cur_position}    ${username_field}    
    
Check If return value for found string
    @{server_name}    Read Value For Given String    Server name . . . :\ \ \ \     6    
    Should Be Equal As Strings    "${server_name}[0]"    "PUB400"

Check if return value for found string for specific col number
    @{display_name}    Read Value For Given String    Server name    6    70
    Should Be Equal As Strings    "${display_name}[0]"    "PUB400"         
    @{POWERbunker_IBM}    Read Value For Given String    POWERbunker    3    51
    Should Be Equal As Strings    "${POWERbunker_IBM}[0]"    "IBM"    

  
