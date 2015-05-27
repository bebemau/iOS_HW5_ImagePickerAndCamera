//
//  CheckinDataList.h
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/26/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckInData.h"

@interface CheckinDataList : NSObject
@property (nonatomic, readwrite) NSMutableArray *checkinList;
-(void)addCheckinList:(CheckInData *)checkIn;
-(NSInteger)itemCount;
-(CheckInData*)itemAtIndex: (NSInteger)index;
@end
