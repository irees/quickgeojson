quickgeojson
============

QuickLook for GeoJSON and TopoJSON

![quickgeojson screenshot](screenshot1.png?raw=true)

This is a simple QuickLook plugin to browse GeoJSON and TopoJSON files.

### Homebrew

This QuickLook Plugin can now be installed using [Homebrew Cask](https://github.com/caskroom/homebrew-cask):

> homebrew cask install quickgeojson

### Installation Instructions

* Build the project in XCode by going to Product -> Archive. 
* Then click the "Distribute" button, and save to a folder.
* Copy the resulting file (quickgeojson.qlgenerator) to your home folder as `~/Library/QuickLook/quickgeojson.qlgenerator`. (You may need to create the QuickLook folder if it doesn't yet exist.
* Finder may pick it up automatically, but if it doesn't, you can run `qlmanage -r` to reload the plugins.

### simplestyle-spec support
The plugin also supports [simplestyle-spec](https://github.com/mapbox/simplestyle-spec) for coloring/styling the polygons. 

![styled screenshot](screenshot2.png?raw=true)

