//
//  ToDoViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "TodoTableViewCell.h"
#import "EditTaskViewController.h"
#import "DataModel.h"
#import "AddDelegation.h"


@interface ToDoViewController : ViewController <UITableViewDelegate, UITableViewDataSource, AddDelegation>

@property NSMutableArray<NSMutableDictionary*> *allTasks;


@property (weak, nonatomic) IBOutlet UITableView *allTaskTableView;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;

@end

