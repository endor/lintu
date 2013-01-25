//
//  Torrent.m
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import "Torrent.h"

@interface Torrent ()

@property(nonatomic) NSString *status;
@property(nonatomic) NSString *eta;
@property(atomic) NSInteger totalSize;
@property(atomic) NSInteger sizeWhenDone;
@property(atomic) NSInteger leftUntilDone;
@property(atomic) NSInteger uploadedEver;
@property(atomic) NSInteger rateDownload;
@property(atomic) NSInteger rateUpload;
@property(atomic) NSInteger downloadedEver;

@end

@implementation Torrent

- (id)init:(NSDictionary *)dict
{
    if ([super init]) {
        self.identifier = (int)dict[@"id"];
        self.name = dict[@"name"];
        self.eta = dict[@"eta"];
        self.status = dict[@"status"];
        self.totalSize = [[dict objectForKey:@"totalSize"] integerValue];
        self.sizeWhenDone = [[dict objectForKey:@"sizeWhenDone"] integerValue];
        self.leftUntilDone = [[dict objectForKey:@"leftUntilDone"] integerValue];
        self.uploadedEver = [[dict objectForKey:@"uploadedEver"] integerValue];
        self.downloadedEver = [[dict objectForKey:@"downloadedEver"] integerValue];
        self.rateUpload = [[dict objectForKey:@"rateUpload"] integerValue];
        self.rateDownload = [[dict objectForKey:@"rateDownload"] integerValue];
    }
    
    return self;
}

+ (NSArray *)getFields
{
    return @[@"id", @"name", @"status", @"totalSize", @"sizeWhenDone", @"leftUntilDone", @"eta", @"uploadedEver", @"rateDownload", @"rateUpload", @"downloadedEver"];
}

- (NSString *)getProgressDetails
{
    return [NSString stringWithFormat:@"UL: %.02f KB/s\nDL: %.02f KB/s", ((float)[self rateUpload] / 1000), ((float)[self rateDownload] / 1000)];
}

- (float)getProgress
{
    if([self sizeWhenDone] == 0.0)
    {
        return 0.0;
    }
    
    NSInteger notDoneYet = [self sizeWhenDone] - [self leftUntilDone];
    return (float)notDoneYet / (float)[self sizeWhenDone];
}

@end
