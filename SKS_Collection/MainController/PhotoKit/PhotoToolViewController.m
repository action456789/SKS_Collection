//
//  PhotoToolViewController.m
//  SKS_Collection
//
//  Created by KeSen on 26/09/2016.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "PhotoToolViewController.h"
#import "KSPhotoTool.h"

@interface PhotoToolViewController ()

@end

@implementation PhotoToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    NSLog(@"openGallery_authorStatus == %ld",(long)authorStatus);
    if (authorStatus == PHAuthorizationStatusAuthorized){
        //获取权限
    }
}

@end
