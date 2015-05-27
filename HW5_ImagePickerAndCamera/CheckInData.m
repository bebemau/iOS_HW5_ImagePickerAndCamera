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

#pragma mark - NSCoding

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.pictures = [aDecoder decodeObjectForKey:@"pictures"];
    self.placeName = [aDecoder decodeObjectForKey:@"placeName"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.pictures forKey:@"pictures"];
    [aCoder encodeObject:self.placeName forKey:@"placeName"];
}

@end
