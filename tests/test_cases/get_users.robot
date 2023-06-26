*** Settings ***
Resource          ../../resources/keywords.robot
Resource          ../../resources/variables.robot
Resource          ../../resources/test_data.resource
Resource          ../../resources/endpoint_list.resource

*** Test Cases ***
Get Users List Test
    [Documentation]       Test the get users list functionality with valid app_id
    [Tags]                Smoke   Regression   Functional
    ${response_body}   ${status_code}   Get Users     ${BASE_URL}     ${USER_LIST_ENDPOINT}     ${APP_ID}
    ${first_user}  Set Variable  ${response_body['data'][0]}
    Verify Response Status Code    200    ${status_code}
    Verify Response Body    ${expected_values}    ${first_user}
  
Get Users List Pagination Test
    [Documentation]       Test the get users list pagination functionality
    [Tags]                Functional
    ${response_body}   ${status_code}   Get Users     ${BASE_URL}     ${USER_LIST_ENDPOINT}     ${APP_ID}     5     2
    Verify Response Status Code    200    ${status_code}
    Verify Response Body    5    ${response_body['limit']}
    Verify Response Body    2    ${response_body['page']}
    Length Should Be    ${response_body['data']}    5
    
  
Get Users List Test with Invalid App_id
    [Documentation]       Test the get users list functionality with invalid app_id
    [Tags]                Security   Regression
    ${response_body}   ${status_code}     Run Keyword And Ignore Error     Get Users     ${BASE_URL}     ${USER_LIST_ENDPOINT}     ${INVALID_APP_ID}
    log    ${response_body}
    Verify Response Status Code    ${HTTP_ERROR}    ${status_code}
    


