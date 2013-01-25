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

@end
