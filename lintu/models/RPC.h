//
//  RPC.h
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Torrent.h"

@interface RPC : NSObject

- (void)getTorrents:(void (^)(NSArray *))success;
- (void)pauseTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))success;
- (void)resumeTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))success;
- (void)verifyTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))success;
- (void)reannounceTorrent:(Torrent *)torrent;
- (void)retrieveTorrent:(NSInteger)identifier success:(void (^)(Torrent *torrent))retrieveTorrentCallback;

+ (RPC *)sharedInstance;

@end
