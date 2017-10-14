//
//  Tab4_TopVC.m
//  TabbarApp
//
//  Created by wos on 13/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "Tab4_TopVC.h"
#import "AppDelegate.h"

@interface Tab4_TopVC ()

@end

@implementation Tab4_TopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self manageSwipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SwipeGesture
- (void) manageSwipe
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setAnimation:kCATransitionFromLeft subType:kCATransitionFromLeft duration:0.3 funcation:kCAMediaTimingFunctionEaseInEaseOut view:self.tabBarController.view];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setAnimation:kCATransitionFromRight subType:kCATransitionFromRight duration:0.3 funcation:kCAMediaTimingFunctionEaseInEaseOut view:self.tabBarController.view];
}

@end
