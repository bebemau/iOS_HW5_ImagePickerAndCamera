//
//  CheckinDataList.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/26/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "CheckinDataList.h"

@implementation CheckinDataList

-(void)addCheckinList:(CheckInData *)checkIn{
    if(self.checkinList == nil){
        self.checkinList = [[NSMutableArray alloc] init];
    }
    [self.checkinList addObject:checkIn];
}

-(NSInteger)itemCount{
    return self.checkinList.count;
}

-(CheckInData*)itemAtIndex: (NSInteger)index{
    CheckInData *item = [self.checkinList objectAtIndex:index];
    return item;
}

@end
