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
@property(nonatomic, assign) NSString *sessionId;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    RPC *rpc = [[RPC alloc] init];
    [rpc getTorrents:^(NSArray *torrents) {
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
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    DetailViewController* detail = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];

//	[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"detailController"] animated:YES];
        //[detail.name setText: [self.torrents objectAtIndex:indexPath.row]];
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

@end
