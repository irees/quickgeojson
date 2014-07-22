quickgeojson
============

QuickLook for GeoJSON

This is a simple QuickLook plugin to browse GeoJSON files.  It matches files with the ".geojson" extension.

It's a simple web-based preview using Leaflet.js. Probably many errors and mistakes since this is my first Obj-C project. It's mostly based on TileMill's QuickLook plugin for MBTiles.

### Installation Instructions

* Build the project in XCode by going to Product -> Archive. 
* Then click the "Distribute" button, and save to a folder.
* Copy the resulting file (quickgeojson.qlgenerator) to your home folder as `~/Library/QuickLook/quickgeojson.qlgenerator`. (You may need to create the QuickLook folder if it doesn't yet exist.
* Finder may pick it up automatically, but if it doesn't, you can run `qlmanage -r` to reload the plugins.
