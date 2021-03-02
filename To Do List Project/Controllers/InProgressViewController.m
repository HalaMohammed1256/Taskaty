//
//  InProgressViewController.m
//  To Do List Project
//
//  Created by Hala on 28/02/2021.
//

#import "InProgressViewController.h"

@interface InProgressViewController ()

@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.labelName.text = @"iti";
    cell.labelDate.text = @"20/4/2021";
    cell.imagePriority.tintColor = [UIColor redColor];
    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
