//
//  ShowDataViewController.h
//  To Do List Project
//
//  Created by Hala on 02/03/2021.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"


@interface ShowDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;

@property (weak, nonatomic) IBOutlet UITextView *showDescriptionTextView;

@property (weak, nonatomic) IBOutlet UILabel *showPriorityLabel;


@property (weak, nonatomic) IBOutlet UILabel *showDateLabel;


@property NSString* showName;
@property NSString* showDescription;
@property NSString* showPriority;
//@property NSString* editState;
@property NSDate* showDate;
@property NSNumber *index;


@end

