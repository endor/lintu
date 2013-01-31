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

@property(nonatomic) IBOutlet UIToolbar *toolbar;
@property(nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property(nonatomic) RPC *rpc;
@property(nonatomic) NSTimer *timer;

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
    self.rpc = [RPC sharedInstance];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateViewElements];
    self.navigationItem.title = [[self torrent] name];
    
    if(!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(updateTorrent) userInfo:nil repeats:YES];
    }
}

- (void)updateTorrent
{
    [self.rpc retrieveTorrent:[self torrent].identifier success:^(Torrent *torrent) {
        self.torrent = torrent;
        [self updateViewElements];
    }];
}

- (void)updateViewElements
{
    if([[self torrent] isActive])
    {
        [self pauseButton].title = @"Pause";
    } else {
        [self pauseButton].title = @"Resume";
    }
    
    [self speedDetails].text = [[self torrent] getSpeedDetails];
    [self progressDetails].text = [[self torrent] getProgressDetails];
    [self progressBar].progress = [[self torrent] getProgress];
    [self progressBar].progressTintColor = [[self torrent] statusColor];
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
        [self updateViewElements];
    };
    
    if([[self torrent] isActive])
    {
        [self.rpc pauseTorrent:[self torrent] success:callback];
    } else {
        [self.rpc resumeTorrent:[self torrent] success:callback];
    }
}

@end
