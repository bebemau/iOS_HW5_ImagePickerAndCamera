//
//  FindLocationViewController.h
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/21/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FindLocationViewController;

@protocol FindLocationViewControllerDelegate <NSObject>

- (void)findLocationViewControllerPlaceSelected:(FindLocationViewController *)vc placeName:(NSString *)name;

@end

@interface FindLocationViewController : UIViewController
@property (nonatomic, weak) id<FindLocationViewControllerDelegate>delegate;
@end
