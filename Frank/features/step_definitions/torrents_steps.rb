Then /^I should see "(.*?)" in the torrent list$/ do |torrent_name|
  wait_for_element_to_exist "view view:'UILabel' marked:'#{torrent_name}'"
  check_element_exists "view view:'UILabel' marked:'#{torrent_name}'"
end