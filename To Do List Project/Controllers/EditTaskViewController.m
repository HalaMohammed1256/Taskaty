
#import "EditTaskViewController.h"

@interface EditTaskViewController (){
    NSArray *priorityArray;
    NSArray *stateArray;
    
    NSString *priority;
    
    NSInteger selectedIndex;
}

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
//    NSString *dateString = [formatter stringFromDate: _showDate];
    
    
    priorityArray = @[@"High", @"Medium", @"Low"];
    
    self.priorityPicker.delegate = self;
    self.priorityPicker.dataSource = self;
    
    _editNameTextField.text = _editName;
    _editDescriptionTextView.text = _editDescription;
    _editDatePicker.date = _editDate;
    priority = _editPriority;
    
    
    
    selectedIndex = (NSInteger)[priorityArray indexOfObject:priority];
        
    [self.priorityPicker selectRow:selectedIndex inComponent:0 animated:YES];
    
   
    // save bar button
    UIBarButtonItem *addTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveTaskAction)];
        
    [self.navigationItem setRightBarButtonItem:addTaskButton];

}

-(void) saveTaskAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Do you want to save changes" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // if yes
        
        
        
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        // if cancel
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:yesAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:^{
            //
    }];
    
}


-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    NSInteger numberOfRows = [priorityArray count];
    
    return numberOfRows;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleForRow = priorityArray[row];
    
    return titleForRow;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    priority = priorityArray[row];
    
}




@end
