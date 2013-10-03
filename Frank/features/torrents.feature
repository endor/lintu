Feature: Torrents list

  Scenario: See torrents in torrent list
    Given I have a torrent "ubuntu-12.10-desktop-i386.iso"
      And I launch the app
    Then I should see "ubuntu-12.10-desktop-i386.iso" in the torrents list
