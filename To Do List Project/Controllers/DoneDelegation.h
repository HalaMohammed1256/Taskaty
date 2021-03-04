//
//  DoneDelegation.h
//  To Do List Project
//
//  Created by Hala on 04/03/2021.
//

#import <Foundation/Foundation.h>


@protocol DoneDelegation <NSObject>

-(void) doneTaskDelegation : (NSMutableDictionary*) dictionary : (NSInteger) indexValue;

@end

