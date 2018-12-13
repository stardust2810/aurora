Feature: Test EDH API

Background:
    * url 'https://edh.api.gov.sg/test/l2-eg/v1'

#for methodcall only with no path, no query
Scenario Outline: DT001
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>)

    Given path <methodcall>+<parameter1>+<value1>
    And header Authorization = token
    And header Accept = 'application/json'
    When method get
    Then status <statuscode>

    Examples:
    | methodcall | parameter1 | value1   | statuscode   |
    | 'entities' |''| ''  | 400  |

  Scenario: Search Entities with issuance_agencies parameter filled with a single valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?issuance_agencies=MOM')
    And header Authorization = token
    And header Accept = 'application/json'
    And param issuance_agencies = 'MOM'
    When method GET
    Then status 200


  Scenario: Search Entities with issuance_agencies parameter filled with multiple valid values
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?issuance_agencies=MOM,MCCY')
    And header Authorization = token
    And header Accept = 'application/json'
    And param issuance_agencies = 'MOM,MCCY'
    When method GET
    Then status 200


  Scenario: Search Entities with issuance_agencies parameter filled with invalid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?issuance_agencies=A')
    And header Authorization = token
    And header Accept = 'application/json'
    And param issuance_agencies = 'A'
    When method GET
    Then status 400


  Scenario: Search Entities with the last updated from and last updated to parameters filled with valid values
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_from=2017-01-01&last_updated_to=2018-01-01')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_from = '2017-01-01'
    And param last_updated_to = '2018-01-01'
    When method GET
    Then status 200


  Scenario: Search Entities with only the last updated from parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_from=2018-01-01')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_from = '2018-01-01'
    When method GET
    Then status 400


  Scenario: Search Entities with only the last updated to parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_to=2018-01-01')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_to = '2018-01-01'
    When method GET
    Then status 400


  Scenario: Search Entities with the last updated from parameter filled with an invalid value and with the last updated to parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_from=01-01-2017&last_updated_to=2018-01-01')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_from = '01-01-2017'
    And param last_updated_to = '2018-01-01'
    When method GET
    Then status 500


  Scenario: Search Entities with the last updated from parameter filled with a valid value and with the last updated to parameter filled with an invalid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_from=2017-01-01&last_updated_to=01-01-2018')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_from = '2017-01-01'
    And param last_updated_to = '01-01-2018'
    When method GET
    Then status 500

  Scenario: Search Entities with the last updated from parameter filled with a valid value greater than the valid value that fills the last updated to parameter
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?last_updated_from=2018-01-01&last_updated_to=2017-01-01')
    And header Authorization = token
    And header Accept = 'application/json'
    And param last_updated_from = '2018-01-01'
    And param last_updated_to = '2017-01-01'
    When method GET
    Then status 400


Scenario: Search Entities with the name and name_criteria parameters filled with valid values
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?name=and&name_criteria=contains')
    And header Authorization = token
    And header Accept = 'application/json'
    And param name = 'and'
    And param name_criteria = 'contains'
    When method GET
    Then status 200



Scenario: Search Entities with only the name parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?name=and')
    And header Authorization = token
    And header Accept = 'application/json'
    And param name = 'and'
    When method GET
    Then status 400


Scenario: Search Entities with only the name_criteria parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?name_criteria=contains')
    And header Authorization = token
    And header Accept = 'application/json'
    And param name_criteria = 'contains'
    When method GET
    Then status 400

Scenario: Search Entities with the name parameter filled with an invalid value and with the name_criteria parameter filled with a valid value
    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities','?name=a&name_criteria=contains')
    And header Authorization = token
    And header Accept = 'application/json'
    And param name = 'a'
    And param name_criteria = 'contains'
    When method GET
    Then status 400


Scenario Outline: DT015
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>)
    * def query = { name: <value1>, name_criteria: <value2> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | statuscode   |
    |'?name='| 'and'  |'&name_criteria='| 'invalid'  | 400  |

Scenario Outline: DT016, DT017, DT018
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter>+<value>)

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And param types = <value>
    When method get
    Then status <statuscode>

    Examples:
    | parameter | value   | statuscode   |
    |'?types='| 'LC'  | 200  |
    |'?types='| 'LC,FC'  | 200  |
    |'?types='| 'A'  | 400  |

Scenario Outline: DT019, DT020, DT021
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter>+<value>)

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And param uens = <value>
    When method get
    Then status <statuscode>

    Examples:
    | parameter | value   | statuscode   |
    |'?uens='| '198102460H'  | 200  |
    |'?uens='| '198102460H,198104639K'  | 200  |
    |'?uens='| '12345678900'  | 400  |

