//
//  CollectionViewController.h
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/18/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInData.h"

@class CollectionViewController;

@protocol CollectionViewControllerDelegate <NSObject>

- (void)collectionViewControllerImagesSelected:(CollectionViewController *)vc imagesSelected:(NSArray *)images;

@end

@interface CollectionViewController : UICollectionViewController
@property CheckInData *checkInData;
@property (nonatomic, weak) id<CollectionViewControllerDelegate>delegate;
@end
