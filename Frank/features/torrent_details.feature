Feature: Torrent details

  Scenario: See torrent details
    Given I launch the app
    When I touch "ubuntu-12.10-desktop-i386.iso"
    Then I should see "Uploaded"
      And I should see "Downloaded"
      And I should see "ubuntu-12.10-desktop-i386.iso"