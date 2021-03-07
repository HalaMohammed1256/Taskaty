//
//  InProgressViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "ViewController.h"
#import "InProgressTableViewCell.h"
#import "InProgressEditDelegation.h"
#import "EditTaskViewController.h"
#import <UserNotifications/UserNotifications.h>




@interface InProgressViewController : ViewController <UITableViewDelegate, UITableViewDataSource, InProgressEditDelegation, UISearchBarDelegate>

@property NSMutableArray<NSMutableDictionary*> *inProgressTasks;
@property NSMutableArray<NSMutableDictionary*> *doneTasks;

@property (weak, nonatomic) IBOutlet UITableView *inProgressTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *progressSearchBar;

@end

