//
//  ToDoViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "TodoTableViewCell.h"
#import "ShowDataViewController.h"
#import "DataModel.h"
#import "AddDelegation.h"
//#import "DataModelManager.h"
#import "EditDelegation.h"
#import "EditTaskViewController.h"


@interface ToDoViewController : ViewController <UITableViewDelegate, UITableViewDataSource, AddDelegation, EditDelegation>

@property NSMutableArray<NSMutableDictionary*> *allTasks;


@property (weak, nonatomic) IBOutlet UITableView *allTaskTableView;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;

@end

