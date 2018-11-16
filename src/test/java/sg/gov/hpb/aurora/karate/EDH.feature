Feature: Test EDH API
  Scenario: Fetch UEN
    #Given url 'https://edh.e.api.gov.sg/test/l2/v1/non-sgdrm/entities?uen=195000022H'
    Given url 'http://localhost:3000/test/l2/v1/non-sgdrm/entities?uen=T15SS0108F'
    When method GET
    Then status 200
    And match $.basic.uen == "T15SS0108F"
