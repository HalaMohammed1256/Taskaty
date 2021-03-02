//
//  EditTaskViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import <UIKit/UIKit.h>


@interface EditTaskViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;


@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;

@property (weak, nonatomic) IBOutlet UITextView *editDescriptionTextView;

@property (weak, nonatomic) IBOutlet UIDatePicker *editDatePicker;



@end

