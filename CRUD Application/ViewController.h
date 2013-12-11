//
//  ViewController.h
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/10/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDAO.h"
#import "EditViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *table;
    EditViewController *editViewController;
}

-(IBAction)addPerson:(id)sender;

@property(nonatomic, strong) PersonDAO *personDAO;
@property(strong, nonatomic) NSMutableArray *people;
@end
