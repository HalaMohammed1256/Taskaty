

#import "ToDoViewController.h"
#

@interface ToDoViewController (){
    NSUserDefaults *defaults;
}

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // NSMutableArray for all tasks
    _allTasks = [NSMutableArray new];
    
    // to remove empty cell in table
    _tasksTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // declear user defaults
    defaults = [NSUserDefaults standardUserDefaults];
    
    
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
    
    AddTaskViewController *addTask = [self.storyboard instantiateViewControllerWithIdentifier:@"add_task"];
    [addTask setAddTaskDelegation:self];
    [self.navigationController pushViewController:addTask animated:YES];
    
}


// add task delegation method
- (void)addTask:(DataModel *)dataModel{
    
    [_allTasks addObject: dataModel];
    
    [defaults setObject:dataModel.taskName forKey:@"add_name"];
    [defaults setObject:dataModel.taskDescription forKey:@"add_description"];
    [defaults setObject:dataModel.taskPriority forKey:@"add_priority"];
    [defaults setObject:dataModel.taskDate forKey:@"add_date"];
    [defaults setObject:dataModel.taskState forKey:@"add_state"];
    
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
    
    
    // from array
    cell.labelName.text = [_allTasks objectAtIndex:indexPath.row].taskName;
    cell.labelDate.text = [_allTasks objectAtIndex:indexPath.row].taskDate;

    if([[_allTasks objectAtIndex:indexPath.row].taskPriority isEqualToString: @"High"]){
        cell.imagePriority.tintColor = [UIColor redColor];
    }else if([[_allTasks objectAtIndex:indexPath.row].taskPriority isEqualToString: @"Medium"]){
        cell.imagePriority.tintColor = [UIColor blueColor];
    }else{
        cell.imagePriority.tintColor = [UIColor greenColor];
    }
    
    
    // from user defaults

    
    
    
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
