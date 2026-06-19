*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuário acessa a tela de listagem de medicamentos
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}                 http://localhost:3000/medicamentos
${BROWSER}             chrome

${BOTAO_REMOVER}       id=btnRemover
${BOTAO_CONFIRMAR}     id=btnConfirmar
${BOTAO_CANCELAR}      id=btnCancelar
${MENSAGEM}            id=mensagem
${LISTA_VAZIA}         id=listaMedicamentos

*** Test Cases ***
CT01 - Deve remover medicamento com confirmação
    Dado que existe um medicamento na lista
    Quando o usuário clicar em remover
    E confirmar a remoção
    Então o sistema deve apresentar a mensagem    Medicamento removido com sucesso

CT02 - Deve manter medicamento ao cancelar remoção
    Dado que existe um medicamento na lista
    Quando o usuário clicar em remover
    E cancelar a remoção
    Então o medicamento deve permanecer na lista

CT03 - Não deve exibir botão remover com lista vazia
    Dado que não existem medicamentos na lista
    Então o botão de remoção não deve estar visível

*** Keywords ***
Dado que o usuário acessa a tela de listagem de medicamentos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que existe um medicamento na lista
    Page Should Contain Element    ${BOTAO_REMOVER}

Dado que não existem medicamentos na lista
    Page Should Not Contain Element    ${BOTAO_REMOVER}

Quando o usuário clicar em remover
    Click Button    ${BOTAO_REMOVER}

E confirmar a remoção
    Click Button    ${BOTAO_CONFIRMAR}

E cancelar a remoção
    Click Button    ${BOTAO_CANCELAR}

Então o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${MENSAGEM}    ${mensagem}

Então o medicamento deve permanecer na lista
    Page Should Contain Element    ${BOTAO_REMOVER}

Então o botão de remoção não deve estar visível
    Page Should Not Contain Element    ${BOTAO_REMOVER}

E fecha o navegador
    Close Browser
