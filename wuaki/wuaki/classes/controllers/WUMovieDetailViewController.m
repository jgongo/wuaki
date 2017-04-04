//
//  WUMovieDetailViewController.m
//  wuaki
//
//  Created by José González Gómez on 3/4/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import "WUMovieDetailViewController.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "WULogLevel.h"

#import "UIViewController+InjectedServices.h"
#import "WUService.h"
#import "WUMovie.h"
#import "WUImage.h"
#import "WUClassification.h"
#import "WUScore.h"
#import "WUSite.h"

#import <RMessage/RMessage.h>
#import <SDWebImage/UIImageView+WebCache.h>


#pragma mark Class extension

@interface WUMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *snapshotImageView;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *classificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scoreSiteImageView;
@end


#pragma mark - Class implementation

@implementation WUMovieDetailViewController

#pragma mark Life cycle management

- (void)updateInterface {
    [self.snapshotImageView sd_setImageWithURL:self.movie.image.snapshot];
    self.yearLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.movie.year];
    self.classificationLabel.text = self.movie.classification.name;
    self.titleLabel.text = self.movie.title;
    self.plotLabel.text = self.movie.plot;
    if (self.movie.scores.count > 0) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%1.1f", self.movie.scores[0].score];
        [self.scoreSiteImageView sd_setImageWithURL:self.movie.scores[0].site.image];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.movie) {
        [self updateInterface];
        [self retrieveMovieDetailsIfNeeded];
    }
}

#pragma mark Properties

- (void)setMovie:(WUMovie *)movie {
    _movie = movie;
    if (self.isViewLoaded) {
        [self updateInterface];
        [self retrieveMovieDetailsIfNeeded];
    }
}

- (void)retrieveMovieDetailsIfNeeded {
    if (self.movie && !self.movie.plot) {
        typeof(self) __weak wself = self;
        [self.service getMovieDetails:self.movie onSuccess:^(WUMovie *movie) {
            wself.movie = movie;
        } onError:^(NSError *error) {
            [RMessage showNotificationWithTitle:@"Qué vergüenza!" subtitle:@"Algo ha pasado intentando mostrarte la información de una de nuestras pelis... ¿tienes activado Internet?" type:RMessageTypeError customTypeName:nil callback:nil];
        }];
    }
}

@end
