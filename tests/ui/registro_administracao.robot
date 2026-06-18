
- Modelagem: [Isaac-Modelagem-UI-Registro-de-Administração](Isaac-Modelagem-UI-Registro-de-Administração)

`tests/ui/registro_administracao.robot`

---


​```robot
*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuário acessa a tela de registro de administração
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}                  http://localhost:3000/administracoes/novo
${BROWSER}              chrome

${SELECT_MEDICAMENTO}   id=medicamento
${INPUT_DATAHHORA}      id=dataHora
${BOTAO_REGISTRAR}      id=btnRegistrar
${MENSAGEM}             id=mensagem

*** Test Cases ***
CT01 - Deve registrar administração com dados válidos
    Dado que o usuário seleciona o medicamento    Losartana 50 mg
    E informa a data e hora    17/06/2026 08:00
    Quando solicitar o registro
    Então o sistema deve apresentar a mensagem    Administração registrada com sucesso

CT02 - Deve validar medicamento obrigatório
    Dado que o usuário não seleciona o medicamento
    E informa a data e hora    17/06/2026 08:00
    Quando solicitar o registro
    Então o sistema deve apresentar a mensagem    Medicamento é obrigatório

CT03 - Deve validar data e hora obrigatórias
    Dado que o usuário seleciona o medicamento    Losartana 50 mg
    E não informa a data e hora
    Quando solicitar o registro
    Então o sistema deve apresentar a mensagem    Data e hora são obrigatórias

*** Keywords ***
Dado que o usuário acessa a tela de registro de administração
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que o usuário seleciona o medicamento
    [Arguments]    ${medicamento}
    Select From List By Label    ${SELECT_MEDICAMENTO}    ${medicamento}

Dado que o usuário não seleciona o medicamento
    Select From List By Index    ${SELECT_MEDICAMENTO}    0

E informa a data e hora
    [Arguments]    ${dataHora}
    Input Text    ${INPUT_DATAHHORA}    ${dataHora}

E não informa a data e hora
    Clear Element Text    ${INPUT_DATAHHORA}

Quando solicitar o registro
    Click Button    ${BOTAO_REGISTRAR}

Então o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${MENSAGEM}    ${mensagem}

E fecha o navegador
    Close Browser
​```

---


​```bash
robot tests/ui/registro_administracao.robot
​```
