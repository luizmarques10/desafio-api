Feature: CT 02 Simulações


  Background:
    * url apiUrl

  Scenario Outline: Cadastrar Simulações - Positivo
    Given path "/simulacoes"
    And request
        """
    {
        "nome": "<nome>",
        "cpf":  <cpf>,
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    When method post
    Then status <status_code>
    And print response
    And match response contains
    """
    {
        "nome": "<nome>",
        "cpf":  "<cpf>",
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    Examples:
      | nome                | cpf         | email                     | valor | parcela | seguro | status_code |
      | Ricardo Vasconcelos | 35107604684 | rr.vascncelos@exemplo.com | 1000  | 6       | true   | 201         |

  Scenario Outline: Cadastrar Simulações - Negativo
    Given path "/simulacoes"
    And request
    """
    {
        "nome": "<nome>",
        "cpf":  <cpf>,
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    When method post
    Then status <status_code>
    And print response
    And match response == <mensagem>

    Examples:
      | nome                | cpf         | email                     | valor | parcela | seguro | status_code | mensagem                                                |
      | Pierre Vasconcelos  | 64025718499 |                           | 1.000 | 6       | true   | 400         | {"erros":{"email": "E-mail deve ser um e-mail válido"}} |
      | Ricardo Vasconcelos | 35107604684 | rr.vascncelos@exemplo.com | 1.000 | 6       | true   | 400         | {"mensagem": "CPF duplicado"}                           |

  Scenario Outline: Alterar Simulações - Positivo
    Given path "/simulacoes/<cpf>"
    And request
        """
    {
        "nome": "<nome>",
        "cpf":  <cpf>,
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    When method put
    Then status <status_code>
    And print response
    And match response contains
    """
    {
        "nome": "<nome>",
        "cpf":  "<cpf>",
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    Examples:
      | nome                        | cpf         | email                     | valor | parcela | seguro | status_code |
      | Ricardo Almeida Vasconcelos | 35107604684 | rr.vascncelos@exemplo.com | 1000  | 24      | true   | 200         |

  Scenario Outline: Alterar Simulações - Negativo
    Given path "/simulacoes<cpf>"
    And request
    """
    {
        "nome": "<nome>",
        "cpf":  <cpf>,
        "email": "<email>",
        "valor": <valor>,
        "parcelas": <parcela>,
        "seguro": <seguro>
    }
   """
    When method put
    Then status <status_code>
    * def esultadoConsulta = response
    And print resultadoConsulta
    And match response.message == "No message available"

    Examples:
      | nome               | cpf         | email                     | valor | parcela | seguro | status_code |
      | Pierre Vasconcelos | 64025718499 | pr.vascncelos@exemplo.com | 1.000 | 6       | true   | 404         |


  Scenario: Consultar todas a Simulações
    Given path "/simulacoes"
    When method get
    Then status 200
    And print response

  Scenario Outline: Consultar Simulações por CPF

    Given path "/simulacoes/<cpf>"
    When method get
    And status <status_code>
    And print response


    Examples:
      | cpf         | status_code |
      | 35107604684 | 200         |
      | 22251237135 | 404         |

  Scenario Outline: Remover uma simulação

    Given path "/simulacoes/<cpf>"
    When method get
    * def id = response.id

    Given path "/simulacoes", id
    When method delete
    Then status <status_code>
    And print response


    Examples:
      | cpf         | status_code |
      | 35107604684 | 200         |
      | 22251237135 | 405         |