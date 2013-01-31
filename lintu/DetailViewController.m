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
@property(nonatomic) IBOutlet UIBarButtonItem *verifyButton;
@property(nonatomic) IBOutlet UIBarButtonItem *askForMorePeersButton;
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
    
    UIFont *font = [UIFont boldSystemFontOfSize:14.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [[self tabs] setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
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

    [self status].text = @"";

    if([[self torrent] isVerifying])
    {
        [self status].text = [[self torrent] getVerifyingDetails];
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

- (IBAction)verify
{
    [self.rpc verifyTorrent:[self torrent] success:^(Torrent *torrent) {
        self.torrent = torrent;
        [self updateViewElements];
    }];
}

- (IBAction)askForMorePeers
{
    [self.rpc reannounceTorrent:[self torrent]];
}

- (IBAction)segmentSwitch
{
    NSInteger selectedSegment = [self tabs].selectedSegmentIndex;

    [self info].hidden = YES;
    [self peers].hidden = YES;
    [self trackers].hidden = YES;
    [self files].hidden = YES;

    NSArray *tabs = @[[self info], [self peers], [self trackers], [self files]];
    ((UIView *)tabs[selectedSegment]).hidden = NO;

    if(selectedSegment == 0)
    {
        [self enableButtons];
    } else {
        [self disableButtons];
    }
}

- (void) enableButtons
{
    [[self verifyButton] setEnabled:YES];
    [[self pauseButton] setEnabled:YES];
    [[self askForMorePeersButton] setEnabled:YES];
}

- (void) disableButtons
{
    [[self verifyButton] setEnabled:NO];
    [[self pauseButton] setEnabled:NO];
    [[self askForMorePeersButton] setEnabled:NO];
}

@end
