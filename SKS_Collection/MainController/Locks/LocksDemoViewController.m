//
//  LocksDemoViewController.m
//  SKS_Collection
//
//  Created by KeSen on 2016/11/3.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "LocksDemoViewController.h"

#import <pthread.h>

@interface LocksDemoViewController ()

@end

@implementation LocksDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1. NSLock
    // [self test_NSLock];
    
    // 2. @synchronized(obj)
    // [self test_synchronized];
    
    // 3. pthread_mutex_t
    // [self test_pthread_mutex_t];
    
    // 4. 使用信号量
    [self test_dispatch_semaphore_t_0];
}

//TODO

- (void)test_locks_perfemence
{
    
}

- (void)test_OSSpinLock
{
    
}

- (void)test_dispatch_semaphore_t_1
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self method1];
        sleep(10);
        dispatch_semaphore_signal(semaphore);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self method2];
        dispatch_semaphore_signal(semaphore);
    });
}

// 信号量的来控制多线程中代码执行顺序
- (void)test_dispatch_semaphore_t_0
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self method1];
        sleep(10);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self method2];
}

- (void)test_pthread_mutex_t
{
    __block pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, NULL);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        [self method1];
        sleep(5);
        pthread_mutex_unlock(&mutex);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&mutex);
        [self method2];
        pthread_mutex_unlock(&mutex);
    });
}

- (void)test_synchronized
{
    // @synchronized指令使用的obj为该锁的唯一标识，只有当标识相同时，才为满足互斥，
    // 如果线程2中的@synchronized(obj)改为@synchronized(other),刚线程2就不会被阻塞
    // 优点
    // 1. 不需要在代码中显式的创建锁对象
    // 2. @synchronized 块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self){
            [self method1];
            sleep(10);
        }
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(self){
            [self method2];
        }
    });
}

- (void)test_NSLock
{
    //主线程中
    NSLock *lock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        [self method1];
        sleep(10);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [lock lock];
        [self method2];
        [lock unlock];
    });
}

- (void)method1
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)method2
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


@end
