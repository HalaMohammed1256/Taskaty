

#import "ToDoViewController.h"
#

@interface ToDoViewController (){
    
    DataModelManager *manager;
    NSUserDefaults *d;
        
}

@end

@implementation ToDoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // to remove empty cell in table
    _tasksTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // declear user defaults
    manager = [DataModelManager new];
    d = [NSUserDefaults standardUserDefaults];
    [manager setDefaults:d];
    
    
    
    // NSMutableArray for all tasks
    if ([[[manager defaults] objectForKey:@"all_todo_tasks"] mutableCopy] == nil) {
        [manager setAllTasks:[NSMutableArray new]];
    }else{
        [manager setAllTasks:[[[manager defaults] objectForKey:@"all_todo_tasks"] mutableCopy]];
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
    
    [[manager allTasks] addObject: dataDictionary];
    [[manager defaults] setObject:[manager allTasks] forKey:@"all_todo_tasks"];
    [[manager defaults] synchronize];
    [_allTaskTableView reloadData];
    
}
    



// table methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[manager allTasks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringFromDate:[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    cell.labelDate.text = dateString;
    cell.labelName.text = [[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"name"];

    if([[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"High"]){
        cell.imagePriority.tintColor = [UIColor redColor];
    }else if([[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"Medium"]){
        cell.imagePriority.tintColor = [UIColor blueColor];
    }else{
        cell.imagePriority.tintColor = [UIColor greenColor];
    }
    

    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[manager allTasks] removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [[manager defaults] setObject:[manager allTasks] forKey:@"all_todo_tasks"];
    
    [[manager defaults] synchronize];
    [_allTaskTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShowDataViewController *showTask = [self.storyboard instantiateViewControllerWithIdentifier:@"show_task"];
    
    
    
    [showTask setShowName:[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    [showTask setShowDescription:[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"description"]];
    
    [showTask setShowPriority:[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"priority"]];
    
    [showTask setShowDate:[[[manager allTasks] objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    
    [showTask setIndex: [NSNumber numberWithInteger:indexPath.row]];
        
    [self.navigationController pushViewController:showTask animated:YES];
    
}






@end
