

#import "AddTaskViewController.h"

@interface AddTaskViewController (){
    NSArray *priorityArray;
    NSString* priority;
    
}

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    priorityArray = @[@"High", @"Medium", @"Low"];
    
    // to set priority on select data picker
    priority = priorityArray[0];
    
    // to tell the priority data picker that self (todo view) conform the required data picker delegation
    self.priorityPicker.delegate = self;
    self.priorityPicker.dataSource = self;
    
    
    // save bar button
    UIBarButtonItem *addTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveTaskAction)];
        
    [self.navigationItem setRightBarButtonItem:addTaskButton];
}

-(void) saveTaskAction{
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [formatter stringFromDate:[_addDatePicker date]];
    
    DataModel *model = [DataModel new];
    model.taskName = _addNameTextField.text;
    model.taskDate = dateString;
    model.taskDescription = _addDescriptionTextView.text;
    model.taskPriority = priority;
    model.taskState = @"In progress";
    
    

    [_addTaskDelegation addTask:model];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


// data picker methods

-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    NSInteger numberOfRows = [priorityArray count];
    
    return numberOfRows;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleForRow = priorityArray[row];;
    
    return titleForRow;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        priority = priorityArray[row];
        
}




@end
