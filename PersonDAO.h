//
//  PersonDAO.h
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/10/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Person.h"

@interface PersonDAO : NSObject {
    sqlite3 *db;
}

@property(nonatomic) const char *dbPath;
@property(nonatomic, strong) NSString *databasePath;

-(void) initDatabase;
-(BOOL) savePerson:(Person *) personDAO;
-(BOOL) deletePerson:(Person *) personDAO;
-(NSMutableArray *) getPeople;
-(Person *) getPerson:(NSInteger) personID;


@end
