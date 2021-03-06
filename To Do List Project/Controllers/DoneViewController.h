//
//  DoneViewController.h
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "ViewController.h"
#import "DoneTableViewCell.h"
#import "DoneDelegation.h"
#import "EditTaskViewController.h"

@interface DoneViewController : ViewController <UITableViewDelegate, UITableViewDataSource, DoneDelegation>

@property NSMutableArray<NSMutableDictionary*> *doneTasks;

@property (weak, nonatomic) IBOutlet UITableView *doneTableView;

@property NSString *test;

@end

