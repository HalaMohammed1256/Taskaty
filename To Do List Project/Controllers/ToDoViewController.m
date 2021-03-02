

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
    if ([[defaults objectForKey:@"all_todo_tasks"] mutableCopy] == nil) {
        _allTasks = [NSMutableArray new];
    }else{
        _allTasks = [[defaults objectForKey:@"all_todo_tasks"] mutableCopy];
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
    
    
    [defaults setObject:_allTasks forKey:@"all_todo_tasks"];
    
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
    
    // from array
    cell.labelName.text = [[_allTasks objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.labelDate.text = dateString;

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
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];
    
    [self.navigationController pushViewController:editTask animated:YES];
    

}






@end
