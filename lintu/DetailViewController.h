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

- (IBAction)pauseOrResumeGame;
- (IBAction)verify;
- (IBAction)askForMorePeers;

@end
