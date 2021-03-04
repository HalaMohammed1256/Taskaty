//
//  InProgressEditDelegation.h
//  To Do List Project
//
//  Created by Hala on 04/03/2021.
//

#import <Foundation/Foundation.h>


@protocol InProgressEditDelegation <NSObject>

-(void) editTaskDelegation : (NSMutableDictionary*) dictionary : (NSInteger) indexValue;


@end

