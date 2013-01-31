//
//  TorrentCell.h
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TorrentCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIProgressView *progressBar;
@property(nonatomic, strong) IBOutlet UILabel *name;
@property(nonatomic, strong) IBOutlet UILabel *speedDetails;

@end
