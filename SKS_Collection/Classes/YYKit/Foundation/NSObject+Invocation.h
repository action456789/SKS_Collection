//
//  NSObject+Invocation.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Invocation)

#pragma mark - Sending messages with variable parameters
///=============================================================================
/// @name Sending messages with variable parameters
///=============================================================================

/**
 Sends a specified message to the receiver and returns the result of the message.
 
 @param sel    A selector identifying the message to send. If the selector is
 NULL or unrecognized, an NSInvalidArgumentException is raised.
 
 @param ...    Variable parameter list. Parameters type must correspond to the
 selector's method declaration, or unexpected results may occur.
 It doesn't support union or struct which is larger than 256 bytes.
 
 @return       An object that is the result of the message.
 
 @discussion   The selector's return value will be wrap as NSNumber or NSValue
 if the selector's `return type` is not object. It always returns nil
 if the selector's `return type` is void.
 
 Sample Code:
 
 // no variable args
 [view performSelectorWithArgs:@selector(removeFromSuperView)];
 
 // variable arg is not object
 [view performSelectorWithArgs:@selector(setCenter:), CGPointMake(0, 0)];
 
 // perform and return object
 UIImage *image = [UIImage.class performSelectorWithArgs:@selector(imageWithData:scale:), data, 2.0];
 
 // perform and return wrapped number
 NSNumber *lengthValue = [@"hello" performSelectorWithArgs:@selector(length)];
 NSUInteger length = lengthValue.unsignedIntegerValue;
 
 // perform and return wrapped struct
 NSValue *frameValue = [view performSelectorWithArgs:@selector(frame)];
 CGRect frame = frameValue.CGRectValue;
 */
- (nullable id)kk_performSelectorWithArgs:(SEL _Nullable )sel, ...;

/**
 Invokes a method of the receiver on the current thread using the default mode after a delay.
 
 @warning      It can't cancelled by previous request.
 
 @param sel    A selector identifying the message to send. If the selector is
 NULL or unrecognized, an NSInvalidArgumentException is raised immediately.
 
 @param delay  The minimum time before which the message is sent. Specifying
 a delay of 0 does not necessarily cause the selector to be
 performed immediately. The selector is still queued on the
 thread's run loop and performed as soon as possible.
 
 @param ...    Variable parameter list. Parameters type must correspond to the
 selector's method declaration, or unexpected results may occur.
 It doesn't support union or struct which is larger than 256 bytes.
 
 Sample Code:
 
 // no variable args
 [view performSelectorWithArgs:@selector(removeFromSuperView) afterDelay:2.0];
 
 // variable arg is not object
 [view performSelectorWithArgs:@selector(setCenter:), afterDelay:0, CGPointMake(0, 0)];
 */
- (void)kk_performSelectorWithArgs:(SEL _Nullable )sel afterDelay:(NSTimeInterval)delay, ...;

/**
 Invokes a method of the receiver on the main thread using the default mode.
 
 @param sel    A selector identifying the message to send. If the selector is
 NULL or unrecognized, an NSInvalidArgumentException is raised.
 
 @param wait   A Boolean that specifies whether the current thread blocks until
 after the specified selector is performed on the receiver on the
 specified thread. Specify YES to block this thread; otherwise,
 specify NO to have this method return immediately.
 
 @param ...    Variable parameter list. Parameters type must correspond to the
 selector's method declaration, or unexpected results may occur.
 It doesn't support union or struct which is larger than 256 bytes.
 
 @return       While @a wait is YES, it returns object that is the result of
 the message. Otherwise return nil;
 
 @discussion   The selector's return value will be wrap as NSNumber or NSValue
 if the selector's `return type` is not object. It always returns nil
 if the selector's `return type` is void, or @a wait is YES.
 
 Sample Code:
 
 // no variable args
 [view performSelectorWithArgsOnMainThread:@selector(removeFromSuperView), waitUntilDone:NO];
 
 // variable arg is not object
 [view performSelectorWithArgsOnMainThread:@selector(setCenter:), waitUntilDone:NO, CGPointMake(0, 0)];
 */
- (nullable id)kk_performSelectorWithArgsOnMainThread:(SEL _Nullable )sel waitUntilDone:(BOOL)wait, ...;

/**
 Invokes a method of the receiver on the specified thread using the default mode.
 
 @param sel    A selector identifying the message to send. If the selector is
 NULL or unrecognized, an NSInvalidArgumentException is raised.
 
 @param thread The thread on which to execute aSelector.
 
 @param wait   A Boolean that specifies whether the current thread blocks until
 after the specified selector is performed on the receiver on the
 specified thread. Specify YES to block this thread; otherwise,
 specify NO to have this method return immediately.
 
 @param ...    Variable parameter list. Parameters type must correspond to the
 selector's method declaration, or unexpected results may occur.
 It doesn't support union or struct which is larger than 256 bytes.
 
 @return       While @a wait is YES, it returns object that is the result of
 the message. Otherwise return nil;
 
 @discussion   The selector's return value will be wrap as NSNumber or NSValue
 if the selector's `return type` is not object. It always returns nil
 if the selector's `return type` is void, or @a wait is YES.
 
 Sample Code:
 
 [view performSelectorWithArgs:@selector(removeFromSuperView) onThread:mainThread waitUntilDone:NO];
 
 [array  performSelectorWithArgs:@selector(sortUsingComparator:)
 onThread:backgroundThread
 waitUntilDone:NO, ^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
 return [num2 compare:num2];
 }];
 */
- (nullable id)kk_performSelectorWithArgs:(SEL _Nullable )sel onThread:(NSThread *_Nullable)thread waitUntilDone:(BOOL)wait, ...;

/**
 Invokes a method of the receiver on a new background thread.
 
 @param sel    A selector identifying the message to send. If the selector is
 NULL or unrecognized, an NSInvalidArgumentException is raised.
 
 @param ...    Variable parameter list. Parameters type must correspond to the
 selector's method declaration, or unexpected results may occur.
 It doesn't support union or struct which is larger than 256 bytes.
 
 @discussion   This method creates a new thread in your application, putting
 your application into multithreaded mode if it was not already.
 The method represented by sel must set up the thread environment
 just as you would for any other new thread in your program.
 
 Sample Code:
 
 [array  performSelectorWithArgsInBackground:@selector(sortUsingComparator:),
 ^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
 return [num2 compare:num2];
 }];
 */
- (void)kk_performSelectorWithArgsInBackground:(SEL _Nullable )sel, ...;

@end
