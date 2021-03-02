//
//  DataModel.m
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "DataModel.h"

@implementation DataModel

-(id) initWithName : (NSString*) name description : (NSString*) description priority :  (NSString*) priority date : (NSString*) date state : (NSString*) state{
    
    self = [super init];
    
    if(self){
        [_taskDate isEqual: date];
        [_taskName isEqual: name];
        [_taskState isEqual: state];
        [_taskPriority isEqual: priority];
        [_taskDescription isEqual: description];
    }
    
    return self;
}

@end
