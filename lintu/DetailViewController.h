//
//  DetailViewController.h
//  lintu
//
//  Created by Matthias Dittgen on 25.01.13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Torrent.h"

@interface DetailViewController : UIViewController

@property(nonatomic, strong) Torrent* torrent;
@property(nonatomic, strong) IBOutlet UIProgressView *progressBar;
@property(nonatomic, strong) IBOutlet UILabel *speedDetails;
@property(nonatomic, strong) IBOutlet UILabel *progressDetails;
@property(nonatomic, strong) IBOutlet UILabel *status;
@property(nonatomic, strong) IBOutlet UISegmentedControl *tabs;
@property(nonatomic, strong) IBOutlet UIView *info;
@property(nonatomic, strong) IBOutlet UIView *peers;
@property(nonatomic, strong) IBOutlet UIView *trackers;
@property(nonatomic, strong) IBOutlet UIView *files;

- (IBAction)pauseOrResumeGame;
- (IBAction)verify;
- (IBAction)askForMorePeers;
- (IBAction)segmentSwitch;

@end
