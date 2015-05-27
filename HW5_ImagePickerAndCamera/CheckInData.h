//
//  CheckInData.h
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/19/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CheckInData : NSObject <NSCoding>

@property NSMutableArray *pictures;
@property NSString *placeName;

-(void)AddPictures:(UIImage*)image;

@end
