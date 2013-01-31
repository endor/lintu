//
//  DetailViewController.m
//  lintu
//
//  Created by Matthias Dittgen on 25.01.13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import "DetailViewController.h"
#import "RPC.h"

@interface DetailViewController ()

@property(nonatomic, weak) IBOutlet UILabel* label;
@property(nonatomic) IBOutlet UIToolbar *toolbar;
@property(nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property(nonatomic) RPC *rpc;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.label setText: self.torrent.name];
    self.rpc = [RPC sharedInstance];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateButtons];
}

- (void)updateButtons
{
    if([[self torrent] isActive])
    {
        [self pauseButton].title = @"Pause";
    } else {
        [self pauseButton].title = @"Resume";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pauseOrResumeGame
{
    void (^callback)(Torrent *) = ^(Torrent *torrent) {
        self.torrent = torrent;
        [self updateButtons];
    };
    
    if([[self torrent] isActive])
    {
        [self.rpc pauseTorrent:[self torrent] success:callback];
    } else {
        [self.rpc resumeTorrent:[self torrent] success:callback];
    }
}

@end
