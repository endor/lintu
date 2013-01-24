//
//  Torrent.m
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import "Torrent.h"

@implementation Torrent

- (id)init:(NSDictionary *)dict
{
    if ([super init]) {
        self.identifier = dict[@"id"];
        self.name = dict[@"name"];
    }
    
    return self;
}

@end
