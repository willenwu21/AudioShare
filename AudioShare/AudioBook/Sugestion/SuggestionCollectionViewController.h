//
//  SuggestionCollectionViewController.h
//  AudioShare
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 DLZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionCollectionViewController : UICollectionViewController
@property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSString *categoryName;
@property (nonatomic, copy)NSString *apiString;
@end
