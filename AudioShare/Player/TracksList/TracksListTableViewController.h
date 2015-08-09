//
//  TracksListTableViewController.h
//  AudioShare
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 DLZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TracksListTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray *trackList;
@property (nonatomic, copy)NSString *albumId;
@property (nonatomic, assign)NSUInteger currentIndex;
@end
