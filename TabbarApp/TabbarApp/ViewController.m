//
//  ViewController.m
//  TabbarApp
//
//  Created by wos on 11/10/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "ViewController.h"
#import "TabController.h"
#import "TabController_Bottom.h"


#define loadViewController(storybord, identifier)   [[UIStoryboard storyboardWithName:storybord bundle: nil] instantiateViewControllerWithIdentifier:identifier]

#define _keyTitle                               @"Title"
#define _keySubTitle                            @"SubTitle"

#define Title_TopTabbar                         @"Top Tabbar"
#define Title_BottomTabbar                      @"Bottom Tabbar"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
     NSMutableArray *arrTableList;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //------------------------>
    arrTableList = [[NSMutableArray alloc] init];
    
    //------------------------>
    tblHome.delegate = self;
    tblHome.dataSource = self;
    tblHome.estimatedRowHeight = UITableViewAutomaticDimension;
    tblHome.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //tblHome.backgroundColor = Color_PopupBG;
    //tblHome.layer.cornerRadius = 5;
    tblHome.layer.masksToBounds = YES;
    
    //------------------------>
    NSString *strTitle = @"";
    NSString *strSubTitle = @"";
    
    strTitle = Title_TopTabbar;
    strSubTitle = @"Set top poxsition of tabbar. Swipe to change tapbar tab change in fade animation.";
    strSubTitle = @"";
    [self addObjectInTableList_Title:strTitle SubTitle:strSubTitle];
    
    strTitle = Title_BottomTabbar;
    [self addObjectInTableList_Title:strTitle SubTitle:strSubTitle];
    
    [tblHome reloadData];
    
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.30f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tableView:tblHome didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    });
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (void) addObjectInTableList_Title:(NSString *)strTitle SubTitle:(NSString *)strSubTitle
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:strTitle forKey:_keyTitle];
    [dic setValue:strSubTitle forKey:_keySubTitle];
    
    [arrTableList addObject:dic];
}

- (void) showAlertMessage:(NSString *)strMess autoHide:(BOOL)autoHide {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strMess message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //Auto Dismiss
    if (autoHide == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:^{ //Set Completion Code
            }];
        });
    }
    else {
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                    {
                                        //Set Completion Code
                                    }]];
    }
    //Show Alert
    //[view presentViewController:alertController animated:YES completion:nil]; //set VC object for show alert
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Tableview Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int noOfRow = 0;
    noOfRow = (int)arrTableList.count;
    //noOfRow = 0;
    
    if (noOfRow == 0) {
        //NSString *Mess = [MESS_NoDataFound uppercaseString];
        //[Function setPlaceholder_OnTableView:tblLocation PlaceHolderText:Mess image:nil];
    }
    else {
        //tableView.backgroundView = [[UIView alloc] init];
    }
    return noOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *strTitle = @"";
    NSString *strSubTitle = @"";
    
    if (arrTableList.count == 0) {
        return cell;
    }
    
    dic = [arrTableList objectAtIndex:indexPath.row];
    strTitle = [dic valueForKey:_keyTitle];
    strSubTitle = [dic valueForKey:_keySubTitle];;
    
    cell.textLabel.text = strTitle;
    cell.textLabel.numberOfLines = 0;
    /*
    cell.detailTextLabel.text = strSubTitle;
    cell.detailTextLabel.numberOfLines = 0;
    */
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    tableView.separatorColor = [UIColor grayColor];
    
    [self.view layoutIfNeeded];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic = [arrTableList objectAtIndex:indexPath.row];
    
    NSString *strTitle = @"";
    strTitle = [dic valueForKey:_keyTitle];
    strTitle  = [strTitle uppercaseString];
    
    if ([strTitle isEqualToString:[Title_TopTabbar uppercaseString]])
    {
        TabController *objVC = loadViewController(@"Main", @"TabController");
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else if ([strTitle isEqualToString:[Title_BottomTabbar uppercaseString]])
    {
        TabController_Bottom *objVC = loadViewController(@"Main", @"TabController_Bottom");
        [self.navigationController pushViewController:objVC animated:YES];
    }
    else {
        [self showAlertMessage:@"Something Was Wrong" autoHide:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
