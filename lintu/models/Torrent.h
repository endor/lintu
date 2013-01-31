//
//  Torrent.h
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torrent : NSObject

@property(nonatomic) NSInteger identifier;
@property(nonatomic) NSString *name;

- (NSString *)getProgressDetails;
- (float)getProgress;
- (UIColor *)statusColor;
- (id)init:(NSDictionary *)dict;
- (Boolean)isActive;

+ (NSArray *)getFields;

@end
