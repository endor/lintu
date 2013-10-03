Feature: Torrent details

  Scenario: See torrent details
    Given I have a torrent "ubuntu-12.10-desktop-i386.iso"
      And I launch the app
    Then I should see "ubuntu-12.10-desktop-i386.iso" in the torrents list
    When I touch "ubuntu-12.10-desktop-i386.iso"
    Then I should see "Uploaded"
      And I should see "Downloaded"
      And I should see "ubuntu-12.10-desktop-i386.iso"