Scenario Outline: DT022
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>+<parameter3>+<value3>+<parameter4>+<value4>+<parameter5>+<value5>+<parameter6>+<value6>)
    * def query = { issuance_agencies: <value1>, last_updated_from: <value2>, last_updated_to: <value3>, name: <value4>, name_criteria: <value5>, types: <value6> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | parameter3 | value3   | parameter4 | value4   | parameter5 | value5   | parameter6 | value6   | statuscode   |
    |'?issuance_agencies='| 'MCCY'  |'&last_updated_from='| '2010-01-01'  |'&last_updated_to='| '2018-01-01'  |'&name='| 'and'  |'&name_criteria='| 'contains'  |'&types='| 'CC'  | 200  |


Scenario Outline: DT023
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>)
    * def query = { fields: <value1> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | statuscode   |
    |'?fields='| 'uen'  | 400  |

Scenario Outline: DT024, DT025, DT026
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>)
    * def query = { fields: <value1>, uens: <value2> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | statuscode   |
    |'?fields='| 'uen'  |'&uens='| '198102460H' | 200  |
    |'?fields='| 'uen,uenStatus'  |'&uens='| '198102460H' | 200  |
    |'?fields='| 'invalid'  |'&uens='| '198102460H' | 400  |

Scenario Outline: DT027
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>)
    * def query = { skip: <value1> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | statuscode   |
    |'?skip='| '5'  | 400  |

Scenario Outline: DT028, DT029, DT030, DT031, DT032, DT033
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>)
    * def query = { skip: <value1>, types: <value2> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | statuscode   |
    |'?skip='| '5'  |'&types='| 'LC' | 200  |
    |'?skip='| '1'  |'&types='| 'LC' | 200  |
    |'?skip='| '0'  |'&types='| 'LC' | 400  |
    |'?skip='| '999'  |'&types='| 'LC' | 200  |
    |'?skip='| '1000'  |'&types='| 'LC' | 400  |
    |'?skip='| 'A'  |'&types='| 'LC' | 400  |


Scenario Outline: DT034
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>)
    * def query = { top: <value1> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | statuscode   |
    |'?top='| '5'  | 400  |

Scenario Outline: DT035, DT036, DT037, DT038, DT039, DT040
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>)
    * def query = { top: <value1>, types: <value2> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | statuscode   |
    |'?top='| '5'  |'&types='| 'LC' | 200  |
    |'?top='| '1'  |'&types='| 'LC' | 200  |
    |'?top='| '0'  |'&types='| 'LC' | 400  |
    |'?top='| '100'  |'&types='| 'LC' | 200  |
    |'?top='| '101'  |'&types='| 'LC' | 400  |
    |'?top='| 'A'  |'&types='| 'LC' | 400  |


Scenario Outline: DT041
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>)
    * def query = { groups: <value1> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | statuscode   |
    |'?groups='| 'addresses'  | 400  |

Scenario Outline: DT042, DT043, DT044
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken('entities', <parameter1>+<value1>+<parameter2>+<value2>)
    * def query = { groups: <value1>, uens: <value2> }

    Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | parameter1 | value1   | parameter2 | value2   | statuscode   |
    |'?groups='| 'addresses'  |'&uens='| '198102460H' | 200  |
    |'?groups='| 'addresses,uens'  |'&uens='| '198102460H' | 200  |
    |'?groups='| 'invalid'  |'&uens='| '198102460H' | 400  |

#for use with methodcall and path with no query
Scenario Outline: DT045, DT046, DT047, DT048, DT051, DT052, DT053, DT062, DT063, DT064
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken(<methodcall>+<path1>, <pstart>+<parameter1>+<value1>)
    #* def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken(<methodcall>+'/'+<path1>, <pstart>+<parameter1>+<value1>)
    #* def query = { groups: <value1> }

    #Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entity/'+<value1>
    #Given path <methodcall>+'/'+<path1>
    Given path <methodcall>+<path1>
    And header Authorization = token
    And header Accept = 'application/json'
    When method get
    Then status <statuscode>

    Examples:
    | methodcall | path1 | pstart | parameter1 | value1   | statuscode   |
    | 'entity' | '/T18CC0362G' | '' |''| ''  | 200  |
    | 'entity' | '/T18CC0366B' | '' |''| ''  | 200  |
    | 'entity' | '/T18CC0366B' | '' |''| ''  | 200  |
    | 'entity' | '/T18CC0368E' | '' |''| ''  | 200  |
    | 'entity' | '/T18CC0370J' | '' |''| ''  | 200  |
    | 'entity' | '/T18CC0371E' | '' |''| ''  | 200  |
    | 'entity' | '/198102460H' | '' |''| ''  | 200  |
    | 'entity' | '/123456789' | '' |''| ''  | 404  |
    | 'entity' | '/12345678900' | '' |''| ''  | 400  |
    | 'entity' | '/201600159C/appointments' | '' |''| ''  | 200  |
    | 'entity' | '/123456789/appointments' | '' |''| ''  | 404  |
    | 'entity' | '/12345678900/appointments' | '' |''| ''  | 400  |

#for use with methodcall and query
Scenario Outline: DT045a, DT046a, DT047a, DT048a
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken(<methodcall>, <parameter1>+<value1>)
    * def query = { <p1>: <value1> }

    #Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entities'
    Given path <methodcall>
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | methodcall | p1   | parameter1 | value1     | statuscode   |
    | 'entities' | uens | '?uens=' | 'T18CC0362G' | 200  |
    | 'entities' | uens | '?uens=' | 'T18CC0366B' | 200  |
    | 'entities' | uens | '?uens=' | 'T18CC0366B' | 200  |
    | 'entities' | uens | '?uens=' | 'T18CC0368E' | 200  |
    | 'entities' | uens | '?uens=' | 'T18CC0370J' | 200  |
    | 'entities' | uens | '?uens=' | 'T18CC0371E' | 200  |

#for use with methodcall, path and query
Scenario Outline: DT054, DT055, DT056, DT057, DT058, DT059, DT060, DT061, DT065, DT066, DT067, DT068, DT069, DT070, DT071, DT072, DT073, DT074, DT075, DT076, DT077, DT078, DT079, DT080, DT081, DT082
    * def token = Java.type('sg.gov.hpb.aurora.util.GetEntity').getSignatureToken(<methodcall>+'/'+<path1>, <pstart>+<parameter1>+<value1>)
    * def query = { <p1>: <value1> }

    #Given url 'https://edh.api.gov.sg/test/l2-eg/v1/entity/'+<value1>
    Given path <methodcall>+'/'+<path1>
    And header Authorization = token
    And header Accept = 'application/json'
    And params query
    When method get
    Then status <statuscode>

    Examples:
    | methodcall | path1        | p1         | pstart | parameter1   | value1    | statuscode   |
    | 'entity'   | 'T18CC0114C' | consumerId | '?'    | 'consumerId=' | 'ECRM-CP' | 200          |
    | 'entity'   | 'T18CC0114C' | consumerId | '?'    | 'consumerId=' | 'invalid' | 400          |
    | 'entity'   | '198102460H' | fields     | '?'    | 'fields='     | 'uen'     | 200          |
    | 'entity'   | '198102460H' | fields     | '?'    | 'fields='     | 'uen,uenStatus'     | 200          |
    | 'entity'   | '198102460H' | fields     | '?'    | 'fields='     | 'invalid'     | 400          |
    | 'entity'   | '198102460H' | groups     | '?'    | 'groups='     | 'addresses'     | 200          |
    | 'entity'   | '198102460H' | groups     | '?'    | 'groups='     | 'addresses,uens'     | 200          |
    | 'entity'   | '198102460H' | groups     | '?'    | 'groups='     | 'invalid'     | 400          |
    | 'entity'   | '201600159C/appointments' | fields     | '?'    | 'fields='     | 'category'     | 200          |
    | 'entity'   | '201600159C/appointments' | fields     | '?'    | 'fields='     | 'category,positionHeld'     | 200          |
    | 'entity'   | '201600159C/appointments' | fields     | '?'    | 'fields='     | 'invalid'     | 400          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | '5'     | 200          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | '1'     | 200          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | '0'     | 400          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | '999'     | 200          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | '1000'     | 400          |
    | 'entity'   | '201600159C/appointments' | skip     | '?'    | 'skip='     | 'A'     | 400          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | '5'     | 200          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | '1'     | 200          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | '0'     | 400          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | '100'     | 200          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | '101'     | 400          |
    | 'entity'   | '201600159C/appointments' | top     | '?'    | 'top='     | 'A'     | 400          |
    | 'entity'   | '201600159C/appointments' | types     | '?'    | 'types='     | 'CO'     | 200          |
    | 'entity'   | '201600159C/appointments' | types     | '?'    | 'types='     | 'CO,BO'     | 200          |
    | 'entity'   | '201600159C/appointments' | types     | '?'    | 'types='     | 'A'     | 400          |

#example
#Given url 'https://api.cloud.xyz.com/oauth2/token'
#And param client_id = karate.properties['client.id']
#And param client_secret = karate.properties['client.secret']
#And param grant_type = 'client_credentials'
#mvn test -DargLine="-Dclient.id=**** -Dclient.secret=**** -Dkarate.env=qa"


