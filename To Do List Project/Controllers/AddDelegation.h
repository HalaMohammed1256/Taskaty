//
//  AddDelegation.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@protocol AddDelegation <NSObject>

-(void) addTask: (DataModel*) dataModel;

@end

