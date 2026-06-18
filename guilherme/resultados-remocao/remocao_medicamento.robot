*** Settings ***
Library    SeleniumLibrary

Suite Setup       Dado que o usuario acessa a lista de medicamentos
Suite Teardown    E fecha o navegador

*** Variables ***
${URL}                  http://localhost:3000/medicamentos
${BROWSER}              chrome
${BOTAO_REMOVER}        id=btnRemover
${BOTAO_CONFIRMAR}      id=btnConfirmar
${BOTAO_CANCELAR}       id=btnCancelar
${LOCATOR_MENSAGEM}     id=mensagem
${LISTA}                id=listaMedicamentos

*** Test Cases ***
CT-11-R1 - Deve remover medicamento com confirmacao
    Dado que existe um medicamento na lista    Losartana 50mg
    Quando o usuario clicar em remover
    E confirmar a remocao
    Entao o sistema deve apresentar a mensagem    Medicamento removido com sucesso
    E o medicamento nao deve estar na lista    Losartana 50mg

CT-11-R2 - Deve manter medicamento ao cancelar remocao
    Dado que existe um medicamento na lista    Atenolol 25mg
    Quando o usuario clicar em remover
    E cancelar a remocao
    Entao o medicamento deve permanecer na lista    Atenolol 25mg

CT-11-R3 - Deve manter medicamento ao fechar modal sem confirmar
    Dado que existe um medicamento na lista    Metformina 500mg
    Quando o usuario clicar em remover
    E fechar o modal sem confirmar
    Entao o medicamento deve permanecer na lista    Metformina 500mg

CT-11-R4 - Deve exibir erro ao tentar remover medicamento inexistente
    Quando o usuario tentar remover medicamento com id    med999
    Entao o sistema deve apresentar a mensagem    Medicamento nao encontrado

*** Keywords ***
Dado que o usuario acessa a lista de medicamentos
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Dado que existe um medicamento na lista
    [Arguments]    ${nome}
    Element Should Contain    ${LISTA}    ${nome}

Quando o usuario clicar em remover
    Click Button    ${BOTAO_REMOVER}

E confirmar a remocao
    Click Button    ${BOTAO_CONFIRMAR}

E cancelar a remocao
    Click Button    ${BOTAO_CANCELAR}

E fechar o modal sem confirmar
    Press Keys    NONE    ESCAPE

Quando o usuario tentar remover medicamento com id
    [Arguments]    ${id}
    Execute Javascript    removerMedicamento('${id}')

Entao o sistema deve apresentar a mensagem
    [Arguments]    ${mensagem}
    Element Text Should Be    ${LOCATOR_MENSAGEM}    ${mensagem}

E o medicamento nao deve estar na lista
    [Arguments]    ${nome}
    Element Should Not Contain    ${LISTA}    ${nome}

Entao o medicamento deve permanecer na lista
    [Arguments]    ${nome}
    Element Should Contain    ${LISTA}    ${nome}

E fecha o navegador
    Close Browser
