//
//  EditDelegation.h
//  To Do List Project
//
//  Created by Hala on 03/03/2021.
//

#import <Foundation/Foundation.h>


@protocol EditDelegation <NSObject>

-(void) editTaskDelegation : (NSMutableDictionary*) dictionary : (NSInteger) indexValue;

@end

