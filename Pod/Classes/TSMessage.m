//
//  TSMessage.m
//  Felix Krause
//
//  Created by Felix Krause on 24.08.12.
//  Copyright (c) 2012 Felix Krause. All rights reserved.
//

#import "TSMessage.h"
#import "TSMessageView.h"
#import "TSMessageView+Private.h"

#define kTSMessageDisplayTime 1.5
#define kTSMessageAnimationDuration 0.3
#define kTSMessageExtraDisplayTimePerPixel 0.04
#define kTSDesignFileName @"TSMessagesDefaultDesign.json"

@interface TSMessage ()
@property (nonatomic, strong) NSMutableArray *messages;
<<<<<<< HEAD:Pod/Classes/TSMessage.m

@end

@implementation TSMessage
static TSMessage *sharedMessage;
static BOOL notificationActive;

static BOOL _useiOS7Style;

=======
@end

@implementation TSMessage
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m

__weak static UIViewController *_defaultViewController;

+ (TSMessage *)sharedMessage
{
    static TSMessage *sharedMessage = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMessage = [[[self class] alloc] init];
    });
    
    return sharedMessage;
}

- (id)init
{
    if ((self = [super init]))
    {
        _messages = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - Setup messages

+ (TSMessageView *)messageWithTitle:(NSString *)title subtitle:(NSString *)subtitle type:(TSMessageType)type
{
    return [self messageWithTitle:title subtitle:subtitle image:nil type:type inViewController:self.defaultViewController];
}

+ (TSMessageView *)messageWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image type:(TSMessageType)type inViewController:(UIViewController *)viewController
{
    TSMessageView *view = [[TSMessageView alloc] initWithTitle:title subtitle:subtitle image:image type:type];
    
    view.viewController = viewController;
    
    return view;
}

<<<<<<< HEAD:Pod/Classes/TSMessage.m
+ (void)showEndlessNotificationWithTitle:(NSString *)title
									 type:(TSMessageNotificationType)type
{
	[self showEndlessNotificationInViewController:[self defaultViewController]
												   title:title
												subtitle:nil
													 tag:-1
													type:type];
}

+ (void)showNotificationWithTitle:(NSString *)title
                         subtitle:(NSString *)subtitle
                             type:(TSMessageNotificationType)type
=======
#pragma mark - Setup messages and display them right away

+ (TSMessageView *)displayMessageWithTitle:(NSString *)title subtitle:(NSString *)subtitle type:(TSMessageType)type
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
{
    return [self displayMessageWithTitle:title subtitle:subtitle image:nil type:type inViewController:self.defaultViewController];
}

<<<<<<< HEAD:Pod/Classes/TSMessage.m
+(void)showEndlessNotification:(NSString *)title
										subtitle:(NSString *)subtitle
											type:(TSMessageNotificationType)type
{
	[self showEndlessNotificationInViewController:[self defaultViewController]
												   title:title
												subtitle:subtitle
													 tag:-1
													type:type];
}

+ (void)showEndlessNotificationWithTag:(NSString *)title
						 subtitle:(NSString *)subtitle
							 type:(TSMessageNotificationType)type
							  tag:(NSInteger)tag
{
	[self showEndlessNotificationInViewController:[self defaultViewController]
									 title:title
								  subtitle:subtitle
									   tag:tag
									  type:type];
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type
                                duration:(NSTimeInterval)duration
{
    [self showNotificationInViewController:viewController
                                     title:title
                                  subtitle:subtitle
                                     image:nil
                                      type:type
                                  duration:duration
                                  callback:nil
                               buttonTitle:nil
                            buttonCallback:nil
                                atPosition:TSMessageNotificationPositionTop
                       canBeDismissedByUser:YES];
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type
                                duration:(NSTimeInterval)duration
                     canBeDismissedByUser:(BOOL)dismissingEnabled
{
    [self showNotificationInViewController:viewController
                                     title:title
                                  subtitle:subtitle
                                     image:nil
                                      type:type
                                  duration:duration
                                  callback:nil
                               buttonTitle:nil
                            buttonCallback:nil
                                atPosition:TSMessageNotificationPositionTop
                       canBeDismissedByUser:dismissingEnabled];
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type
{
    [self showNotificationInViewController:viewController
                                     title:title
                                  subtitle:subtitle
                                     image:nil
                                      type:type
                                  duration:TSMessageNotificationDurationAutomatic
                                  callback:nil
                               buttonTitle:nil
                            buttonCallback:nil
                                atPosition:TSMessageNotificationPositionTop
                      canBeDismissedByUser:YES];
}


+ (TSMessageView*)showEndlessNotificationInViewController:(UIViewController *)viewController
													title:(NSString *)title
												 subtitle:(NSString *)subtitle
													 type:(TSMessageNotificationType)type
{
	return [TSMessage showEndlessNotificationInViewController:viewController title:title subtitle:subtitle tag:-1 type:type];
}


+ (TSMessageView*)showEndlessNotificationInViewController:(UIViewController *)viewController
								   title:(NSString *)title
								subtitle:(NSString *)subtitle
								tag:(NSInteger)tag
									type:(TSMessageNotificationType)type
{
	return [TSMessage showNotificationWithTagInViewController:viewController
									 title:title
								  subtitle:subtitle
									   tag:tag
									 image:nil
									  type:type
								  duration:TSMessageNotificationDurationEndless
								  callback:nil
							   buttonTitle:nil
							buttonCallback:nil
								atPosition:TSMessageNotificationPositionTop
					  canBeDismissedByUser:YES];
	
}

+ (TSMessageView*)showNotificationWithTagInViewController:(UIViewController *)viewController
											 title:(NSString *)title
										  subtitle:(NSString *)subtitle
										  tag:(NSInteger)tag
											 image:(UIImage *)image
											  type:(TSMessageNotificationType)type
										  duration:(NSTimeInterval)duration
										  callback:(void (^)())callback
									   buttonTitle:(NSString *)buttonTitle
									buttonCallback:(void (^)())buttonCallback
										atPosition:(TSMessageNotificationPosition)messagePosition
							  canBeDismissedByUser:(BOOL)dismissingEnabled
{
	// Create the TSMessageView
	TSMessageView *v = [[TSMessageView alloc] initWithTag:title
												   subtitle:subtitle
														tag:tag
													  image:image
													   type:type
												   duration:duration
										   inViewController:viewController
												   callback:callback
												buttonTitle:buttonTitle
											 buttonCallback:buttonCallback
												 atPosition:messagePosition
									   canBeDismissedByUser:dismissingEnabled];
	[self prepareNotificationToBeShown:v];
	
	return v;
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
								   title:(NSString *)title
								subtitle:(NSString *)subtitle
								   image:(UIImage *)image
									type:(TSMessageNotificationType)type
								duration:(NSTimeInterval)duration
								callback:(void (^)())callback
							 buttonTitle:(NSString *)buttonTitle
						  buttonCallback:(void (^)())buttonCallback
							  atPosition:(TSMessageNotificationPosition)messagePosition
					canBeDismissedByUser:(BOOL)dismissingEnabled
{
	// Create the TSMessageView
	TSMessageView *v = [[TSMessageView alloc] initWithTitle:title
												   subtitle:subtitle
													  image:image
													   type:type
												   duration:duration
										   inViewController:viewController
												   callback:callback
												buttonTitle:buttonTitle
											 buttonCallback:buttonCallback
												 atPosition:messagePosition
									   canBeDismissedByUser:dismissingEnabled];
	[self prepareNotificationToBeShown:v];
=======
+ (TSMessageView *)displayMessageWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image type:(TSMessageType)type inViewController:(UIViewController *)viewController
{
    TSMessageView *view = [self messageWithTitle:title subtitle:subtitle image:image type:type inViewController:viewController];
    
    [self displayOrEnqueueMessage:view];
    
    return view;
}

#pragma mark - Displaying messages

+ (void)displayPermanentMessage:(TSMessageView *)messageView
{
    [[TSMessage sharedMessage] displayMessage:messageView];
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
}

+ (void)displayOrEnqueueMessage:(TSMessageView *)messageView
{
    NSString *title = messageView.title;
    NSString *subtitle = messageView.subtitle;
<<<<<<< HEAD:Pod/Classes/TSMessage.m
	
=======

>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
    for (TSMessageView *n in [TSMessage sharedMessage].messages)
    {
        // avoid displaying the same messages twice in a row
        BOOL equalTitle = ([n.title isEqualToString:title] || (!n.title && !title));
        BOOL equalSubtitle = ([n.subtitle isEqualToString:subtitle] || (!n.subtitle && !subtitle));
        
        if (equalTitle && equalSubtitle) return;
    }
<<<<<<< HEAD:Pod/Classes/TSMessage.m
	
    [[TSMessage sharedMessage].messages addObject:messageView];
	
    if (!notificationActive)
=======
    
    BOOL isDisplayable = !self.isDisplayingMessage;

    [[TSMessage sharedMessage].messages addObject:messageView];

    if (isDisplayable)
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
    {
        [[TSMessage sharedMessage] displayCurrentMessage];
    }
}

+ (BOOL)dismissCurrentMessageForce:(BOOL)force
{
    TSMessageView *currentMessage = [TSMessage sharedMessage].currentMessage;
    
    if (!currentMessage) return NO;
    if (!currentMessage.isMessageFullyDisplayed && !force) return NO;
    
    [[TSMessage sharedMessage] dismissCurrentMessage];
    
    return YES;
}

+ (BOOL)dismissCurrentMessage
{
    return [self dismissCurrentMessageForce:NO];
}

+ (BOOL)isDisplayingMessage
{
    return !![TSMessage sharedMessage].currentMessage;
}

#pragma mark - Customizing design

+ (void)addCustomDesignFromFileWithName:(NSString *)fileName
{
    NSError *error = nil;
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *design = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
<<<<<<< HEAD:Pod/Classes/TSMessage.m
    void (^addStatusBarHeightToVerticalOffset)() = ^void() {
        
        if (currentView.messagePosition == TSMessageNotificationPositionNavBarOverlay){
            return;
        }
        
        CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
        verticalOffset += MIN(statusBarSize.width, statusBarSize.height);
    };
    
    if ([currentView.viewController isKindOfClass:[UINavigationController class]] || [currentView.viewController.parentViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *currentNavigationController;
        
        if([currentView.viewController isKindOfClass:[UINavigationController class]])
            currentNavigationController = (UINavigationController *)currentView.viewController;
        else
            currentNavigationController = (UINavigationController *)currentView.viewController.parentViewController;
        
        BOOL isViewIsUnderStatusBar = [[[currentNavigationController childViewControllers] firstObject] wantsFullScreenLayout];
        if (!isViewIsUnderStatusBar && currentNavigationController.parentViewController == nil) {
            isViewIsUnderStatusBar = ![TSMessage isNavigationBarInNavigationControllerHidden:currentNavigationController]; // strange but true
        }
        if (![TSMessage isNavigationBarInNavigationControllerHidden:currentNavigationController] && currentView.messagePosition != TSMessageNotificationPositionNavBarOverlay)
        {
            [currentNavigationController.view insertSubview:currentView
                                               belowSubview:[currentNavigationController navigationBar]];
            verticalOffset = [currentNavigationController navigationBar].bounds.size.height;
            if ([TSMessage iOS7StyleEnabled] || isViewIsUnderStatusBar) {
                addStatusBarHeightToVerticalOffset();
            }
        }
        else
        {
            [currentView.viewController.view addSubview:currentView];
            if ([TSMessage iOS7StyleEnabled] || isViewIsUnderStatusBar) {
                addStatusBarHeightToVerticalOffset();
            }
        }
    }
    else
    {
        [currentView.viewController.view addSubview:currentView];
        if ([TSMessage iOS7StyleEnabled]) {
            addStatusBarHeightToVerticalOffset();
        }
    }
    
    CGPoint toPoint;
    if (currentView.messagePosition != TSMessageNotificationPositionBottom)
    {
        CGFloat navigationbarBottomOfViewController = 0;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(messageLocationOfMessageView:)])
        {
            navigationbarBottomOfViewController = [self.delegate messageLocationOfMessageView:currentView];
        }
        
        toPoint = CGPointMake(currentView.center.x,
                              navigationbarBottomOfViewController + verticalOffset + CGRectGetHeight(currentView.frame) / 2.0);
    }
    else
    {
        CGFloat y = currentView.viewController.view.bounds.size.height - CGRectGetHeight(currentView.frame) / 2.0;
        if (!currentView.viewController.navigationController.isToolbarHidden)
        {
            y -= CGRectGetHeight(currentView.viewController.navigationController.toolbar.bounds);
        }
        toPoint = CGPointMake(currentView.center.x, y);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customizeMessageView:)])
    {
        [self.delegate customizeMessageView:currentView];
    }
    
    
    
    dispatch_block_t animationBlock = ^{
        currentView.center = toPoint;
        if (![TSMessage iOS7StyleEnabled]) {
            currentView.alpha = TSMessageViewAlpha;
        }
    };
    void(^completionBlock)(BOOL) = ^(BOOL finished) {
        currentView.messageIsFullyDisplayed = YES;
    };
    
    if (![TSMessage iOS7StyleEnabled]) {
        [UIView animateWithDuration:kTSMessageAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:animationBlock
                         completion:completionBlock];
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        [UIView animateWithDuration:kTSMessageAnimationDuration + 0.1
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:animationBlock
                         completion:completionBlock];
#endif
    }
    
    if (currentView.duration == TSMessageNotificationDurationAutomatic)
    {
        currentView.duration = kTSMessageAnimationDuration + kTSMessageDisplayTime + currentView.frame.size.height * kTSMessageExtraDisplayTimePerPixel;
    }
=======
    [self.design addEntriesFromDictionary:design];
}

+ (NSMutableDictionary *)design
{
    static NSMutableDictionary *design = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kTSDesignFileName];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        design = [NSMutableDictionary dictionaryWithDictionary:config];
    });
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
    
    return design;
}

<<<<<<< HEAD:Pod/Classes/TSMessage.m
+ (BOOL)isNavigationBarInNavigationControllerHidden:(UINavigationController *)navController
{
    if([navController isNavigationBarHidden]) {
        return YES;
    } else if ([[navController navigationBar] isHidden]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)fadeOutNotification:(TSMessageView *)currentView
{
    [self fadeOutNotification:currentView animationFinishedBlock:nil];
}

- (void)fadeOutNotification:(TSMessageView *)currentView animationFinishedBlock:(void (^)())animationFinished
{
    currentView.messageIsFullyDisplayed = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(fadeOutNotification:)
                                               object:currentView];
    
    CGPoint fadeOutToPoint;
    if (currentView.messagePosition != TSMessageNotificationPositionBottom)
=======
#pragma mark - Default view controller

+ (UIViewController *)defaultViewController
{
    __strong UIViewController *defaultViewController = _defaultViewController;
    
    if (!defaultViewController)
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
    {
        NSLog(@"TSMessages: It is recommended to set a custom defaultViewController that is used to display the messages");
        defaultViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
<<<<<<< HEAD:Pod/Classes/TSMessage.m
    [UIView animateWithDuration:kTSMessageAnimationDuration animations:^
     {
         currentView.center = fadeOutToPoint;
         if (![TSMessage iOS7StyleEnabled]) {
             currentView.alpha = 0.f;
         }
     } completion:^(BOOL finished)
     {
         [currentView removeFromSuperview];
         
         if ([self.messages count] > 0)
         {
             [self.messages removeObjectAtIndex:0];
         }
         
         notificationActive = NO;
         
         if ([self.messages count] > 0)
         {
             [self fadeInCurrentNotification];
         }
         
         if(animationFinished) {
             animationFinished();
         }
     }];
}

+ (void)dismissNotificationsWithTag:(NSInteger)tag
{
	NSArray *messages = [TSMessage queuedMessages];
	
	for(TSMessageView *messageView in messages)
	{
		if(messageView.tag == tag)
		{
			[[TSMessage sharedMessage] fadeOutNotification:messageView];
		}
	}
}

+ (BOOL)dismissActiveNotification
{
    return [self dismissActiveNotificationWithCompletion:nil];
}

+ (BOOL)dismissActiveNotificationWithCompletion:(void (^)())completion
{
    if ([[TSMessage sharedMessage].messages count] == 0) return NO;
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       if ([[TSMessage sharedMessage].messages count] == 0) return;
                       TSMessageView *currentMessage = [[TSMessage sharedMessage].messages objectAtIndex:0];
                       if (currentMessage.messageIsFullyDisplayed)
                       {
                           [[TSMessage sharedMessage] fadeOutNotification:currentMessage animationFinishedBlock:completion];
                       }
                   });
    return YES;
=======
    return defaultViewController;
}

+ (void)setDefaultViewController:(UIViewController *)defaultViewController
{
    _defaultViewController = defaultViewController;
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
}

#pragma mark - Internals

- (TSMessageView *)currentMessage
{
    if (!self.messages.count) return nil;
    
    return [self.messages firstObject];
}

<<<<<<< HEAD:Pod/Classes/TSMessage.m
+ (void)setDelegate:(id<TSMessageViewProtocol>)delegate
{
    [TSMessage sharedMessage].delegate = delegate;
}

+ (void)addCustomDesignFromFileWithName:(NSString *)fileName
=======
- (void)displayCurrentMessage
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
{
    if (!self.currentMessage) return;

    [self displayMessage:self.currentMessage];
}

- (void)displayMessage:(TSMessageView *)messageView
{
    [messageView prepareForDisplay];
    
    // add view
    UIViewController *viewController = messageView.viewController;
    UINavigationController *navigationController = (UINavigationController *)([viewController isKindOfClass:[UINavigationController class]] ? viewController : viewController.parentViewController);
    
    if (!navigationController || navigationController.isNavigationBarHidden)
    {
        [messageView.viewController.view addSubview:messageView];
    }
    else
    {
        [navigationController.view insertSubview:messageView belowSubview:navigationController.navigationBar];
    }

    // animate
    [UIView animateWithDuration:kTSMessageAnimationDuration + 0.1
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         messageView.center = messageView.centerForDisplay;
                     }
                     completion:^(BOOL finished) {
                         messageView.messageFullyDisplayed = YES;
                     }];

    // duration
    if (messageView.duration == TSMessageDurationAutomatic)
    {
        messageView.duration = kTSMessageAnimationDuration + kTSMessageDisplayTime + messageView.frame.size.height * kTSMessageExtraDisplayTimePerPixel;
    }

    if (messageView.duration != TSMessageDurationEndless)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelector:@selector(dismissCurrentMessage) withObject:nil afterDelay:messageView.duration];
        });
    }
}

