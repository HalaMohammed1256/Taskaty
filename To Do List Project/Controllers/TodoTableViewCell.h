//
//  TodoTableViewCell.h
//  To Do List Project
//
//  Created by Hala on 01/03/2021.
//

#import <UIKit/UIKit.h>


@interface TodoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@property (weak, nonatomic) IBOutlet UIImageView *imagePriority;





@end

