//
//  RPC.m
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import "RPC.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "../Constants.h"

@interface RPC ()

@property(nonatomic, assign) NSString *sessionId;

@end


@implementation RPC

+ (RPC *)sharedInstance
{
    static RPC *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getTorrents:(void (^)(NSArray *))getTorrentsCallback
{
    NSDictionary *requestData = @{@"method": @"torrent-get", @"arguments": @{@"fields": [Torrent getFields]}};
    [self makeRequest:requestData success:^(NSDictionary *JSON) {
        NSArray *torrentData = JSON[@"arguments"][@"torrents"];
        NSMutableArray *torrents = [[NSMutableArray alloc] init];
        for(int i = 0; i < torrentData.count; i++) {
            Torrent *torrent = [[Torrent alloc] init: torrentData[i]];
            [torrents addObject:torrent];
        }
        getTorrentsCallback(torrents);
    }];
}

- (void)updateTorrent:(Torrent *)torrent method:(NSString *)method success:(void (^)(Torrent *torrent))updateTorrentCallback
{
    NSDictionary *requestData = @{@"method": method, @"arguments": @{@"ids": [NSNumber numberWithInteger:torrent.identifier]}};
    [self makeRequest:requestData success:^(NSDictionary *JSON) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self retrieveTorrent:torrent.identifier success:updateTorrentCallback];
        });
    }];

}

- (void)pauseTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))pauseTorrentCallback
{
    [self updateTorrent:torrent method:@"torrent-stop" success:pauseTorrentCallback];
}

- (void)resumeTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))resumeTorrentCallback
{
    [self updateTorrent:torrent method:@"torrent-start" success:resumeTorrentCallback];
}

- (void)verifyTorrent:(Torrent *)torrent success:(void (^)(Torrent *torrent))verifyTorrentCallback
{
    [self updateTorrent:torrent method:@"torrent-verify" success:verifyTorrentCallback];
}

- (void)reannounceTorrent:(Torrent *)torrent
{
    [self updateTorrent:torrent method:@"torrent-reannounce" success:(void (^)(Torrent *torrent))^{}];
}

- (void)retrieveTorrent:(NSInteger)identifier success:(void (^)(Torrent *torrent))retrieveTorrentCallback
{
    NSDictionary *requestData = @{@"method": @"torrent-get", @"arguments": @{@"fields": [Torrent getFields], @"ids": [NSNumber numberWithInteger:identifier]}};
    [self makeRequest:requestData success:^(NSDictionary *JSON) {
        NSArray *torrentData = JSON[@"arguments"][@"torrents"];
        Torrent *torrent = [[Torrent alloc] init: torrentData[0]];
        retrieveTorrentCallback(torrent);
    }];
}

- (void)makeRequest:(NSDictionary *)requestData success:(void (^)(NSDictionary *))makeRequestCallback
{
    NSURL *url = [NSURL URLWithString:BaseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"transmission/rpc"
                                                      parameters:requestData];
    [request setValue:self.sessionId forHTTPHeaderField:@"X-Transmission-Session-Id"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSON) {
        NSLog(@"%@", JSON);
        makeRequestCallback(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error , id JSON) {
        self.sessionId = [response allHeaderFields][@"X-Transmission-Session-Id"];
        [self makeRequest:requestData success: makeRequestCallback];
    }];
    [operation start];    
}

@end
