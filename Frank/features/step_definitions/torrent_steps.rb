def fixtures_path
  File.dirname(__FILE__) + '/../fixtures'
end

Then /^I should see "([^\"]+)" in the torrents list$/ do |torrent_name|
  wait_until(:timeout => 30, :message => "waited to see torrent '#{torrent_name}' in list") {
    element_exists("view:'UILabel' marked:'#{torrent_name}'")
  }
end

Given /^I have a torrent "([^\"]+)"$/ do |torrent_name|
  torrents = {"arguments" => {
    "torrents" => [
      {
        "id"=>  1,
        "name"=> torrent_name,
        "status"=> 4,
        "totalSize"=> 100,
        "sizeWhenDone"=> 100,
        "leftUntilDone"=> 50,
        "eta"=> 0,
        "uploadedEver"=> 0,
        "uploadRatio"=> 0,
        "rateDownload"=> 0,
        "rateUpload"=> 0,
        "metadataPercentComplete"=> 1,
        "addedDate"=> 27762987,
        "downloadDir"=> "/downloads",
        "creator"=> "chaot",
        "hashString"=> "83ui72GYAYDg27ghg22e22e4235215",
        "comment"=> "",
        "isPrivate"=> true,
        "downloadedEver"=> 50,
        "haveValid"=> 20,
        "haveUnchecked"=> 10,
        "errorString"=> "",
        "peersGettingFromUs"=> 0,
        "peersSendingToUs"=> 0,
        "files"=> [],
        "fileStats"=> [],
        "pieceCount"=> 20,
        "pieceSize"=> 5,
        "trackerStats"=> [
          {
            "lastAnnounceTime"=> "12345678",
            "host"=> "my.tracker.com",
            "nextAnnounceTime"=> "12345678",
            "lastScrapeTime"=> "12345678",
            "seederCount"=> 0,
            "leecherCount"=> 0,
            "downloadCount"=> 1
          }
        ]
      }
    ]
  }}

  FileUtils.mkdir_p(fixtures_path)
  File.open("#{fixtures_path}/torrent-get.json", 'w') do |f|
    f << torrents.to_json
  end
end