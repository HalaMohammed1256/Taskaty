//
//  DataModel.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import <Foundation/Foundation.h>


@interface DataModel : NSObject

@property NSString* taskName;
@property NSString* taskDescription;
@property NSString* taskPriority;
@property NSString* taskState;
@property NSString* taskDate;


-(id) initWithName : (NSString*) taskName description : (NSString*) taskDescription priority :  (NSString*) taskPriority date : (NSString*) taskDate state : (NSString*) taskState;

@end

