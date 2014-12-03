//
//  ViewController.m
//  GetFit
//
//  Created by Albert Carter on 12/3/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "ViewController.h"
#import "datahub.h"
#import <THTTPClient.h>
#import <TBinaryProtocol.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)dbConnect:(id)sender {
    NSLog(@"dbconnect called");
    
    NSURL *url = [NSURL URLWithString:@"http://datahub.csail.mit.edu/service"];
    
    // Talk to a server via HTTP, using a binary protocol
    THTTPClient *transport = [[THTTPClient alloc] initWithURL:url];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc]
                                 initWithTransport:transport
                                 strictRead:YES
                                 strictWrite:YES];

    DataHubClient *server = [[DataHubClient alloc] initWithProtocol:protocol];

    ConnectionParams *conparams = [[ConnectionParams alloc] initWithClient_id:@"foo" seq_id:nil user:@"anantb" password:@"anant" repo_base:nil];
    
    Connection *connection = [server open_connection:conparams];

    ResultSet *results =  [server execute_sql:connection query:@"select * from test.demo" query_params:nil];
    
    NSLog(@"%@", results);
}



@end
