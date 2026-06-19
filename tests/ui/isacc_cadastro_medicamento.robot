*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuário acessa a tela de cadastro de medicamento
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}                 http://localhost:3000/medicamentos/cadastro
${BROWSER}             chrome

${INPUT_NOME}          id=nome
${INPUT_DOSAGEM}       id=dosagem
${INPUT_HORARIO}       id=horario
${BOTAO_CADASTRAR}     id=btnCadastrar
${MENSAGEM}            id=mensagem

*** Test Cases ***
CT01 - Deve realizar cadastro com dados válidos
    Dado que o usuário informa o nome          Losartana
    E informa a dosagem                        50 mg
    E informa o horário                        08:00
    Quando solicitar o cadastro
    Então o sistema deve apresentar a mensagem    Cadastro realizado com sucesso

CT02 - Deve validar nome obrigatório
    Dado que o usuário informa o nome
    E informa a dosagem                        50 mg
    E informa o horário                        08:00
    Quando solicitar o cadastro
    Então o sistema deve apresentar a mensagem    Nome obrigatório

CT03 - Deve validar dosagem obrigatória
    Dado que o usuário informa o nome          Losartana
    E informa a dosagem
    E informa o horário                        08:00
    Quando solicitar o cadastro
    Então o sistema deve apresentar a mensagem    Dosagem obrigatória

CT04 - Deve validar horário inválido
    Dado que o usuário informa o nome          Losartana
    E informa a dosagem                        50 mg
    E informa o horário                        99:99
    Quando solicitar o cadastro
    Então o sistema deve apresentar a mensagem    Horário inválido

*** Keywords ***
Dado que o usuário acessa a tela de cadastro de medicamento
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que o usuário informa o nome
    [Arguments]    ${nome}=${EMPTY}
    Input Text    ${INPUT_NOME}    ${nome}

E informa a dosagem
    [Arguments]    ${dosagem}=${EMPTY}
    Input Text    ${INPUT_DOSAGEM}    ${dosagem}

E informa o horário
    [Arguments]    ${horario}=${EMPTY}
    Input Text    ${INPUT_HORARIO}    ${horario}

Quando solicitar o cadastro
    Click Button    ${BOTAO_CADASTRAR}

Então o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${MENSAGEM}    ${mensagem}

E fecha o navegador
    Close Browser
