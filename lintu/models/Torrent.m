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
@property(atomic) float totalSize;
@property(atomic) float sizeWhenDone;
@property(atomic) float leftUntilDone;
@property(atomic) float uploadedEver;
@property(atomic) float rateDownload;
@property(atomic) float rateUpload;
@property(atomic) float downloadedEver;

@end

@implementation Torrent

- (id)init:(NSDictionary *)dict
{
    if ([super init]) {
        self.identifier = (int)dict[@"id"];
        self.name = dict[@"name"];
        self.eta = dict[@"eta"];
        self.status = dict[@"status"];
        self.totalSize = (float)(int)dict[@"totalSize"];
        self.sizeWhenDone = (float)(int)dict[@"sizeWhenDone"];
        self.leftUntilDone = (float)(int)dict[@"leftUntilDone"];
        self.uploadedEver = (float)(int)dict[@"uploadedEver"];
        self.downloadedEver = (float)(int)dict[@"downloadedEver"];
        self.rateUpload = (float)(int)dict[@"rateUpload"];
        self.rateDownload = (float)(int)dict[@"rateDownload"];
    }
    
    return self;
}

+ (NSArray *)getFields
{
    return @[@"id", @"name", @"status", @"totalSize", @"sizeWhenDone", @"leftUntilDone", @"eta", @"uploadedEver", @"rateDownload", @"rateUpload", @"downloadedEver"];
}

- (NSString *)getProgressDetails
{
    return @"UL:, DL: ";
}

- (float)getProgress
{
    if([self sizeWhenDone] == 0)
    {
        return 0.0;
    }
    
    float notDoneYet = [self sizeWhenDone] - [self leftUntilDone];
    return ((notDoneYet / [self sizeWhenDone]) * 10000) / 100;
}

@end
