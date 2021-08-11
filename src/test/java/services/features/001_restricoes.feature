Feature: CT 01 Consulta Restrições


  Background:
    * url apiUrl

  Scenario Outline: Consultar uma restrição pelo CPF - Positivo

    Given path "/restricoes/<cpf>"
    When method get
    Then status <status_code>
    And print response
    And match response.mensagem ==  "O CPF <cpf> tem problema"


    Examples:
      | cpf         | status_code |
      | 97093236014 | 200         |
      | 60094146012 | 200         |
      | 84809766080 | 200         |
      | 62648716050 | 200         |
      | 26276298085 | 200         |
      | 01317496094 | 200         |
      | 55856777050 | 200         |
      | 19626829001 | 200         |
      | 24094592008 | 200         |
      | 58063164083 | 200         |


  Scenario Outline: Consultar uma restrição pelo CPF - Negativo

    Given path "/restricoes/<cpf>"
    When method get
    Then status <status_code>
    And print response
    And match response ==  ""

    Examples:
      | cpf         | status_code |
      | 66156841873 |204        |
      | 82921172534 |204        |
      | 08632382624 |204        |
      | 95653373842 |204        |
      | 22251237135 |204        |