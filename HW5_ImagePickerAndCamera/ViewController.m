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
#import "FindLocationViewController.h"
#import "CheckinDataList.h"

@interface ViewController ()<
    UIImagePickerControllerDelegate, UINavigationControllerDelegate, CollectionViewControllerDelegate,
    FindLocationViewControllerDelegate, UITableViewDataSource, UITableViewDelegate
>
@property CheckInData *checkinData;
@property (nonatomic, strong) CheckinDataList *checkinDataList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *saveFileURL = [self GetSaveFileUrl];
    self.checkinDataList = (CheckinDataList *)[NSKeyedUnarchiver unarchiveObjectWithFile:[saveFileURL path]];
    
//    if(self.checkinDataList == nil){
//        self.checkinData = [[CheckInData alloc] init];
//        self.checkinDataList = [[NSMutableArray alloc] init];
//        [self.checkinDataList addObject:self.checkinData];
//    }
//    else
//        self.checkinData = self.checkinDataList[0];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [super prepareForSegue:segue sender:sender];
    
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
//    CollectionViewController *collectionViewController = (CollectionViewController *)navigationController.topViewController;
//    collectionViewController.checkInData = self.checkinData;
//    collectionViewController.delegate = self;
    
    FindLocationViewController *vc = (FindLocationViewController *)navigationController.topViewController;
    vc.delegate = self;
}


-(NSURL*)GetSaveFileUrl{
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSArray *possibleURLs = [defaultFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirURL = [possibleURLs firstObject];
    
    NSURL *saveFileURL = [documentsDirURL URLByAppendingPathComponent:@"checkinListData.bin"];
    return saveFileURL;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checkinDataList itemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellID = @"tableCell";
    CheckInData *checkin = [self.checkinDataList itemAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = checkin.placeName;
    
    return cell;
}


-(void)collectionViewControllerImagesSelected:(CollectionViewController *)vc imagesSelected:(NSArray *)images{
    NSURL *saveFileURL = [self GetSaveFileUrl];
    self.checkinData.pictures = [images mutableCopy];
    
    [NSKeyedArchiver archiveRootObject:self.checkinDataList toFile:[saveFileURL path]];
}

-(void)findLocationViewControllerPlaceSelected:(FindLocationViewController *)vc placeName:(NSString *)name{
    CheckInData *checkin = [[CheckInData alloc] init];
    checkin.placeName  = name;
    if(self.checkinDataList == nil){
        self.checkinDataList = [[CheckinDataList alloc] init];
    }
    [self.checkinDataList addCheckinList:checkin];
    [self.tableView reloadData];
}

@end
