//
//  Tab1_BottomVC.m
//  TabbarApp
//
//  Created by wos on 13/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "Tab1_BottomVC.h"



#define TABBAR_HEIGHT (49)

@interface Tab1_BottomVC () <UIScrollViewDelegate, UIScrollViewAccessibilityDelegate>
{
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hiddenTab;
    
}
@end

@implementation Tab1_BottomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    hiddenTab = NO;
    //[self.navigationController setNavigationBarHidden:hiddenTab animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    NSLog(@"setTabBarHidden:%d animated:%d", hidden, animated);
    
    if ( [self.view.subviews count] < 2 )
        return;
    
    UIView *contentView;
    
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    
    
    if(hidden)
    {
        if(animated)
        {
            NSLog(@"HIDDEN - ANIMATED");
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 contentView.frame = self.view.bounds;
                                 
                                 self.tabBarController.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }
                             completion:^(BOOL finished) {
                                 contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }];
        }
        else
        {
            NSLog(@"HIDDEN");
            
            contentView.frame = self.view.bounds;
            
            self.tabBarController.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    }
    else
    {
        self.tabBarController.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.size.height,
                                       self.view.bounds.size.width,
                                       0);
        if(animated)
        {
            NSLog(@"NOT HIDDEN - ANIMATED");
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.tabBarController.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height - TABBAR_HEIGHT,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }   completion:^(BOOL finished) {
                                 contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.origin.y,
                                                                self.view.bounds.size.width,
                                                                self.view.bounds.size.height - TABBAR_HEIGHT);
                             }];
        }
        else
        {
            NSLog(@"NOT HIDDEN");
            contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height - TABBAR_HEIGHT);
            
            self.tabBarController.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height - TABBAR_HEIGHT,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    }
}

-(void)expand
{
    if(hiddenTab)
        return;
    
    hiddenTab = YES;
    
    [self setTabBarHidden:YES animated:YES];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)contract
{
    if(!hiddenTab) return;
    hiddenTab = NO;
    
    [self setTabBarHidden:NO animated:YES];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
    
    
    if((differenceFromStart) < 0)
    {
        // scroll up
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self expand];
    }
    else {
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self contract];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self contract];
    return YES;
}

#pragma mark - Button Action Method
- (IBAction)btnBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
