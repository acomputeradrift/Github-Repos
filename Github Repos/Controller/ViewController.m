//
//  ViewController.m
//  Github Repos
//
//  Created by Jamie on 2018-08-16.
//  Copyright © 2018 Jamie. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *UITableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myRepo = [[NSMutableArray alloc] init];
    [self getDataFromUrlAndParse];
}

- (void) getDataFromUrlAndParse{
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/acomputeradrift/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        //self.repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];// 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *repo in repos){ // 4
            
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            //create repo object
            Repo *repo = [[Repo alloc] init];
            repo.name = repoName;
            [self.myRepo addObject:repo];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.UITableView reloadData];
        }];
    }];
    [dataTask resume]; // 6
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    NSInteger row = indexPath.row;
    Repo *repo = self.myRepo[row];
    
    cell.nameLabel.text = repo.name;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myRepo.count;
}
@end
