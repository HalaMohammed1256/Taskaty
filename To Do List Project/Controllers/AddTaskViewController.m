

#import "AddTaskViewController.h"

@interface AddTaskViewController (){
    NSArray *priorityArray;
    NSString* priority;
    
    NSMutableDictionary *dataDictionary;
    
}

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataDictionary = [NSMutableDictionary new];
    
    priorityArray = @[@"High", @"Medium", @"Low"];
        
    // to set priority on select data picker
    priority = [NSString new];
    
    // to tell the priority data picker that self (todo view) conform the required data picker delegation
    self.priorityPicker.delegate = self;
    self.priorityPicker.dataSource = self;
    
    
    // save bar button
    UIBarButtonItem *addTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveTaskAction)];
        
    [self.navigationItem setRightBarButtonItem:addTaskButton];
}

-(void) saveTaskAction{
    
    DataModel *model = [DataModel new];
    model.taskName = _addNameTextField.text;
    model.taskDate = _addDatePicker.date; // now
    model.taskDescription = _addDescriptionTextView.text;
    
    if(priority == nil){
        model.taskPriority = priorityArray[0];
    }else{
        model.taskPriority = priority;
    }
    
    model.taskState = @"In progress";
    
    [dataDictionary setObject:model.taskName forKey:@"name"];
    [dataDictionary setObject:model.taskDescription forKey:@"description"];
    [dataDictionary setObject:model.taskPriority forKey:@"priority"];
    [dataDictionary setObject:model.taskDate forKey:@"date"];
    [dataDictionary setObject:model.taskState forKey:@"state"];
    
    
    [_addTaskDelegation addTask:dataDictionary];
    
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
