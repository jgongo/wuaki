//
//  WUFrontPageViewController.m
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUFrontPageViewController.h"
#import "UIViewController+InjectedServices.h"
#import "WUService.h"


#pragma mark - Class extension

@interface WUFrontPageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end


#pragma mark - Class implementation

@implementation WUFrontPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
