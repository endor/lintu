Feature: Torrents list

  Scenario: See torrents in torrent list
    Given I launch the app
    Then I should see "ubuntu-12.10-desktop-i386.iso" in the torrent list