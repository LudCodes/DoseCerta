*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuario acessa a tela de cadastro de medicamentos
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}                 http://localhost:3000/medicamentos/novo
${BROWSER}             chrome
${INPUT_NOME}          id=nome
${INPUT_DOSAGEM}       id=dosagem
${INPUT_HORARIO}       id=horario
${BOTAO_SALVAR}        id=btnSalvar
${LOCATOR_MENSAGEM}    id=mensagem

*** Test Cases ***
CT-01-UI - Deve cadastrar medicamento com todos os campos validos
    Dado que o usuario informa o nome    Losartana
    E informa a dosagem    50 mg
    E informa o horario    08:00
    Quando solicitar o cadastro
    Entao o sistema deve apresentar a mensagem    Medicamento cadastrado com sucesso

CT-02-UI - Deve validar nome obrigatorio
    Dado que o usuario informa o nome
    E informa a dosagem    50 mg
    E informa o horario    08:00
    Quando solicitar o cadastro
    Entao o sistema deve apresentar a mensagem    Nome e obrigatorio

CT-03-UI - Deve validar dosagem obrigatoria
    Dado que o usuario informa o nome    Losartana
    E informa a dosagem
    E informa o horario    08:00
    Quando solicitar o cadastro
    Entao o sistema deve apresentar a mensagem    Dosagem e obrigatoria

CT-04-UI - Deve validar horario obrigatorio
    Dado que o usuario informa o nome    Losartana
    E informa a dosagem    50 mg
    E informa o horario
    Quando solicitar o cadastro
    Entao o sistema deve apresentar a mensagem    Horario e obrigatorio

*** Keywords ***
Dado que o usuario acessa a tela de cadastro de medicamentos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que o usuario informa o nome
    [Arguments]    ${nome}=${EMPTY}
    Input Text    ${INPUT_NOME}    ${nome}

E informa a dosagem
    [Arguments]    ${dosagem}=${EMPTY}
    Input Text    ${INPUT_DOSAGEM}    ${dosagem}

E informa o horario
    [Arguments]    ${horario}=${EMPTY}
    Input Text    ${INPUT_HORARIO}    ${horario}

Quando solicitar o cadastro
    Click Button    ${BOTAO_SALVAR}

Entao o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${LOCATOR_MENSAGEM}    ${mensagem}

E fecha o navegador
    Close Browser
