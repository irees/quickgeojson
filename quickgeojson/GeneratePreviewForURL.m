/* 
 
 GeoJSON QuickLook Plugin
 Ian Rees, 2014
 
 Based on MapBox TileMill QuickLook Plugin, created by Käfer Konstantin.
 https://github.com/mapbox/tilemill/tree/master/platforms/osx/MBTilesQuickLook
 
*/

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    
    NSMutableDictionary *props;
    NSMutableString *html;

    @autoreleasepool {

        // Load the data
        NSURL *nsurl = (__bridge NSURL *)url;
        NSData *data = [NSData dataWithContentsOfURL:nsurl];
        if (!data) return noErr;
        // Convert to NSString
        NSString *geojson = [NSString stringWithUTF8String:[data bytes]];
        // Test data...:
        // NSString *geojson = @"{\"type\": \"Feature\",\"properties\": {\"name\": \"Coors Field\",\"amenity\": \"Baseball Stadium\",\"popupContent\": \"A Stadium\"},\"geometry\": {\"type\": \"Point\",\"coordinates\": [-104.99404, 39.75621]}}";
        
        props = [[NSMutableDictionary alloc] init];
        [props setObject:@"UTF-8" forKey:(NSString *)kQLPreviewPropertyTextEncodingNameKey];
        [props setObject:@"text/html" forKey:(NSString *)kQLPreviewPropertyMIMETypeKey];
        
        
        // Get the template.html file.
        CFBundleRef bundle = QLPreviewRequestGetGeneratorBundle(preview);
        CFURLRef templateURL = CFBundleCopyResourceURL(bundle, (CFStringRef)@"template", (CFStringRef)@"html", NULL);
        if (!templateURL) return noErr;
        CFStringRef templatePath = CFURLCopyFileSystemPath(templateURL, kCFURLPOSIXPathStyle);
        if (!templatePath) return noErr;
        
        NSError *error;
        NSString *document = [[NSString alloc]
                              initWithContentsOfFile:(__bridge NSString*)templatePath
                              encoding:NSUTF8StringEncoding
                              error:&error];
        

        // Create the HTML Document...
        html = [[NSMutableString alloc] init];
        // Replace the template {{GEOJSON}} with the GeoJSON data.
        [html appendString:[document stringByReplacingOccurrencesOfString:@"{{GEOJSON}}" withString:geojson]];
        
        QLPreviewRequestSetDataRepresentation(preview,
                                              (__bridge CFDataRef)[html dataUsingEncoding:NSUTF8StringEncoding],
                                              kUTTypeHTML,
                                              (__bridge CFDictionaryRef)props);
        
        return noErr;

        
    }
}



void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview);

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}