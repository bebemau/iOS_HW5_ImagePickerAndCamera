//
//  ViewController.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/13/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [super prepareForSegue:segue sender:sender];
    
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    CollectionViewController *collectionViewController = (CollectionViewController *)navigationController.topViewController;
    
}

@end
