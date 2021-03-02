
#import "EditTaskViewController.h"

@interface EditTaskViewController (){
    NSArray *priorityArray;
    NSArray *stateArray;
}

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    priorityArray = @[@"High", @"Medium", @"Low"];
    stateArray = @[@"Todo", @"In progress", @"Done"];
    
    self.priorityPicker.delegate = self;
    self.priorityPicker.dataSource = self;
    

}




-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    NSInteger numberOfRows = 0;
    
    if(pickerView.tag == 1){
        numberOfRows = [priorityArray count];
    }else {
        numberOfRows = [stateArray count];
    }
    
    return numberOfRows;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleForRow;
    
    if(pickerView.tag == 1){
        titleForRow = priorityArray[row];
    }else {
        titleForRow = stateArray[row];
    }
    
    return titleForRow;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView.tag == 1){
        
        // priority
        
    }else {
        
        // state
        
    }
    
}

@end
