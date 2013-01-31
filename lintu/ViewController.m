//
//  ViewController.m
//  lintu
//
//  Created by Frank Prößdorf on 1/24/13.
//  Copyright (c) 2013 Frank Prößdorf. All rights reserved.
//

#import "ViewController.h"
#import "RPC.h"
#import "Torrent.h"
#import "AFJSONRequestOperation.h"
#import "TorrentCell.h"
#import "DetailViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) NSArray *torrents;
@property(nonatomic, retain) IBOutlet UITableView *torrentTableView;
@property(nonatomic) NSString *sessionId;
@property(nonatomic) RPC *rpc;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rpc = [RPC sharedInstance];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(getTorrents) userInfo:nil repeats:YES];
}

- (void)getTorrents
{
    [self.rpc getTorrents:^(NSArray *torrents) {
        self.torrents = torrents;
        [self.torrentTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.torrents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    TorrentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"torrentCell"];
    Torrent *torrent = [self.torrents objectAtIndex:indexPath.row];
    cell.name.text = torrent.name;
    cell.progressDetails.text = [torrent getProgressDetails];
    cell.progressBar.progress = [torrent getProgress];
    cell.progressBar.progressTintColor = [torrent statusColor];
    return cell;
}

#pragma  mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        NSInteger row = [self.torrentTableView indexPathForCell:sender].row;

        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]])
        {
                Torrent* torrent = self.torrents[row];
                DetailViewController* dv = (DetailViewController*)segue.destinationViewController;
                dv.torrent = torrent;
        }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
    }
}
@end
