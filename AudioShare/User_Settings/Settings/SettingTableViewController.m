//
//  SettingTableViewController.m
//  AudioShare
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 DLZ. All rights reserved.
//

#import "SettingTableViewController.h"
#import "DataBaseHandle.h"
#import "Reachability.h"
#import "TimerViewController.h"

@interface SettingTableViewController () <UIAlertViewDelegate>



@property (nonatomic, strong)NSArray *dataArray;

//
@property (nonatomic, strong)UISwitch *mySwitch;


@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"设置";
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingCell"];
    
    self.dataArray = @[@"定时关闭", @"是否在2G/3G/4G网络下播放", @"清除缓存"];
    
    self.mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 60 , 50, 0, 0)];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"switchOn"]) {
        [_mySwitch setOn:YES];
    } else {
        [_mySwitch setOn:NO];
    }
    
    
    [_mySwitch addTarget:self action:@selector(mySwitchAction :) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:_mySwitch];
    
}

//UISwitch事件
-(void)mySwitchAction : (UISwitch *)sender
{
    //判断mySwitch状态
    BOOL isSwitchOn = [_mySwitch isOn];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (isSwitchOn) {
        [ud setBool:YES forKey:@"switchOn"];
        NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
        if (status != NotReachable) {
            [ud setBool:YES forKey:@"networkOK"];
        } else {
            [ud setBool:NO forKey:@"networkOK"];
        }
        
        DLog(@"允许在数据网络下播放, %d", [ud boolForKey:@"switchOn"]);
    } else {
        [ud setBool:NO forKey:@"switchOn"];
        [ud setBool:NO forKey:@"networkOK"];
        DLog(@"关闭在数据网络下播放, %d", [ud boolForKey:@"switchOn"]);
    }
    [ud synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    
    
    
    //cell.textLabel.text = @"测试";
    
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    
    if (indexPath.row != 1) {
        
        //cell小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 2) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
        DLog(@"清除缓存");
    } else if (indexPath.row == 0) {
        
        TimerViewController *timerVC = [[TimerViewController alloc] init];
        timerVC.isModal = NO;
        
        [self.navigationController pushViewController:timerVC animated:YES];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *cachePath = [[DataBaseHandle shareDataBase] getPathOf:Cache];
        NSString *filePath = [cachePath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}
//确定cell高度
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
