@javascript
Feature: Provider stats
  In order to know the usage of my service
  As an admin of provider account
  I want to see the stats

  # TODO: Find a way to test the charts

  Background:
    Given a provider "foo.example.com"
    And provider "foo.example.com" has multiple applications enabled
    And current domain is the admin domain of provider "foo.example.com"
    And all the rolling updates features are off
    And All Dashboard widgets are loaded

  Scenario: Stats access
    When I log in as provider "foo.example.com"
    And I follow "Analytics"
    Then I should be on the provider stats usage page

  Scenario: Usage stats
    When I log in as provider "foo.example.com"
    And I follow "Analytics"
    Then I should see "Traffic"

  Scenario: Top applications (multiple applications mode)
    Given a buyer "bob" signed up to provider "foo.example.com"
    When I log in as provider "foo.example.com"
    And I follow "Analytics"
    And I go to the provider stats apps page
    Then I should see "Top Applications" in a header
    And I should see a chart called "chart"

  Scenario: Top users (single application mode)
    Given provider "foo.example.com" has multiple applications disabled
    And an application plan "Default" of provider "foo.example.com"
    And a buyer "bob" signed up to application plan "Default"

    When I log in as provider "foo.example.com"
    And I follow "Analytics"
    And I follow "Top Applications"
    Then I should see "Top Applications" in a header
