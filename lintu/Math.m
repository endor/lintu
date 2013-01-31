//
//  Math.m
//  lintu
//
//  Created by Frank Prößdorf on 1/31/13.
//  Copyright (c) 2013 Frank Pr√∂√üdorf. All rights reserved.
//

#import "Math.h"

@implementation Math

+ (NSString *)formatBytes:(NSInteger)bytes
{
    float size;
    NSString *unit;
    
    // Terabytes (TB).
    if ( bytes >= 1099511627776 ) {
        size = bytes / 1099511627776;
        unit = @"TB";
    }
    
    // Gigabytes (GB).
    else if ( bytes >= 1073741824 ) {
        size = bytes / 1073741824;
        unit = @"GB";
    }
    
    // Megabytes (MB).
    else if ( bytes >= 1048576 ) {
        size = bytes / 1048576;
        unit = @"MB";
    }
    
    // Kilobytes (KB).
    else if ( bytes >= 1024 ) {
        size = bytes / 1024;
        unit = @"KB";
    }
    
    // The file is less than one KB
    else {
        size = bytes;
        unit = @"bytes";
    }

    return [NSString stringWithFormat:@"%.02f %@", size, unit];
}

@end
