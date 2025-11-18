# Settings e Keywords
*** Settings ***
Library    RequestsLibrary

# ações/ palavras chaves compartilhadas. Nas keywords não colocar validações funcionais.
*** Keywords ***
Create Token
    [Arguments]    ${url}
# codigo relativo a criação do token acima. Monta o json com as duas variaveis name e password, faz um Post para a url e recebe uma msg de retorno guardada na variavel response.
    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=${url}/auth    json=${body}    verify=${False}
# apos o envio do usuario/senha, as informações são guardadas em uma variável token, conforme o script abaixo. 
    Status Should Be    200
    ${token}    Set Variable    ${response.json()}[token]
    # o suite variable deixa o token visivel para todos do projeto. Não é inclusa nas variaveis pois é mais restrita.
    Set Suite Variable    ${token}
    # verifica se o token está certo.
    Log To Console    ${token}

Get Booking Id
    # configura
    [Arguments]    ${url}    ${firstname}    ${lastname}    
    # executa / o primeiro separador é ?, nos demais é &
    ${response}    GET    url=${url}/booking?firstname=${firstname}&lastname=${lastname}
    # validação
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200

    # criar uma variável que guardará a lista extraida do bookingid
    ${booking_id}    Set Variable    ${response_body}[0][bookingid]
    # tornar a variavel bookin_id publica para todo o projeto
    Set Suite Variable    ${booking_id}
