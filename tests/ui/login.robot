# Implementação — Robot Framework — Login

## Rastreabilidade
- Modelagem: [Isaac-Modelagem-UI-Login](Isaac-Modelagem-UI-Login)

## Arquivo de Script
`tests/ui/login.robot`

---

## Suite de Teste

​```robot
*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuário acessa a tela de login
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}              http://localhost:3000/login
${BROWSER}          chrome

${INPUT_EMAIL}      id=email
${INPUT_SENHA}      id=senha
${BOTAO_LOGIN}      id=btnLogin
${MENSAGEM}         id=mensagem

*** Test Cases ***
CT01 - Deve realizar login com credenciais válidas
    Dado que o usuário informa o email    usuario@email.com
    E informa a senha    12345678
    Quando solicitar o login
    Então o sistema deve redirecionar para a tela principal

CT02 - Deve validar email obrigatório
    Dado que o usuário informa o email    ${EMPTY}
    E informa a senha    12345678
    Quando solicitar o login
    Então o sistema deve apresentar a mensagem    Email é obrigatório

CT03 - Deve validar senha obrigatória
    Dado que o usuário informa o email    usuario@email.com
    E informa a senha    ${EMPTY}
    Quando solicitar o login
    Então o sistema deve apresentar a mensagem    Senha é obrigatória

CT04 - Deve validar credenciais incorretas
    Dado que o usuário informa o email    usuario@email.com
    E informa a senha    senhaerrada
    Quando solicitar o login
    Então o sistema deve apresentar a mensagem    Email ou senha inválidos

*** Keywords ***
Dado que o usuário acessa a tela de login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que o usuário informa o email
    [Arguments]    ${email}=${EMPTY}
    Input Text    ${INPUT_EMAIL}    ${email}

E informa a senha
    [Arguments]    ${senha}=${EMPTY}
    Input Password    ${INPUT_SENHA}    ${senha}

Quando solicitar o login
    Click Button    ${BOTAO_LOGIN}

Então o sistema deve redirecionar para a tela principal
    Location Should Contain    /home

Então o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${MENSAGEM}    ${mensagem}

E fecha o navegador
    Close Browser
​```

---

## Comando de Execução

​```bash
robot tests/ui/login.robot
​```
