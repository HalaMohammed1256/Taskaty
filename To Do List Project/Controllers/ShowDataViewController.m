

#import "ShowDataViewController.h"

@interface ShowDataViewController (){
    NSDateFormatter *formatter;
    NSString *dateString;
    NSDate *dateValue;
    NSMutableDictionary *editDataDictionary;
}

@end

@implementation ShowDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    defaults = [NSUserDefaults standardUserDefaults];
//
//
//    // NSMutableArray for all tasks
//    if ([[defaults objectForKey:@"todo_tasks"] mutableCopy] == nil) {
//        [manager setAllTasks:[NSMutableArray new]];
//    }else{
//        [manager setAllTasks:[[[manager defaults] objectForKey:@"todo_tasks"] mutableCopy]];
//    }
    
    // edit data dictionary
    editDataDictionary = [NSMutableDictionary new];
    dateValue = [NSDate new];
    
    // add bar button
    UIBarButtonItem *editTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTaskAction)];
    

    [self.navigationItem setRightBarButtonItem:editTaskButton];
    
    
    
    // add save button
    UIBarButtonItem *saveTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveTaskAction)];
    

    [self.navigationItem setLeftBarButtonItem:saveTaskButton];
    
    
    // hide back button
    [self. navigationItem setHidesBackButton:YES];
    
    _showDescriptionTextView.editable = NO;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    dateString = [formatter stringFromDate: _showDate];
    
    _showNameLabel.text = _showName;
    _showDescriptionTextView.text = _showDescription;
    _showPriorityLabel.text = _showPriority;
    _showDateLabel.text = dateString;
    _showStateLabel.text = _showState;
        
}


-(void) editTaskAction{
    
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];
    
    [editTask setShowDelegation:self];

    [editTask setEditName:_showName];

    [editTask setEditDescription:_showDescription];

    [editTask setEditPriority:_showPriority];

    [editTask setEditDate:_showDate];
    
    [editTask setRowIndex:_rowIndex];
    
    [editTask setEditState:_showState];
    


    [self.navigationController pushViewController:editTask animated:YES];
        
}

-(void) saveTaskAction{
    
    DataModel *model = [DataModel new];
    model.taskName = _showNameLabel.text;
    
//    NSDate *dateValue = [[NSDate alloc] init];
//    dateValue = [formatter dateFromString:_showDateLabel.text];
    
    model.taskDate = dateValue;
    
    model.taskDescription = _showDescriptionTextView.text;
    model.taskState = _showStateLabel.text;
    model.taskPriority = _showPriorityLabel.text;

        
    [editDataDictionary setObject:model.taskName forKey:@"name"];
    [editDataDictionary setObject:model.taskDescription forKey:@"description"];
    [editDataDictionary setObject:model.taskPriority forKey:@"priority"];
    [editDataDictionary setObject:model.taskDate forKey:@"date"];
    [editDataDictionary setObject:model.taskState forKey:@"state"];
    
    [_editDedegation editTaskDelegation:editDataDictionary : _rowIndex];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)showTaskDelegation:(NSMutableDictionary *)dictionary :(NSInteger)indexValue{
    _showDictionary = dictionary;
    
    _showNameLabel.text = [dictionary objectForKey: @"name"];
    _showDescriptionTextView.text = [dictionary objectForKey: @"description"];
    _showPriorityLabel.text = [dictionary objectForKey: @"priority"];
    
    dateString = [formatter stringFromDate: [dictionary objectForKey: @"date"]];
    
    _showDateLabel.text = dateString;
    _showStateLabel.text = [dictionary objectForKey: @"state"];
    
    
    dateValue = [dictionary objectForKey: @"date"];


}




@end
