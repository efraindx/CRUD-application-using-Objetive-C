//
//  ViewController.m
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/10/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonDAO.h"
#import "EditViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize personDAO;
@synthesize people;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.personDAO = [[PersonDAO alloc] init];
    [personDAO initDatabase];
    self.people = [personDAO getPeople];
    editViewController = [[EditViewController alloc] init];
}

-(IBAction)addPerson:(id)sender {
    [self.view addSubview:editViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.people count];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.people = [personDAO getPeople];
    [table reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *tableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:tableIdentifier];
    }
    
    Person *person = [[Person alloc] init];
    person = [self.people objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", person.firstName, person.lastName];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self editPerson:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self editPerson:indexPath];
}

- (void) editPerson:(NSIndexPath *) indexPath {
    
    Person *person = [[Person alloc] init];
    person = [people objectAtIndex:indexPath.row];
    [editViewController setPersonID:person.personID];
    [self.view addSubview:editViewController.view];
}

@end