- (void)dismissMessage:(TSMessageView *)messageView
{
    [self dismissMessage:messageView completion:NULL];
}

<<<<<<< HEAD:Pod/Classes/TSMessage.m
+ (NSArray *)queuedMessages
{
    return [TSMessage sharedMessage].messages;
}

+ (UIViewController *)defaultViewController
=======
- (void)dismissMessage:(TSMessageView *)messageView completion:(void (^)())completion
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
{
    messageView.messageFullyDisplayed = NO;

    CGPoint dismissToPoint;
    
<<<<<<< HEAD:Pod/Classes/TSMessage.m
    if (!defaultViewController) {
        defaultViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
=======
    if (messageView.position == TSMessagePositionTop)
    {
        dismissToPoint = CGPointMake(messageView.center.x, -CGRectGetHeight(messageView.frame)/2.f);
>>>>>>> upstream/develop:TSMessages/Classes/TSMessage.m
    }
    else
    {
        dismissToPoint = CGPointMake(messageView.center.x, messageView.viewController.view.bounds.size.height + CGRectGetHeight(messageView.frame)/2.f);
    }

    [UIView animateWithDuration:kTSMessageAnimationDuration animations:^{
         messageView.center = dismissToPoint;
     } completion:^(BOOL finished) {
         [messageView removeFromSuperview];

         if (completion) completion();
     }];
}

- (void)dismissCurrentMessage
{
    if (!self.currentMessage) return;

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissCurrentMessage) object:nil];

    [self dismissMessage:self.currentMessage completion:^{
        if (self.messages.count)
        {
            [self.messages removeObjectAtIndex:0];
        }

        if (self.messages.count)
        {
            [self displayCurrentMessage];
        }
    }];
}

@end
