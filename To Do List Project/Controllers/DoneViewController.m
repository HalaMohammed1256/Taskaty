//
//  DoneViewController.m
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "DoneViewController.h"

@interface DoneViewController (){
    NSUserDefaults *defaults;
}

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    // to remove empty cell in table
    _doneTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // NSMutableArray for done tasks
    if ([[defaults objectForKey:@"done_tasks"] mutableCopy] == nil) {
        _doneTasks = [NSMutableArray new];
    }else{
        _doneTasks = [[defaults objectForKey:@"done_tasks"] mutableCopy];
    }
    
    [_doneTableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [_doneTableView reloadData];
}

- (void)doneTaskDelegation:(NSMutableDictionary *)dictionary :(NSInteger)indexValue{
    
    //[_doneTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
    
    [_doneTasks removeObjectAtIndex:indexValue];
    [_doneTasks addObject:dictionary];
    
    
    [defaults setObject:_doneTasks forKey:@"done_tasks"];
    [defaults synchronize];
    [_doneTableView reloadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_doneTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringFromDate:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    cell.labelDate.text = dateString;
    cell.labelName.text = [[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"name"];

    if([[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"High"]){
        cell.imagePriority.tintColor = [UIColor redColor];
    }else if([[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"Medium"]){
        cell.imagePriority.tintColor = [UIColor blueColor];
    }else{
        cell.imagePriority.tintColor = [UIColor greenColor];
    }
    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // remove from 2 arrays
    //[_allTasks removeObjectAtIndex:indexPath.row];
    [_doneTasks removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    [defaults setObject:_doneTasks forKey:@"done_tasks"];
    
    [defaults synchronize];
    [_doneTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];
    
    [editTask setDoneEditDelegation:self];

    [editTask setEditName:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"name"]];

    [editTask setEditDescription:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"description"]];

    [editTask setEditPriority:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"priority"]];

    [editTask setEditDate:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    [editTask setEditState:[[_doneTasks objectAtIndex:indexPath.row] objectForKey:@"state"]];
        
    [editTask setRowIndex:indexPath.row];
    
    [self.navigationController pushViewController:editTask animated:YES];
    
}


@end
