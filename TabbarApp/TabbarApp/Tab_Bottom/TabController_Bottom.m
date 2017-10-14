//
//  TabController_Bottom.m
//  TabbarApp
//
//  Created by wos on 13/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "TabController_Bottom.h"

@interface TabController_Bottom ()

@end

@implementation TabController_Bottom

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
    
    //------------------------------------------------>
    // Remove the titles and adjust the inset to account for missing title
    for(UITabBarItem * tabBarItem in self.tabBar.items){
        
        NSString *strTitle = tabBarItem.title;
        if (strTitle.length == 0) {
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        tabBarItem.title = tabBarItem.title;
        
        //Set Fefault Selected Image | Remove Default Tin Color
        tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.selectedImage = [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //Title Color
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                                             UITextAttributeFont : [UIFont fontWithName:@"Helvetica Neue" size:10.0] }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],
                                                             UITextAttributeFont : [UIFont fontWithName:@"Helvetica-Bold" size:12.0] }
                                                 forState:UIControlStateSelected];
    }
    
    //------------------------------------------------>
    // Set Image in Top shadow line
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.150f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tabBarController.tabBar.autoresizesSubviews = NO;
        self.tabBarController.tabBar.clipsToBounds = YES;
        
        UIImage* tabBarBackground = [[UIImage alloc] init];
        //tabBarBackground = [UIImage imageNamed:@"tabBG"];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    });
    */
}


@end
