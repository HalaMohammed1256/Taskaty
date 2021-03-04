

#import "ToDoViewController.h"
#

@interface ToDoViewController (){
    NSUserDefaults *defaults;
    
    NSString *stateForRemove;
    NSMutableDictionary *dictionaryForRemove;
    NSMutableDictionary *dictionaryForEdit;
    
    ShowDataViewController *showTask;
    InProgressViewController *progressView;
}
@end

@implementation ToDoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // to remove empty cell in table
    _tasksTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // declear user defaults
    defaults = [NSUserDefaults standardUserDefaults];
    dictionaryForRemove = [NSMutableDictionary new];
    dictionaryForEdit = [NSMutableDictionary new];

    // NSMutableArray for all tasks
    if ([[defaults objectForKey:@"todo_tasks"] mutableCopy] == nil) {
        _allTasks = [NSMutableArray new];
    }else{
        _allTasks = [[defaults objectForKey:@"todo_tasks"] mutableCopy];
    }
    
    // NSMutableArray for in progress tasks
    if ([[defaults objectForKey:@"in_progress_tasks"] mutableCopy] == nil) {
        _inProgressTasks = [NSMutableArray new];
    }else{
        _inProgressTasks = [[defaults objectForKey:@"in_progress_tasks"] mutableCopy];
    }
    
    // NSMutableArray for done tasks
    if ([[defaults objectForKey:@"done_tasks"] mutableCopy] == nil) {
        _doneTasks = [NSMutableArray new];
    }else{
        _doneTasks = [[defaults objectForKey:@"done_tasks"] mutableCopy];
    }

    
    showTask = [self.storyboard instantiateViewControllerWithIdentifier:@"show_task"];
    progressView = [self.storyboard instantiateViewControllerWithIdentifier:@"progress_task"];
    
    
    // add bar button
    UIBarButtonItem *addTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(addTaskAction)];
    
    //UIBarButtonItem *addTaskButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus3"] style:UIBarButtonItemStylePlain target:self action:@selector(addTaskAction)];

    [self.navigationItem setRightBarButtonItem:addTaskButton];
    
    
    // add search on navigator
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.tintColor = [UIColor grayColor];
    searchBar.placeholder = @"Search";
    self.navigationItem.titleView = searchBar;
    
    //add action
    
    
    
    //
    
//    EditTaskViewController *editView = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];
//
//    [editView setEditDelegation:self];
    
    
}

// action on add bar button
- (void)addTaskAction {
    
    AddTaskViewController *addTaskView = [self.storyboard instantiateViewControllerWithIdentifier:@"add_task"];
    [addTaskView setAddTaskDelegation:self];
    [self.navigationController pushViewController:addTaskView animated:YES];
    
}



// remove object

-(void) removeObject : (NSInteger)selectIndex{

    [showTask setEditDedegation:self];

    [showTask setShowName:[[_allTasks objectAtIndex:selectIndex] objectForKey:@"name"]];

    [showTask setShowDescription:[[_allTasks objectAtIndex:selectIndex] objectForKey:@"description"]];

    [showTask setShowPriority:[[_allTasks objectAtIndex:selectIndex] objectForKey:@"priority"]];

    [showTask setShowDate:[[_allTasks objectAtIndex:selectIndex] objectForKey:@"date"]];

    [showTask setShowState:[[_allTasks objectAtIndex:selectIndex] objectForKey:@"state"]];

}




// add task delegation method
- (void)addTask:(NSMutableDictionary *)dataDictionary{
    
    [_allTasks addObject: dataDictionary];
    [defaults setObject:_allTasks forKey:@"todo_tasks"];
    [defaults synchronize];
    [_allTaskTableView reloadData];
    
}

