

#import "ToDoViewController.h"
#

@interface ToDoViewController (){
    NSUserDefaults *defaults;
}
@end

@implementation ToDoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // to remove empty cell in table
    _tasksTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // declear user defaults
    defaults = [NSUserDefaults standardUserDefaults];

    // NSMutableArray for all tasks
    if ([[defaults objectForKey:@"todo_tasks"] mutableCopy] == nil) {
        _allTasks = [NSMutableArray new];
    }else{
        _allTasks = [[defaults objectForKey:@"todo_tasks"] mutableCopy];
    }

    
    
    
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



// add task delegation method
- (void)addTask:(NSMutableDictionary *)dataDictionary{
    
    [_allTasks addObject: dataDictionary];
    [defaults setObject:_allTasks forKey:@"todo_tasks"];
    [defaults synchronize];
    [_allTaskTableView reloadData];
    
}

// edit task delegation
- (void)editTaskDelegation:(NSMutableDictionary *)dictionary :(NSInteger)indexValue{
    
    NSLog(@"%ld\n", indexValue);
    
    [_allTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
    [defaults setObject:_allTasks forKey:@"todo_tasks"];
    [defaults synchronize];
    [_allTaskTableView reloadData];
    
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
    
    
    [_allTasks removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [defaults setObject:_allTasks forKey:@"todo_tasks"];
    
    [defaults synchronize];
    [_allTaskTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
