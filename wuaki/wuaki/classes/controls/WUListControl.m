//
//  WUListControl.m
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUListControl.h"
#import "WUMovieSelectedRecognizer.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "WULogLevel.h"

#import "WUList.h"
#import "WUContent.h"
#import "WUMovie.h"
#import "WUTVShow.h"
#import "WUImage.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>


#pragma mark Class extension

@interface WUListControl ()
@property (nonatomic, strong) WUList *list;
@end


#pragma mark - Class implementation


@implementation WUListControl

#pragma mark Init and dealloc

- (instancetype)initWithList:(WUList *)list {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _list = list;
        [self setupInterface];
    }
    return self;
}

- (CGFloat)aspectRatioFor:(WUContent *)content {
    return [content isKindOfClass:[WUMovie class]] ? 5.0/7.0 : 4.0/3.0; // This should be better placed in a WUContent category
}

- (void)setupInterface {
    // First remove everything
    [self.subviews enumerateObjectsUsingBlock:^(UIView * subview, NSUInteger idx, BOOL *stop) {
        [subview removeFromSuperview];
    }];
    
    if (self.list) {
        UILabel *listHeader = [[UILabel alloc] init];
        listHeader.textColor = [UIColor whiteColor];
        listHeader.text = self.list.name;
        [self addSubview:listHeader];
        [listHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat scrollViewHeight = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad ? 175 : 100;
            make.height.equalTo(@(scrollViewHeight));
            make.top.equalTo(listHeader.mas_bottom).with.offset(8);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        UIImageView *previousContentImage;
        for (WUContent *content in self.list.content) {
            UIImageView *contentImage = [[UIImageView alloc] init];
            contentImage.contentMode = UIViewContentModeScaleAspectFill;
            [contentImage sd_setImageWithURL:content.image.artwork];
            [scrollView addSubview:contentImage];
            
            [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(scrollView.mas_height);
                make.width.equalTo(contentImage.mas_height).multipliedBy([self aspectRatioFor:content]);
                make.top.equalTo(scrollView.mas_top);
                make.bottom.equalTo(scrollView.mas_bottom);
            }];
            if (previousContentImage) {
                [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(previousContentImage.mas_right).with.offset(5);
                }];
            } else {
                [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(scrollView.mas_left);
                }];
            }
            
            if ([content isKindOfClass:[WUMovie class]]) {
                WUMovieSelectedRecognizer *selectionRecognizer = [[WUMovieSelectedRecognizer alloc] initWithTarget:self action:@selector(handleSelection:)];
                selectionRecognizer.movie = (WUMovie *)content;
                contentImage.userInteractionEnabled = YES;
                [contentImage addGestureRecognizer:selectionRecognizer];
            }
            
            previousContentImage = contentImage;
        }
        [previousContentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(scrollView.mas_right);
        }];
    }
}

#pragma mark Event management

- (void)handleSelection:(WUMovieSelectedRecognizer *)selectionRecognizer {
    if (selectionRecognizer.state == UIGestureRecognizerStateEnded) {
        DDLogInfo(@"Movie selected: %@", selectionRecognizer.movie.title);
        self.lastSelectedMovie = selectionRecognizer.movie;
        [self sendActionsForControlEvents:UIControlEventPrimaryActionTriggered];
    }
}

@end
