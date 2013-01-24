//
//  Torrent.h
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torrent : NSObject

@property(nonatomic) int identifier;
@property(nonatomic, retain) NSString *name;

- (id)init:(NSDictionary *)dict;

@end
