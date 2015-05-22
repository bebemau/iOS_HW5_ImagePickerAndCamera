//
//  ViewController.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/13/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "CheckInData.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, CollectionViewControllerDelegate>
@property CheckInData *checkinData;
@property (nonatomic, strong) NSMutableArray *checkinDataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *saveFileURL = [self GetSaveFileUrl];
    self.checkinDataList = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:[saveFileURL path]];
    
    if(self.checkinDataList == nil){
        self.checkinData = [[CheckInData alloc] init];
        self.checkinDataList = [[NSMutableArray alloc] init];
        [self.checkinDataList addObject:self.checkinData];
    }
    else
        self.checkinData = self.checkinDataList[0];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [super prepareForSegue:segue sender:sender];
    
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    CollectionViewController *collectionViewController = (CollectionViewController *)navigationController.topViewController;
    collectionViewController.checkInData = self.checkinData;
    collectionViewController.delegate = self;
}


-(NSURL*)GetSaveFileUrl{
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSArray *possibleURLs = [defaultFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirURL = [possibleURLs firstObject];
    
    NSURL *saveFileURL = [documentsDirURL URLByAppendingPathComponent:@"checkinData.bin"];
    return saveFileURL;
}


-(void)collectionViewControllerImagesSelected:(CollectionViewController *)vc imagesSelected:(NSArray *)images{
    NSURL *saveFileURL = [self GetSaveFileUrl];
    self.checkinData.pictures = [images mutableCopy];
    
    [NSKeyedArchiver archiveRootObject:self.checkinDataList toFile:[saveFileURL path]];
}

@end
