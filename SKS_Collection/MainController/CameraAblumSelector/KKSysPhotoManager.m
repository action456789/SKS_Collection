//
//  KKSysCameraManager.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/8/16.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKSysPhotoManager.h"
#import <Photos/Photos.h>
#import "KKAuthorizationManager.h"
#import "UIAlertController+KS.h"

@interface KKSysPhotoManager()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation KKSysPhotoManager

- (instancetype)initWithParentVC:(UIViewController *)parent {
    self = [super init];
    if (self) {
        _parentVC = parent;
        _allowsEditing = YES;
        _saveToPhotosAlbum = NO;
    }
    return self;
}

// 选择照片
- (void)gotoChoosePhotoAlertController {
    if (self.parentVC == nil) {
        NSLog(@"【KKSysPhotoManager】: parentVC cannot be nil");
        return;
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoCamera];
    }];
    
    UIAlertAction *actionPhotoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoPhotoLibrary];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionCamera];
    [alertVC addAction:actionPhotoLibrary];
    [alertVC addAction:actionCancel];
    
    [self.parentVC presentViewController:alertVC animated:YES completion:nil];
}

// 进入相机
- (void)gotoCamera {
    if (self.parentVC == nil) {
        NSLog(@"【KKSysPhotoManager】: parentVC cannot be nil");
        return;
    }
    
    if ([KKAuthorizationManager isCameraPermissionGranted]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        imagePicker.allowsEditing = self.isAllowsEditing;
        
        [self.parentVC presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [UIAlertController kk_showMessage:@"没有相机访问权限，请前往系统设置页面开启。" fromViewControler:self.parentVC];
    }
}

// 进入相册
- (void)gotoPhotoLibrary {
    if (self.parentVC == nil) {
        NSLog(@"【KKSysPhotoManager】: parentVC cannot be nil");
        return;
    }
    
    if ([KKAuthorizationManager isAssetsLibraryPermissionGranted]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.allowsEditing = self.isAllowsEditing;
        
        [self.parentVC presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [UIAlertController kk_showMessage:@"没有相册访问权限，请前往系统设置页面开启。" fromViewControler:self.parentVC];
    }
}

#pragma mark - UIImagePickerControllerDelegate, UINavigationControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = nil;
    if (self.isAllowsEditing) {
        image = (UIImage *)info[@"UIImagePickerControllerEditedImage"];
    } else {
        image = (UIImage *)info[@"UIImagePickerControllerOriginalImage"];
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (self.isSaveToPhotosAlbum) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
    } else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(sysPhotoManager:didCapatureImage:)]) {
        [self.delegate sysPhotoManager:self didCapatureImage:image];
    }
}

@end
