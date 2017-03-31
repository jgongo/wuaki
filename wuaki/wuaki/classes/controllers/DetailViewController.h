//
//  DetailViewController.h
//  wuaki
//
//  Created by José González Gómez on 31/3/17.
//  Copyright © 2017 OPEN input. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