// edit task delegation
- (void)editTaskDelegation:(NSMutableDictionary *)dictionary :(NSInteger)indexValue{
    
    
    stateForRemove = [dictionary objectForKey:@"state"];
    printf("%s\n", [stateForRemove UTF8String]);
    
    
    //[_allTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
    [_allTasks removeObjectAtIndex:indexValue];
    [_allTasks addObject:dictionary];
    
    [defaults setObject:_allTasks forKey:@"todo_tasks"];


    if([[dictionary objectForKey:@"state"] isEqual:@"In Progress"]){
        // in progress
        if([[defaults objectForKey:@"in_progress_tasks"] mutableCopy] == nil || [[defaults objectForKey:@"in_progress_tasks"] count] == 0){
            [_inProgressTasks removeAllObjects];
            [_inProgressTasks addObject: dictionary];
        }else if([_inProgressTasks containsObject: dictionaryForEdit]){
            
            [_inProgressTasks removeObjectIdenticalTo:dictionaryForEdit];
            [_inProgressTasks addObject:dictionary];
            
        }else{
            [_inProgressTasks addObject: dictionary];
        }
        [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];


    }else if ([[dictionary objectForKey:@"state"] isEqual:@"Done"]){
        // done
        if([[defaults objectForKey:@"done_tasks"] mutableCopy] == nil || [[defaults objectForKey:@"done_tasks"] count] == 0){
            [_doneTasks removeAllObjects];
            [_doneTasks addObject: dictionary];
        }else if([_doneTasks containsObject: dictionaryForEdit]){
            
            [_doneTasks removeObjectIdenticalTo:dictionaryForEdit];
            [_doneTasks addObject:dictionary];
            
        }else{
            [_doneTasks addObject: dictionary];
        }
        
        
        [defaults setObject:_doneTasks forKey:@"done_tasks"];
    }


    [defaults synchronize];
    [_allTaskTableView reloadData];

    
    
    ////////////////////////////////////////////////////////
    
    
    
//    if([[dictionary objectForKey:@"state"] isEqual:@"To Do"]){
//        // to do
//        [_allTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
//        [defaults setObject:_allTasks forKey:@"todo_tasks"];
//
//
//    }else if([[dictionary objectForKey:@"state"] isEqual:@"In Progress"]){
//        // in progress
//        if([[defaults objectForKey:@"in_progress_tasks"] mutableCopy] == nil){
//            [_inProgressTasks addObject: dictionary];
//        }else{
//            [_inProgressTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
//        }
//        [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];
//
//
//    }else{
//        // done
//        if([[defaults objectForKey:@"done_tasks"] mutableCopy] == nil){
//            [_doneTasks addObject: dictionary];
//        }else{
//            [_doneTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
//        }
//        [defaults setObject:_doneTasks forKey:@"done_tasks"];
//    }
    
    ///////////////////////////////////////////////////////
    
    
    
    
}


// table methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_allTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringFromDate:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    cell.labelDate.text = dateString;
    cell.labelName.text = [[_allTasks objectAtIndex:indexPath.row] objectForKey:@"name"];

    if([[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"High"]){
        cell.imagePriority.tintColor = [UIColor redColor];
    }else if([[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"Medium"]){
        cell.imagePriority.tintColor = [UIColor blueColor];
    }else{
        cell.imagePriority.tintColor = [UIColor greenColor];
    }
    

    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    dictionaryForRemove = [_allTasks objectAtIndex:indexPath.row];
    
    // if todo => remove from alltasks only
    [_allTasks removeObjectAtIndex:indexPath.row];
    [defaults setObject:_allTasks forKey:@"todo_tasks"];
    
    
    if([stateForRemove isEqual:@"In Progress"]){
        
        // if inprogress => remove from alltasks and inprogress
        [_inProgressTasks removeObjectIdenticalTo: dictionaryForRemove];
        [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];
        
    }else if([stateForRemove isEqual:@"Done"]){
        
        // if done => remove from alltasks and done
        [_doneTasks removeObjectIdenticalTo: dictionaryForRemove];
        [defaults setObject:_doneTasks forKey:@"done_tasks"];

        
    }
    
    
    
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [defaults synchronize];
    [_allTaskTableView reloadData];
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    dictionaryForEdit = [_allTasks objectAtIndex:indexPath.row];
    
    
    ShowDataViewController *showTask = [self.storyboard instantiateViewControllerWithIdentifier:@"show_task"];

    [showTask setEditDedegation:self];

    [showTask setShowName:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"name"]];

    [showTask setShowDescription:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"description"]];

    [showTask setShowPriority:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"priority"]];

    [showTask setShowDate:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"date"]];

    [showTask setShowState:[[_allTasks objectAtIndex:indexPath.row] objectForKey:@"state"]];
        

    [showTask setRowIndex:indexPath.row];
    
    [self.navigationController pushViewController:showTask animated:YES];
    
    

    
}






@end
