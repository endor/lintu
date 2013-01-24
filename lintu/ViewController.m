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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"torrentCell"];
    Torrent *torrent = [self.torrents objectAtIndex:indexPath.row];
    cell.textLabel.text = torrent.name;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
