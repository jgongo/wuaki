//
//  WUFrontPageViewController.m
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUFrontPageViewController.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "WULogLevel.h"

#import "UIViewController+InjectedServices.h"
#import "WUService.h"
#import "WUFrontPage.h"
#import "WUList.h"

#import <Masonry/Masonry.h>
#import <RMessage/RMessage.h>
#import "WUListControl.h"


#pragma mark - Class extension

@interface WUFrontPageViewController ()
@property (nonatomic, weak  ) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) WUFrontPage *frontPage;
@end


#pragma mark - Class implementation

@implementation WUFrontPageViewController

#pragma mark Life cycle management

- (void)viewDidLoad {
    [super viewDidLoad];
    typeof(self) __weak wself = self;
    DDLogDebug(@"Loading front page...");
    [self.service getFrontPageOnSuccess:^(WUFrontPage *frontPage) {
        DDLogInfo(@"Front page retrieved, proceeding to rendering...");
        wself.frontPage = frontPage;
    } onError:^(NSError *error) {
        [RMessage showNotificationWithTitle:@"Qué vergüenza!" subtitle:@"Algo ha pasado intentando mostrarte la lista de nuestras pelis y series... ¿tienes activado Internet?" type:RMessageTypeError customTypeName:nil callback:nil];
    }];
}

#pragma mark - Properties

- (void)setFrontPage:(WUFrontPage *)frontPage {
    _frontPage = frontPage;
    [self buildInterface];
}

#pragma mark - Interface

- (void)buildInterface {
    UIControl *previousListControl;
    
    for (WUList *list in self.frontPage.lists) {
        WUListControl *listControl = [[WUListControl alloc] initWithList:list];
        [self.scrollView addSubview:listControl];
        
        [listControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.left.equalTo(self.scrollView.mas_left);
            make.right.equalTo(self.scrollView.mas_right);
        }];
        if (previousListControl) {
            [listControl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousListControl.mas_bottom).with.offset(8);
            }];
        } else {
            [listControl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.scrollView.mas_top).with.offset(20);
            }];
        }
        
        previousListControl = listControl;
    }
    
    [previousListControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView.mas_bottom);
    }];
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
