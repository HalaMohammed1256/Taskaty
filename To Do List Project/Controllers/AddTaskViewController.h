//
//  AddTaskViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import <UIKit/UIKit.h>
#import "AddDelegation.h"
#import "DataModel.h"


@interface AddTaskViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property id <AddDelegation> addTaskDelegation;

@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;


@property (weak, nonatomic) IBOutlet UITextField *addNameTextField;

@property (weak, nonatomic) IBOutlet UITextView *addDescriptionTextView;


@property (weak, nonatomic) IBOutlet UIDatePicker *addDatePicker;



@end

