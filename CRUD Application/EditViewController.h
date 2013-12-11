//
//  EditViewController.h
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/11/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDAO.h"

@interface EditViewController : UIViewController {
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtTelephone;
}

@property(nonatomic) NSInteger personID;
@property(strong, nonatomic) PersonDAO *personDAO;

@property(strong, nonatomic) NSMutableArray *personList;

- (IBAction)personList:(id)sender;

@end
