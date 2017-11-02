//
//  TabController.m
//  TabbarApp
//
//  Created by wos on 11/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "TabController.h"

@interface TabController ()

@end

@implementation TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self viewWillLayoutSubviews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.tabBar invalidateIntrinsicContentSize];
    
    CGFloat tabSize = 44.0;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        tabSize = 32.0;
    }
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = tabSize;
    tabFrame.origin.y = self.view.frame.origin.y;
    tabFrame.origin.y = 70;
    //tabFrame.origin.y = 88;
    self.tabBar.frame = tabFrame;
    
    // Set the translucent property to NO then back to YES to
    // force the UITabBar to reblur, otherwise part of the
    // new frame will be completely transparent if we rotate
    // from a landscape orientation to a portrait orientation.
    self.tabBar.translucent = NO;
    self.tabBar.translucent = YES;
    
    //------------------------------------------------>
    // Remove the titles and adjust the inset to account for missing title
    for(UITabBarItem * tabBarItem in self.tabBar.items){
        tabBarItem.title = @"Todays Selection";
        //tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
        [tabBarItem setTitleTextAttributes:@{ [UIFont fontWithName:@"HELVETICA-BOLD" size:10.0f] : NSFontAttributeName,
                                              NSForegroundColorAttributeName : [UIColor redColor] }
                                  forState:UIControlStateNormal];
        
        [tabBarItem setTitleTextAttributes:@{ [UIFont fontWithName:@"HELVETICA-BOLD" size:10.0f] : NSFontAttributeName,
                                              NSForegroundColorAttributeName : [UIColor blackColor] }
                                  forState:UIControlStateSelected];
        
        //Set Fefault Selected Image | Remove Default Tin Color
        tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.selectedImage = [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    //------------------------------------------------>
    //set Tabbar BG Color
    self.tabBar.backgroundColor = [UIColor yellowColor];
    
    //------------------------------------------------>
    // Remove top shadow gradient line
    //[[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    //
    // OR
    //
    // Set Image in Top shadow line
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.150f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage* tabBarBackground = [[UIImage alloc] init];
        //tabBarBackground = [UIImage imageNamed:@"tabbarBG"];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    });
}

#pragma mark - Delegate method
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"didSelectItem: %@", item);
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"didSelectViewController: %@", tabBarController);
}
@end


