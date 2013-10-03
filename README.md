# Lintu

This is an experimental IPhone Client for the Transmission BitTorrent Client. It is experimental because it is the first bigger Objective-C project for the developers involved.


## Tests

### Integration Tests

For now we need to do the following to run the integration tests:

    $ frank build -target \"lintu frankified\"
    $ cucumber Frank/features/*

After the tests are done, we need to close the simulator manually.


## TODO

* Write rake task to run integration tests
* Add integration test for showing failed torrents
* Add unit tests
* Fix alignment etc. warnings due to iOS 7
* Move the frankified plist file somewhere else
