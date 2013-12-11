//
//  PersonDAO.m
//  CRUD Application
//
//  Created by Efrain Toribio Reyes on 11/10/13.
//  Copyright (c) 2013 Efrain Toribio Reyes. All rights reserved.
//

#import "Person.h"
#import "PersonDAO.h"

@implementation PersonDAO

@synthesize dbPath;
@synthesize databasePath;


-(void) initDatabase {
    databasePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"test.sqlite"];
    dbPath = [databasePath UTF8String];
}

-(BOOL) savePerson:(Person *)personDAO {
    
    BOOL success = false;
    sqlite3_stmt *sqlStatement = NULL;
    @try {
        if(sqlite3_open(dbPath, &db) == SQLITE_OK) {
            
            if(personDAO.personID > 0) {
                NSLog(@"Existing Data, Update Please");
                NSString *updateSQL = [NSString stringWithFormat:@"update people set name = '%@', lastName = '%@', telephone = '%@' where id = ?", personDAO.firstName, personDAO.lastName, personDAO.telephone];
                
                const char *updateStatement = [updateSQL UTF8String];
                sqlite3_prepare_v2(db, updateStatement, -1, &sqlStatement, NULL);
                sqlite3_bind_int(sqlStatement, 1, *personDAO.personID);
                
                if(sqlite3_step(sqlStatement) == SQLITE_DONE) {
                    success = true;
                }
            } else  {
                NSLog(@"New Person, Insert Data");
                NSString *insertSQL = [NSString stringWithFormat:@"insert into people (name, lastname, telephone) values ('%@', '%@', '%@')", personDAO.firstName, personDAO.lastName, personDAO.telephone];
                
                const char *insertStatement = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insertStatement, -1, &sqlStatement, NULL);
                
                if(sqlite3_step(sqlStatement) == SQLITE_DONE) {
                    success = true;
                }
                sqlite3_finalize(sqlStatement);
                sqlite3_close(db);
            }
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception has ocurred %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        sqlite3_close(db);
        return success;
    }
}

-(BOOL) deletePerson:(Person *)personDAO {
    
    sqlite3_stmt *statement;
    BOOL success = false;
    
    @try {
        if(sqlite3_open(dbPath, &db) == SQLITE_OK) {
            
            if(personDAO.personID > 0) {
                
                NSString *deleteSQL = [NSString stringWithFormat:@"delete from people where id = %d", *personDAO.personID];
                const char *deleteStatement = [deleteSQL UTF8String];
                if(sqlite3_prepare_v2(db, deleteStatement, -1, &statement, NULL) == SQLITE_OK) {
                    if(sqlite3_step(statement) == SQLITE_DONE) {
                        success = true;
                    }
                }
            } else {
                NSLog(@"Nothing to delete, new Person");
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception has ocurred %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return success;
    }
    
}

-(NSMutableArray *) getPeople {

    NSMutableArray *people = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *sqlStatement;
    @try {
        
        if((!sqlite3_open(dbPath, &db) == SQLITE_OK)) {
            NSLog(@"An error has ocurred");
        }
        
        const char *sql = "select * from people";
        
        
        if(sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Error with the statement");
        }
        
        while(sqlite3_step(sqlStatement) == SQLITE_ROW) {
            Person *personDAO = [[Person alloc] init];
            personDAO.personID = (NSInteger *)sqlite3_column_int(sqlStatement, 0);
            personDAO.firstName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            personDAO.lastName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            personDAO.telephone = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            [people addObject:personDAO];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception has ocurred %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        sqlite3_close(db);

        return people;
    }
}

-(Person *) getPerson:(NSInteger)personID {
    
    Person *personReturn = [[Person alloc] init];
    sqlite3_stmt *statement;
    
    @try {
        if(sqlite3_open(dbPath, &db) == SQLITE_OK) {
            NSString *query = [NSString stringWithFormat:@"select * from people where id = %d", personID];
            const char *queryStatement = [query UTF8String];
            
            if(sqlite3_prepare_v2(db, queryStatement, -1, &statement, NULL) == SQLITE_OK) {
                if(sqlite3_step(statement) == SQLITE_ROW) {
                    personReturn.personID = (NSInteger *)sqlite3_column_int(statement, 0);
                    personReturn.firstName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                    personReturn.lastName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
                    personReturn.telephone = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)];
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception has ocurred %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return personReturn;
    }
}

@end
