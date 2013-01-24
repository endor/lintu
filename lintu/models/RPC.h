//
//  RPC.h
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPC : NSObject

- (void)getTorrents:(void (^)(NSArray *))success;

@end
