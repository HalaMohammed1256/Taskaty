//
//  InProgressViewController.m
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "InProgressViewController.h"

@interface InProgressViewController (){
    NSUserDefaults *defaults;
    
    BOOL isFilled;
    NSMutableArray *filteredArray;
}


@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // to remove empty cell in table 
    _inProgressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // search delegate
    self.progressSearchBar.delegate = self;
    isFilled = false;
    
    // declear user defaults
    defaults = [NSUserDefaults standardUserDefaults];

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
    
    
    [_inProgressTableView reloadData];
    
}


// search method
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if (searchText.length == 0) {
        isFilled = false;
    }else{
        isFilled = true;
        filteredArray = [NSMutableArray new];

        for (NSMutableDictionary *dic in _inProgressTasks) {
            NSRange taskNameRange = [[dic objectForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if(taskNameRange.location != NSNotFound){
                [filteredArray addObject:dic];
            }

        }

    }

    //
        [_inProgressTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated{
  
    if ([[defaults objectForKey:@"in_progress_tasks"] mutableCopy] == nil) {
        _inProgressTasks = [NSMutableArray new];
    }else{
        _inProgressTasks = [[defaults objectForKey:@"in_progress_tasks"] mutableCopy];
    }
    
    [_inProgressTableView reloadData];
}

- (void)editTaskDelegation:(NSMutableDictionary *)dictionary :(NSInteger)indexValue{

//    [_inProgressTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
//
//
//    [_inProgressTasks removeObjectAtIndex:indexValue];
//    [_inProgressTasks addObject:dictionary];
//
//
//    [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];
//    [defaults synchronize];
//    [_inProgressTableView reloadData];
    
    
    
    
    [_inProgressTasks replaceObjectAtIndex:(NSUInteger)indexValue withObject:dictionary];
    [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];

  
    
    
    if ([[dictionary objectForKey:@"state"] isEqual:@"Done"]){
        // done
        if([[defaults objectForKey:@"done_tasks"] mutableCopy] == nil || [[defaults objectForKey:@"done_tasks"] count] == 0){
            [_doneTasks removeAllObjects];
            [_doneTasks addObject: dictionary];
            [defaults setObject:_doneTasks forKey:@"done_tasks"];
        }

        else{
            [_doneTasks addObject: dictionary];
            [defaults setObject:_doneTasks forKey:@"done_tasks"];
        }
        
                
        //
        [_inProgressTasks removeObjectAtIndex:(NSUInteger)indexValue];
        [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];
        //
    }
    
    
        [defaults synchronize];
        [_inProgressTableView reloadData];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFilled) {
        return [filteredArray count];
    }else{
        return [_inProgressTasks count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(isFilled){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
        NSString *dateString = [formatter stringFromDate:[[filteredArray objectAtIndex:indexPath.row] objectForKey:@"creation_date"]];
        
        cell.labelDate.text = dateString;
                cell.labelName.text = [[filteredArray objectAtIndex:indexPath.row] objectForKey:@"name"];

        if([[[filteredArray objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"High"]){
            cell.imagePriority.tintColor = [UIColor redColor];
        }else if([[[filteredArray objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"Medium"]){
            cell.imagePriority.tintColor = [UIColor blueColor];
        }else{
            cell.imagePriority.tintColor = [UIColor greenColor];
        }
        
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
        NSString *dateString = [formatter stringFromDate:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"creation_date"]];
        
        cell.labelDate.text = dateString;
        cell.labelName.text = [[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"name"];

        if([[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"High"]){
            cell.imagePriority.tintColor = [UIColor redColor];
        }else if([[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"priority"] isEqualToString: @"Medium"]){
            cell.imagePriority.tintColor = [UIColor blueColor];
        }else{
            cell.imagePriority.tintColor = [UIColor greenColor];
        }
    }
    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // remove from 2 arrays
    //[_allTasks removeObjectAtIndex:indexPath.row];
    
    
    [_inProgressTasks removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    [defaults setObject:_inProgressTasks forKey:@"in_progress_tasks"];
    
    [defaults synchronize];
    [_inProgressTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];
    
    [editTask setInProgressEditDelegation:self];
    

    [editTask setEditName:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"name"]];

    [editTask setEditDescription:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"description"]];

    [editTask setEditPriority:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"priority"]];

    [editTask setEditDate:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    [editTask setEditState:[[_inProgressTasks objectAtIndex:indexPath.row] objectForKey:@"state"]];
        
    [editTask setRowIndex:indexPath.row];
    
    
    
    
    [self.navigationController pushViewController:editTask animated:YES];
    
}


- (IBAction)reloadAction:(id)sender {
    [_inProgressTableView reloadData];
}

@end
