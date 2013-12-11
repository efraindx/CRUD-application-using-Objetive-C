//
//  PersonList.h
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/8/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PersonDAO.h"

@interface PersonList : NSObject {
    sqlite3 *db;
}

@property(nonatomic) const char *dbPath;
@property(nonatomic, strong) NSString *databasePath;

-(void) initDatabase;
-(BOOL) savePerson:(PersonDAO *) personDAO;
-(BOOL) deletePerson:(PersonDAO *) personDAO;
-(NSMutableArray *) getPeople;
-(PersonDAO *) getPerson:(NSInteger) personID;

@end
