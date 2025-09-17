*** Settings ***
Documentation    Cas de test BDD
...
...              cas de test BDD exemple
Metadata         ID                           3
Metadata         Reference                    cas_de_test_BDD_1
Metadata         Automation priority          1
Metadata         Test case importance         Low
Resource         squash_resources.resource
Library          squash_tf.TFParamService
Test Setup       Test Setup
Test Teardown    Test Teardown


*** Test Cases ***
Cas de test BDD
    [Documentation]    Cas de test BDD

    &{dataset} =    Retrieve Dataset

    Given Je suis sur "${dataset}[url]" souhaitée
    When je saisi mon "${dataset}[user]"
    And saisi le "${dataset}[mdp]"
    And mon "${dataset}[user]" dans la liste "${dataset}[list_users]"
    Then j'arrive a ma page "${dataset}[url]"/profile


*** Keywords ***
Test Setup
    [Documentation]    test setup
    ...                You can define the ${TEST_SETUP} variable with a keyword for setting up all your tests.
    ...                You can define the ${TEST_3_SETUP} variable with a keyword for setting up this specific test.
    ...                If both are defined, ${TEST_3_SETUP} will be run after ${TEST_SETUP}.

    ${TEST_SETUP_VALUE} =      Get Variable Value    ${TEST_SETUP}
    ${TEST_3_SETUP_VALUE} =    Get Variable Value    ${TEST_3_SETUP}
    IF    $TEST_SETUP_VALUE is not None
        Run Keyword    ${TEST_SETUP}
    END
    IF    $TEST_3_SETUP_VALUE is not None
        Run Keyword    ${TEST_3_SETUP}
    END

Test Teardown
    [Documentation]    test teardown
    ...                You can define the ${TEST_TEARDOWN} variable with a keyword for tearing down all your tests.
    ...                You can define the ${TEST_3_TEARDOWN} variable with a keyword for tearing down this specific test.
    ...                If both are defined, ${TEST_TEARDOWN} will be run after ${TEST_3_TEARDOWN}.

    ${TEST_3_TEARDOWN_VALUE} =    Get Variable Value    ${TEST_3_TEARDOWN}
    ${TEST_TEARDOWN_VALUE} =      Get Variable Value    ${TEST_TEARDOWN}
    IF    $TEST_3_TEARDOWN_VALUE is not None
        Run Keyword    ${TEST_3_TEARDOWN}
    END
    IF    $TEST_TEARDOWN_VALUE is not None
        Run Keyword    ${TEST_TEARDOWN}
    END

Retrieve Dataset
    [Documentation]    Retrieves Squash TM's datasets and stores them in a dictionary.
    ...
    ...                For instance, datasets containing 3 parameters "city", "country" and "currency"
    ...                have been defined in Squash TM.
    ...
    ...                First, this keyword retrieves parameter values from Squash TM
    ...                and stores them into variables, using the keyword 'Get Test Param':
    ...                ${city} =    Get Test Param    DS_city
    ...
    ...                Then, this keyword stores the parameters into the &{dataset} dictionary
    ...                with each parameter name as key, and each parameter value as value:
    ...                &{dataset} =    Create Dictionary    city=${city}    country=${country}    currency=${currency}

    ${url} =           Get Test Param    DS_url
    ${user} =          Get Test Param    DS_user
    ${mdp} =           Get Test Param    DS_mdp
    ${list_users} =    Get Test Param    DS_list_users

    &{dataset} =    Create Dictionary    url=${url}    user=${user}    mdp=${mdp}    list_users=${list_users}

    RETURN    &{dataset}
