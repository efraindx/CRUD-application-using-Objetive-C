//
//  Person.h
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/10/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSInteger *personID;
    NSString *firstName;
    NSString *lastName;
    NSString *telephone;
}

@property(nonatomic, assign) NSInteger *personID;
@property(nonatomic, retain) NSString *firstName;
@property(nonatomic, retain) NSString *lastName;
@property(nonatomic, retain) NSString *telephone;

@end
