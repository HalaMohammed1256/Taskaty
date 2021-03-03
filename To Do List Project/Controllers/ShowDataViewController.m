//
//  ShowDataViewController.m
//  To Do List Project
//
//  Created by Hala on 02/03/2021.
//

#import "ShowDataViewController.h"

@interface ShowDataViewController ()

@end

@implementation ShowDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // add bar button
    UIBarButtonItem *editTaskButton = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTaskAction)];
    

    [self.navigationItem setRightBarButtonItem:editTaskButton];
    
    
    _showDescriptionTextView.editable = NO;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:min a"];
    NSString *dateString = [formatter stringFromDate: _showDate];
    
    _showNameLabel.text = _showName;
    _showDescriptionTextView.text = _showDescription;
    _showPriorityLabel.text = _showPriority;
    _showDateLabel.text = dateString;
    
}


-(void) editTaskAction{
    
    EditTaskViewController *editTask = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_task"];


    [editTask setEditName:_showName];

    [editTask setEditDescription:_showDescription];

    [editTask setEditPriority:_showPriority];

    [editTask setEditDate:_showDate];
    
    [editTask setIndex:_index];


    [self.navigationController pushViewController:editTask animated:YES];
        
}


@end
