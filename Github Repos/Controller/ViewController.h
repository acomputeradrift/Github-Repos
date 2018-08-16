//
//  ViewController.h
//  Github Repos
//
//  Created by Jamie on 2018-08-16.
//  Copyright © 2018 Jamie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repo.h"
#import "RepoTAbleViewCell.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <Repo *> *myRepo;


@end

