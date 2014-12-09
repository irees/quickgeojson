quickgeojson
============

QuickLook for GeoJSON

![quickgeojson screenshot](https://raw.githubusercontent.com/irees/quickgeojson/master/screenshot.png)

This is a simple QuickLook plugin to browse GeoJSON files.  It matches files with the ".geojson" extension.

### Homebrew

This QuickLook Plugin can now be installed using [Homebrew Cask](https://github.com/caskroom/homebrew-cask):

> homebrew cask install quickgeojson

### Installation Instructions

* Build the project in XCode by going to Product -> Archive. 
* Then click the "Distribute" button, and save to a folder.
* Copy the resulting file (quickgeojson.qlgenerator) to your home folder as `~/Library/QuickLook/quickgeojson.qlgenerator`. (You may need to create the QuickLook folder if it doesn't yet exist.
* Finder may pick it up automatically, but if it doesn't, you can run `qlmanage -r` to reload the plugins.
