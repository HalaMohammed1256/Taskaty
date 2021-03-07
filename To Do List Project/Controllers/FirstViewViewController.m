//
//  FirstViewViewController.m
//  To Do List Project
//
//  Created by Hala on 07/03/2021.
//

#import "FirstViewViewController.h"

@interface FirstViewViewController ()

@end


@implementation FirstViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _subViewDesign.layer.cornerRadius = 43;
    
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
    
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    

    
}

-(void) nextPage{
    
    TaskatyViewController *taskaty = [self.storyboard instantiateViewControllerWithIdentifier:@"task_tab_bar"];
    
    [taskaty setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [taskaty setModalPresentationStyle: UIModalPresentationFullScreen];
    [self presentViewController:taskaty animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
