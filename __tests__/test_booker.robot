# *** Variables *** ---> resources/variables.py
# *** Settings *** ---> resources/common.resource
# *** Test Cases *** ---> continuam no arquivo .robot
# *** Keywords *** ---> resources/common.resource

# Casos de teste
*** Settings ***
Library    RequestsLibrary
Resource    ../resources/common.resource
Resource    ../resources/common.resource
Variables    ../resources/variables.py
Suite Setup    Create Token    ${url}    

*** Test Cases ***
Create Booking
    # header é opcional neste caso
    ${headers}   Create Dictionary    Content-Type=${content_type}
    # está extratindo e carregando o conteudo do arquivo para uma variável $body
    ${body}    Evaluate    json.loads(open('./fixtures/json/booking1.json').read())

    ${response}    POST    url=${url}/booking    json=${body}    headers=${headers}    verify=${False}        

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[booking][firstname]    Bete
    Should Be Equal    ${response_body}[booking][lastname]    Pimentinha
    #Should Be Equal    ${response_body}[booking][totalprice]    130    
    Should Be Equal    ${response_body}[booking][depositpaid]    false
    Should Be Equal    ${response_body}[booking][bookingdates][checkin]    2025-11-10
    Should Be Equal    ${response_body}[booking][bookingdates][checkout]    2025-11-10
    Should Be Equal    ${response_body}[booking][additionalneeds]    Breakfast
    

