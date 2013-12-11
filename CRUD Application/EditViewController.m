//
//  EditViewController.m
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/11/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize personDAO;
@synthesize personID;

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
    // Do any additional setup after loading the view from its nib.
    personDAO = [[PersonDAO alloc] init];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    if(self.personID > 0) {
        Person *person = [[Person alloc] init];
        person = [personDAO getPerson:personID];
        [txtName setText:@"j"];
        [txtLastName setText:person.lastName];
        [txtTelephone setText:person.telephone];
    } else {
        [txtName setText:@""];
        [txtLastName setText:@""];
        [txtTelephone setText:@""];
    }
}

- (IBAction)personList:(id)sender {
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
