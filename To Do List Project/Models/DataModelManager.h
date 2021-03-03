//
//  DataModelManager.h
//  To Do List Project
//
//  Created by Hala on 03/03/2021.
//

#import <Foundation/Foundation.h>


@interface DataModelManager : NSObject

@property NSMutableArray<NSMutableDictionary*> *allTasks;

@property NSMutableArray<NSMutableDictionary*> *inProgressTasks;

@property NSMutableArray<NSMutableDictionary*> *doneTasks;

@property NSUserDefaults *defaults;


@end

