//
//  CheckInData.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/19/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "CheckInData.h"

@implementation CheckInData

-(void)AddPictures:(UIImage*)image{
    if(self.pictures == nil)
        self.pictures = [[NSMutableArray alloc] init];
    
    [self.pictures addObject:image];
}

@end
