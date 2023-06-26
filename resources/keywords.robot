*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           Collections


*** Keywords ***

Get Users
    [Arguments]     ${base_url}     ${endpoint}     ${app_id}     ${limit}=default_value     ${page}=default_value
    ${headers}    Create Dictionary    app-id=${app_id}
    ${query}     Set Variable     ?limit=${limit}&page=${page}
    #${url}=    Set Variable    url=${base_url}${endpoint}${query}
    ${response}     Get    ${base_url}${endpoint}     params=limit=${limit}&page=${page}      headers=${headers}     
    ${body_dict}=    Evaluate    json.loads($response.content)    json
    ${status_code}    Convert To String    ${response.status_code}
    [Return]     ${body_dict}     ${status_code}

Get User
    [Arguments]     ${base_url}     ${endpoint}     ${user_id}     ${app_id}
    ${headers}    Create Dictionary    app-id=${app_id}
    ${url}=    Set Variable    url=${base_url}${endpoint}
    ${response}     Get    ${url}     headers=${headers}
    ${body_dict}=    Evaluate    json.loads($response.content)    json
    ${status_code}    Convert To String    ${response.status_code}
    [Return]     ${body_dict}     ${status_code}

Verify Response Status Code
    [Arguments]    ${expected_status_code}    ${response}
    Should Be Equal   ${expected_status_code}     ${response}
     
Verify Response Body
    [Arguments]     ${expected_result}     ${response.content}
    Should Be Equal As Strings    ${response.content}    ${expected_result}
   
