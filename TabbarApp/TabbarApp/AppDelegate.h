//
//  AppDelegate.h
//  TabbarApp
//
//  Created by wos on 11/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController    *tabbar;

- (void)setAnimation:(NSString *)AnimationType subType:(NSString *)AnimationSubType duration:(CFTimeInterval)delaytime funcation:(NSString *)functionName view:(UIView *)viewAnimation;
@end

