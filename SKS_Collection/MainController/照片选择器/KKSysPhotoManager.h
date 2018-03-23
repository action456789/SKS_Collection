//
//  KKSysCameraManager.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/8/16.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSysPhotoManager;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSysPhotoManagerDelegate <NSObject>

@optional
- (void)sysPhotoManager:(KKSysPhotoManager *)photoManager didCapatureImage:(UIImage *)image;

@end

@interface KKSysPhotoManager : NSObject

@property (nonatomic,weak) id <KKSysPhotoManagerDelegate> delegate;

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, assign, getter=isAllowsEditing) BOOL allowsEditing;

@property (nonatomic, assign, getter=isSaveToPhotosAlbum) BOOL saveToPhotosAlbum;

- (_Nonnull instancetype)initWithParentVC:(UIViewController *)parent;

// 选择进入相册/拍照选择照片
- (void)gotoChoosePhotoAlertController;

- (void)gotoCamera;

- (void)gotoPhotoLibrary;

@end

NS_ASSUME_NONNULL_END
