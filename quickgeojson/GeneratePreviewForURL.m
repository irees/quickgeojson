/* 
 
 GeoJSON QuickLook Plugin
 Ian Rees, 2014
 
 Based on MapBox TileMill QuickLook Plugin, created by Käfer Konstantin.
 https://github.com/mapbox/tilemill/tree/master/platforms/osx/MBTilesQuickLook
 
*/

static void attach(CFBundleRef* bundle, NSMutableDictionary* attachments, NSString* type, NSString* fileName)
{
    CFURLRef attachURL = CFBundleCopyResourceURL(*bundle, (__bridge CFStringRef)(fileName), NULL, NULL);
    NSData *data = [NSData dataWithContentsOfURL:(__bridge NSURL *)attachURL];
    NSDictionary* attachment = [NSMutableDictionary dictionaryWithObjectsAndKeys:type, (NSString *)kQLPreviewPropertyMIMETypeKey, data, (NSString *)kQLPreviewPropertyAttachmentDataKey, nil];
    [attachments setObject:attachment forKey:fileName];
}

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    
    NSMutableString *html;
    
    @autoreleasepool {

        // Load the data
        NSURL *nsurl = (__bridge NSURL *)url;
        
        /*
         was having difficulty with loading the data via dataWithContentsOfURL and then into a string with
         stringWithUTF8String. I was seeing incomplete data loaded occasionally, so instead I'm trying
         stringWithContentsOfURL and that seems to consistently load all data as needed
        */
        NSString *geojson = [NSString stringWithContentsOfURL:nsurl encoding:NSUTF8StringEncoding error:nil];
        
        
        // Bundle reference.
        CFBundleRef bundle = QLPreviewRequestGetGeneratorBundle(preview);

        // Get the template.html file.
        CFURLRef templateURL = CFBundleCopyResourceURL(bundle, (CFStringRef)@"template", (CFStringRef)@"html", NULL);
        if (!templateURL) return noErr;
        CFStringRef templatePath = CFURLCopyFileSystemPath(templateURL, kCFURLPOSIXPathStyle);
        if (!templatePath) return noErr;
        NSError *error;
        NSString *document = [[NSString alloc]
                              initWithContentsOfFile:(__bridge NSString*)templatePath
                              encoding:NSUTF8StringEncoding
                              error:&error];

        // Properties
        NSMutableDictionary* properties = [NSMutableDictionary dictionary];
        [properties setObject:@"UTF-8" forKey:(NSString*)kQLPreviewPropertyTextEncodingNameKey];
        [properties setObject:@"text/html" forKey:(NSString*)kQLPreviewPropertyMIMETypeKey];
        
        // Add the attachments.
        NSMutableDictionary* attachments = [NSMutableDictionary dictionary];
        attach(&bundle, attachments, @"text/css", @"mapbox.v2.1.4.css");
        attach(&bundle, attachments, @"text/javascript", @"mapbox.v2.1.4.js");
        attach(&bundle, attachments, @"image/png", @"icons-000000@2x.png");
        attach(&bundle, attachments, @"text/javascript", @"leaflet-omnivore.min.js");
        [properties setObject:attachments forKey:(NSString*)kQLPreviewPropertyAttachmentsKey];
        
        // Create the HTML Document...
        html = [[NSMutableString alloc] init];
        // Replace the template {{GEOJSON}} with the GeoJSON data.
        [html appendString:[document stringByReplacingOccurrencesOfString:@"{{GEOJSON}}" withString:geojson]];
        
        QLPreviewRequestSetDataRepresentation(preview,
                                              (__bridge CFDataRef)[html dataUsingEncoding:NSUTF8StringEncoding],
                                              kUTTypeHTML,
                                              (__bridge CFDictionaryRef)properties);
        
        return noErr;
    }
}



void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview);

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}