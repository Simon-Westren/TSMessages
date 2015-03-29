//
//  TSMessageView.m
//  Felix Krause
//
//  Created by Felix Krause on 24.08.12.
//  Copyright (c) 2012 Felix Krause. All rights reserved.
//

#import "TSMessageView.h"
#import "HexColor.h"
#import "TSBlurView.h"
#import "TSMessage.h"
<<<<<<< HEAD:Pod/Classes/TSMessageView.m

#define TSMessageViewMinimumPadding 15.0

#define TSDesignFileName @"TSMessagesDefaultDesign"

static NSMutableDictionary *_notificationDesign;

@interface TSMessage (TSMessageView)
- (void)fadeOutNotification:(TSMessageView *)currentView; // private method of TSMessage, but called by TSMessageView in -[fadeMeOut]
@end
=======
#import "TSMessage+Private.h"
#import "TSMessageView+Private.h"

#define TSMessageViewPadding 15.0
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m

@interface TSMessageView () <UIGestureRecognizerDelegate>
@property (nonatomic) NSDictionary *config;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UIImageView *iconImageView;
@property (nonatomic) UIButton *button;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic) UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic) TSBlurView *backgroundBlurView;
@property (nonatomic, copy) TSMessageCallback buttonCallback;
@property (nonatomic, getter=isMessageFullyDisplayed) BOOL messageFullyDisplayed;
@end

@implementation TSMessageView

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image type:(TSMessageType)type
{
    if ((self = [self init]))
    {
        self.userDismissEnabled = YES;
        self.duration = TSMessageDurationAutomatic;
        self.position = TSMessagePositionTop;
        
        [self setupConfigForType:type];
        [self setupBackgroundView];
        [self setupTitle:title];
        [self setupSubtitle:subtitle];
        [self setupImage:image];
        [self setupAutoresizing];
        [self setupGestureRecognizers];
    }
    
    return self;
}

<<<<<<< HEAD:Pod/Classes/TSMessageView.m
/** Internal properties needed to resize the view on device rotation properly */
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) TSBlurView *backgroundBlurView; // Only used in iOS 7
=======
#pragma mark - Setup helpers
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m

- (void)setupConfigForType:(TSMessageType)type
{
    NSString *config;
    
    switch (type)
    {
        case TSMessageTypeError: config = @"error"; break;
        case TSMessageTypeSuccess: config = @"success"; break;
        case TSMessageTypeWarning: config = @"warning"; break;
            
        default: config = @"message"; break;
    }
    
    self.config = [TSMessage design][config];
}

- (void)setupBackgroundView
{
    self.backgroundBlurView = [[TSBlurView alloc] init];
    self.backgroundBlurView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundBlurView.blurTintColor = [UIColor colorWithHexString:self.config[@"backgroundColor"]];
    
    [self addSubview:self.backgroundBlurView];
}

- (void)setupAutoresizing
{
    self.autoresizingMask = (self.position == TSMessagePositionTop) ?
        (UIViewAutoresizingFlexibleWidth) :
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
}

- (void)setupTitle:(NSString *)title
{
    UIColor *fontColor = [UIColor colorWithHexString:self.config[@"textColor"] alpha:1];
    CGFloat fontSize = [self.config[@"titleFontSize"] floatValue];
    NSString *fontName = self.config[@"titleFontName"];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.shadowOffset = CGSizeMake([self.config[@"shadowOffsetX"] floatValue], [self.config[@"shadowOffsetY"] floatValue]);
    self.titleLabel.shadowColor = [UIColor colorWithHexString:self.config[@"shadowColor"] alpha:1];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = fontColor;
    self.titleLabel.text = title;
    self.titleLabel.font = fontName ?
        [UIFont fontWithName:fontName size:fontSize] :
        [UIFont boldSystemFontOfSize:fontSize];
    
    [self addSubview:self.titleLabel];
}

- (void)setupSubtitle:(NSString *)subtitle
{
    if (!subtitle.length) return;
    
    UIColor *contentTextColor = [UIColor colorWithHexString:self.config[@"contentTextColor"] alpha:1];
    UIColor *fontColor = [UIColor colorWithHexString:self.config[@"textColor"] alpha:1];
    CGFloat fontSize = [self.config[@"contentFontSize"] floatValue];
    NSString *fontName = self.config[@"contentFontName"];
    
    if (!contentTextColor) contentTextColor = fontColor;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.shadowOffset = CGSizeMake([self.config[@"shadowOffsetX"] floatValue], [self.config[@"shadowOffsetY"] floatValue]);
    self.contentLabel.shadowColor = [UIColor colorWithHexString:self.config[@"shadowColor"] alpha:1];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.textColor = contentTextColor;
    self.contentLabel.text = subtitle;
    self.contentLabel.font = fontName ?
        [UIFont fontWithName:fontName size:fontSize] :
        [UIFont systemFontOfSize:fontSize];
    
    [self addSubview:self.contentLabel];
}

<<<<<<< HEAD:Pod/Classes/TSMessageView.m
@implementation TSMessageView{
    TSMessageNotificationType notificationType;
}
-(void) setContentFont:(UIFont *)contentFont{
    _contentFont = contentFont;
    [self.contentLabel setFont:contentFont];
}

-(void) setContentTextColor:(UIColor *)contentTextColor{
    _contentTextColor = contentTextColor;
    [self.contentLabel setTextColor:_contentTextColor];
}

-(void) setTitleFont:(UIFont *)aTitleFont{
    _titleFont = aTitleFont;
    [self.titleLabel setFont:_titleFont];
}

-(void)setTitleTextColor:(UIColor *)aTextColor{
    _titleTextColor = aTextColor;
    [self.titleLabel setTextColor:_titleTextColor];
}

-(void) setMessageIcon:(UIImage *)messageIcon{
    _messageIcon = messageIcon;
    [self updateCurrentIcon];
}

-(void) setErrorIcon:(UIImage *)errorIcon{
    _errorIcon = errorIcon;
    [self updateCurrentIcon];
}

-(void) setSuccessIcon:(UIImage *)successIcon{
    _successIcon = successIcon;
    [self updateCurrentIcon];
}

-(void) setWarningIcon:(UIImage *)warningIcon{
    _warningIcon = warningIcon;
    [self updateCurrentIcon];
}

-(void) updateCurrentIcon{
    UIImage *image = nil;
    switch (notificationType)
    {
        case TSMessageNotificationTypeMessage:
        {
            image = _messageIcon;
            self.iconImageView.image = _messageIcon;
            break;
        }
        case TSMessageNotificationTypeError:
        {
            image = _errorIcon;
            self.iconImageView.image = _errorIcon;
            break;
        }
        case TSMessageNotificationTypeSuccess:
        {
            image = _successIcon;
            self.iconImageView.image = _successIcon;
            break;
        }
        case TSMessageNotificationTypeWarning:
        {
            image = _warningIcon;
            self.iconImageView.image = _warningIcon;
            break;
        }
        default:
            break;
    }
    self.iconImageView.frame = CGRectMake(self.padding * 2,
                                          self.padding,
                                          image.size.width,
                                          image.size.height);
}



=======
- (void)setupImage:(UIImage *)image
{
    if (!image && self.config[@"imageName"] != [NSNull null] && [self.config[@"imageName"] length]) image = [UIImage imageNamed:self.config[@"imageName"]];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:image];
    self.iconImageView.frame = CGRectMake(TSMessageViewPadding * 2, TSMessageViewPadding, image.size.width, image.size.height);
    
    [self addSubview:self.iconImageView];
}
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m

- (void)setupGestureRecognizers
{
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
    if (!_notificationDesign)
    {
        NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:TSDesignFileName ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSAssert(data != nil, @"Could not read TSMessages config file from main bundle with name %@.json", TSDesignFileName);
        
        _notificationDesign = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                            options:kNilOptions
                                                                                                              error:nil]];
    }
=======
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewTap:)];
    self.tapRecognizer.delegate = self;
    [self addGestureRecognizer:self.tapRecognizer];
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
    
    self.swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewSwipe:)];
    self.swipeRecognizer.direction = (self.position == TSMessagePositionTop ? UISwipeGestureRecognizerDirectionUp : UISwipeGestureRecognizerDirectionDown);
    [self addGestureRecognizer:self.swipeRecognizer];
}

#pragma mark - Message view attributes and actions

- (void)setButtonWithTitle:(NSString *)title callback:(TSMessageCallback)callback
{
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSDictionary *design = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                               options:kNilOptions
                                                                 error:nil];
        
        [[TSMessageView notificationDesign] addEntriesFromDictionary:design];
    }
    else
    {
        NSAssert(NO, @"Error loading design file with name %@", filename);
    }
}

- (CGFloat)padding
{
    // Adds 10 padding to to cover navigation bar
    return self.messagePosition == TSMessageNotificationPositionNavBarOverlay ? TSMessageViewMinimumPadding + 10.0f : TSMessageViewMinimumPadding;
}

- (id)initWithTitle:(NSString *)title
		   subtitle:(NSString *)subtitle
			  image:(UIImage *)image
			   type:(TSMessageNotificationType)notificationType
		   duration:(CGFloat)duration
   inViewController:(UIViewController *)viewController
		   callback:(void (^)())callback
		buttonTitle:(NSString *)buttonTitle
	 buttonCallback:(void (^)())buttonCallback
		 atPosition:(TSMessageNotificationPosition)position
canBeDismissedByUser:(BOOL)dismissingEnabled
{
	return [self initWithTag:title subtitle:subtitle tag:-1 image:image type:notificationType duration:duration inViewController:viewController callback:callback buttonTitle:buttonTitle buttonCallback:buttonCallback atPosition:position canBeDismissedByUser:dismissingEnabled];
}

- (id)initWithTag:(NSString *)title
           subtitle:(NSString *)subtitle
		   tag:(NSInteger)tag
              image:(UIImage *)image
               type:(TSMessageNotificationType)aNotificationType
           duration:(CGFloat)duration
   inViewController:(UIViewController *)viewController
           callback:(void (^)())callback
        buttonTitle:(NSString *)buttonTitle
     buttonCallback:(void (^)())buttonCallback
         atPosition:(TSMessageNotificationPosition)position
canBeDismissedByUser:(BOOL)dismissingEnabled
=======
    self.buttonCallback = callback;
    
    UIImage *buttonBackgroundImage = [[UIImage imageNamed:self.config[@"buttonBackgroundImageName"]] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 12.0, 15.0, 11.0)];
    UIColor *buttonTitleShadowColor = [UIColor colorWithHexString:self.config[@"buttonTitleShadowColor"] alpha:1];
    UIColor *buttonTitleTextColor = [UIColor colorWithHexString:self.config[@"buttonTitleTextColor"] alpha:1];
    UIColor *fontColor = [UIColor colorWithHexString:self.config[@"textColor"] alpha:1];
    
    if (!buttonBackgroundImage) buttonBackgroundImage = [[UIImage imageNamed:self.config[@"MessageButtonBackground"]] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 12.0, 15.0, 11.0)];
    if (!buttonTitleShadowColor) buttonTitleShadowColor = [UIColor colorWithHexString:self.config[@"shadowColor"] alpha:1];
    if (!buttonTitleTextColor) buttonTitleTextColor = fontColor;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    self.button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.button.titleLabel.shadowOffset = CGSizeMake([self.config[@"buttonTitleShadowOffsetX"] floatValue], [self.config[@"buttonTitleShadowOffsetY"] floatValue]);
    
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [self.button setTitleShadowColor:buttonTitleShadowColor forState:UIControlStateNormal];
    [self.button setTitleColor:buttonTitleTextColor forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.button sizeToFit];
    
    self.button.frame = CGRectMake(self.viewController.view.bounds.size.width - TSMessageViewPadding - self.button.frame.size.width, 0, self.button.frame.size.width, 31);
    
    [self addSubview:self.button];
}

- (void)displayOrEnqueue {
    [TSMessage displayOrEnqueueMessage:self];
}

- (void)displayPermanently {
    [TSMessage displayPermanentMessage:self];
}

#pragma mark - View handling

- (void)didMoveToWindow
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
{
    [super didMoveToWindow];
    
    if (self.duration == TSMessageDurationEndless && self.superview && !self.window)
    {
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
        _title = title;
        _subtitle = subtitle;
		[self setTag:tag];
        _buttonTitle = buttonTitle;
        _duration = duration;
        _viewController = viewController;
        _messagePosition = position;
        self.callback = callback;
        self.buttonCallback = buttonCallback;
        
        CGFloat screenWidth = self.viewController.view.bounds.size.width;
        CGFloat padding = [self padding];
        
        NSDictionary *current;
        NSString *currentString;
        notificationType = aNotificationType;
        switch (notificationType)
        {
            case TSMessageNotificationTypeMessage:
            {
                currentString = @"message";
                break;
            }
            case TSMessageNotificationTypeError:
            {
                currentString = @"error";
                break;
            }
            case TSMessageNotificationTypeSuccess:
            {
                currentString = @"success";
                break;
            }
            case TSMessageNotificationTypeWarning:
            {
                currentString = @"warning";
                break;
            }
                
            default:
                break;
        }
        
        current = [notificationDesign valueForKey:currentString];
        
        
        if (!image && [[current valueForKey:@"imageName"] length])
        {
            image = [UIImage imageNamed:[current valueForKey:@"imageName"]];
        }
        
        if (![TSMessage iOS7StyleEnabled])
        {
            self.alpha = 0.0;
            
            // add background image here
            UIImage *backgroundImage = [UIImage imageNamed:[current valueForKey:@"backgroundImageName"]];
            backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
            
            _backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
            self.backgroundImageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
            [self addSubview:self.backgroundImageView];
        }
        else
        {
            // On iOS 7 and above use a blur layer instead (not yet finished)
            _backgroundBlurView = [[TSBlurView alloc] init];
            self.backgroundBlurView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
            self.backgroundBlurView.blurTintColor = [UIColor colorWithHexString:current[@"backgroundColor"]];
            [self addSubview:self.backgroundBlurView];
        }
        
        UIColor *fontColor = [UIColor colorWithHexString:[current valueForKey:@"textColor"]
                                                   alpha:1.0];
        
        
        self.textSpaceLeft = 2 * padding;
        if (image) self.textSpaceLeft += image.size.width + 2 * padding;
        
        // Set up title label
        _titleLabel = [[UILabel alloc] init];
        [self.titleLabel setText:title];
        [self.titleLabel setTextColor:fontColor];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        CGFloat fontSize = [[current valueForKey:@"titleFontSize"] floatValue];
        NSString *fontName = [current valueForKey:@"titleFontName"];
        if (fontName != nil) {
            [self.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        } else {
            [self.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
        }
        [self.titleLabel setShadowColor:[UIColor colorWithHexString:[current valueForKey:@"shadowColor"] alpha:1.0]];
        [self.titleLabel setShadowOffset:CGSizeMake([[current valueForKey:@"shadowOffsetX"] floatValue],
                                                    [[current valueForKey:@"shadowOffsetY"] floatValue])];
        
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.titleLabel];
        
        // Set up content label (if set)
        if ([subtitle length])
        {
            _contentLabel = [[UILabel alloc] init];
            [self.contentLabel setText:subtitle];
            
            UIColor *contentTextColor = [UIColor colorWithHexString:[current valueForKey:@"contentTextColor"] alpha:1.0];
            if (!contentTextColor)
            {
                contentTextColor = fontColor;
            }
            [self.contentLabel setTextColor:contentTextColor];
            [self.contentLabel setBackgroundColor:[UIColor clearColor]];
            CGFloat fontSize = [[current valueForKey:@"contentFontSize"] floatValue];
            NSString *fontName = [current valueForKey:@"contentFontName"];
            if (fontName != nil) {
                [self.contentLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
            } else {
                [self.contentLabel setFont:[UIFont systemFontOfSize:fontSize]];
            }
            [self.contentLabel setShadowColor:self.titleLabel.shadowColor];
            [self.contentLabel setShadowOffset:self.titleLabel.shadowOffset];
            self.contentLabel.lineBreakMode = self.titleLabel.lineBreakMode;
            self.contentLabel.numberOfLines = 0;
            
            [self addSubview:self.contentLabel];
        }
        
        if (image)
        {
            _iconImageView = [[UIImageView alloc] initWithImage:image];
            self.iconImageView.frame = CGRectMake(padding * 2,
                                                  padding,
                                                  image.size.width,
                                                  image.size.height);
            [self addSubview:self.iconImageView];
        }
        
        // Set up button (if set)
        if ([buttonTitle length])
        {
            _button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            UIImage *buttonBackgroundImage = [UIImage imageNamed:[current valueForKey:@"buttonBackgroundImageName"]];
            
            buttonBackgroundImage = [buttonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 12.0, 15.0, 11.0)];
            
            if (!buttonBackgroundImage)
            {
                buttonBackgroundImage = [UIImage imageNamed:[current valueForKey:@"NotificationButtonBackground"]];
                buttonBackgroundImage = [buttonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 12.0, 15.0, 11.0)];
            }
            
            [self.button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
            [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
            
            UIColor *buttonTitleShadowColor = [UIColor colorWithHexString:[current valueForKey:@"buttonTitleShadowColor"] alpha:1.0];
            if (!buttonTitleShadowColor)
            {
                buttonTitleShadowColor = self.titleLabel.shadowColor;
            }
            
            [self.button setTitleShadowColor:buttonTitleShadowColor forState:UIControlStateNormal];
            
            UIColor *buttonTitleTextColor = [UIColor colorWithHexString:[current valueForKey:@"buttonTitleTextColor"] alpha:1.0];
            if (!buttonTitleTextColor)
            {
                buttonTitleTextColor = fontColor;
            }
            
            [self.button setTitleColor:buttonTitleTextColor forState:UIControlStateNormal];
            self.button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            self.button.titleLabel.shadowOffset = CGSizeMake([[current valueForKey:@"buttonTitleShadowOffsetX"] floatValue],
                                                             [[current valueForKey:@"buttonTitleShadowOffsetY"] floatValue]);
            [self.button addTarget:self
                            action:@selector(buttonTapped:)
                  forControlEvents:UIControlEventTouchUpInside];
            
            self.button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
            [self.button sizeToFit];
            self.button.frame = CGRectMake(screenWidth - padding - self.button.frame.size.width,
                                           0.0,
                                           self.button.frame.size.width,
                                           31.0);
            
            [self addSubview:self.button];
            
            self.textSpaceRight = self.button.frame.size.width + padding;
        }
        
        // Add a border on the bottom (or on the top, depending on the view's postion)
        if (![TSMessage iOS7StyleEnabled])
        {
            _borderView = [[UIView alloc] initWithFrame:CGRectMake(0.0,
                                                                   0.0, // will be set later
                                                                   screenWidth,
                                                                   [[current valueForKey:@"borderHeight"] floatValue])];
            self.borderView.backgroundColor = [UIColor colorWithHexString:[current valueForKey:@"borderColor"]
                                                                    alpha:1.0];
            self.borderView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
            [self addSubview:self.borderView];
        }
        
        
        CGFloat actualHeight = [self updateHeightOfMessageView]; // this call also takes care of positioning the labels
        CGFloat topPosition = -actualHeight;
        
        if (self.messagePosition == TSMessageNotificationPositionBottom)
        {
            topPosition = self.viewController.view.bounds.size.height;
        }
        
        self.frame = CGRectMake(0.0, topPosition, screenWidth, actualHeight);
        
        if (self.messagePosition == TSMessageNotificationPositionTop)
        {
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
        else
        {
            self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        }
        
        if (dismissingEnabled)
        {
            UISwipeGestureRecognizer *gestureRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(fadeMeOut)];
            [gestureRec setDirection:(self.messagePosition == TSMessageNotificationPositionTop ?
                                      UISwipeGestureRecognizerDirectionUp :
                                      UISwipeGestureRecognizerDirectionDown)];
            [self addGestureRecognizer:gestureRec];
            
            UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(fadeMeOut)];
            [self addGestureRecognizer:tapRec];
        }
        
        if (self.callback) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            tapGesture.delegate = self;
            [self addGestureRecognizer:tapGesture];
        }
=======
        [self dismiss];
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat currentHeight;
    CGFloat screenWidth = self.viewController.view.bounds.size.width;
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
    CGFloat padding = [self padding];
    
    self.titleLabel.frame = CGRectMake(self.textSpaceLeft,
                                       padding,
                                       screenWidth - padding - self.textSpaceLeft - self.textSpaceRight,
=======
    CGFloat textSpaceRight = self.button.frame.size.width + TSMessageViewPadding;
    CGFloat textSpaceLeft = 2 * TSMessageViewPadding;
    UIImage *image = self.iconImageView.image;
    
    if (image) textSpaceLeft += image.size.width + 2 * TSMessageViewPadding;
    
    // title
    self.titleLabel.frame = CGRectMake(textSpaceLeft,
                                       TSMessageViewPadding,
                                       screenWidth - TSMessageViewPadding - textSpaceLeft - textSpaceRight,
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
                                       0.0);
    [self.titleLabel sizeToFit];
    
    // subtitle
    if (self.contentLabel)
    {
        self.contentLabel.frame = CGRectMake(textSpaceLeft,
                                             self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5.0,
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
                                             screenWidth - padding - self.textSpaceLeft - self.textSpaceRight,
=======
                                             screenWidth - TSMessageViewPadding - textSpaceLeft - textSpaceRight,
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
                                             0.0);
        [self.contentLabel sizeToFit];
        
        currentHeight = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height;
    }
    else
    {
        currentHeight = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
    }
    
    currentHeight += padding;
    
    // image
    if (self.iconImageView)
    {
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
        // Check if that makes the popup larger (height)
        if (self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + padding > currentHeight)
=======
        // check if that makes the popup larger (height)
        if (self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + TSMessageViewPadding > currentHeight)
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
        {
            currentHeight = self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + padding;
        }
        else
        {
            self.iconImageView.center = CGPointMake([self.iconImageView center].x, round(currentHeight / 2.0));
        }
    }
    
    self.frame = CGRectMake(0.0, self.frame.origin.y, self.frame.size.width, currentHeight);
    
    // button
    if (self.button)
    {
        self.button.center = CGPointMake([self.button center].x, round(currentHeight / 2.0));
    
        self.button.frame = CGRectMake(self.frame.size.width - textSpaceRight,
                                       round((self.frame.size.height / 2.0) - self.button.frame.size.height / 2.0),
                                       self.button.frame.size.width,
                                       self.button.frame.size.height);
    }
    
    
    CGRect backgroundFrame = CGRectMake(self.backgroundBlurView.frame.origin.x,
                                        self.backgroundBlurView.frame.origin.y,
                                        screenWidth,
                                        currentHeight);
    
    // increase frame of background view because of the spring animation
    if (self.position == TSMessagePositionTop)
    {
        float topOffset = 0.f;
        
        UINavigationController *navigationController = self.viewController.navigationController;
        
        if (!navigationController && [self.viewController isKindOfClass:[UINavigationController class]])
        {
            navigationController = (UINavigationController *)self.viewController;
        }
        
        BOOL isNavBarIsHidden = !navigationController || self.viewController.navigationController.navigationBarHidden;
        BOOL isNavBarIsOpaque = !self.viewController.navigationController.navigationBar.isTranslucent && self.viewController.navigationController.navigationBar.alpha == 1;
        
        if (isNavBarIsHidden || isNavBarIsOpaque)
        {
            topOffset = -30.f;
        }
        
        backgroundFrame = UIEdgeInsetsInsetRect(backgroundFrame, UIEdgeInsetsMake(topOffset, 0.f, topOffset, 0.f));
    }
    
    self.backgroundBlurView.frame = backgroundFrame;
}

- (void)prepareForDisplay
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat actualHeight = self.frame.size.height;
    CGFloat topPosition = -actualHeight;
    
    if (self.position == TSMessagePositionBottom)
    {
        topPosition = self.viewController.view.bounds.size.height;
    }
    
    self.frame = CGRectMake(0, topPosition, self.viewController.view.bounds.size.width, actualHeight);
}

- (CGPoint)centerForDisplay
{
    CGFloat y;
    CGFloat heightOffset = CGRectGetHeight(self.frame) / 2;
    
    if ([self.delegate respondsToSelector:@selector(customMessageOffsetForPosition:inViewController:)])
    {
        CGFloat offset = [self.delegate customMessageOffsetForPosition:self.position inViewController:self.viewController];
        
        if (self.position == TSMessagePositionTop)
        {
            y = offset + heightOffset;
        }
        else
        {
            y = self.viewController.view.bounds.size.height - (offset + heightOffset);
        }
    }
    else
    {
        __block CGFloat offset = 0;
        
        void (^addStatusBarHeightToVerticalOffset)() = ^void() {
            BOOL isPortrait = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
            CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
            
            offset += isPortrait ? statusBarSize.height : statusBarSize.width;
        };
        
        if ([self.viewController isKindOfClass:[UINavigationController class]] || [self.viewController.parentViewController isKindOfClass:[UINavigationController class]])
        {
            UIViewController *viewController = self.viewController;
            UINavigationController *navigationController = (UINavigationController *)([viewController isKindOfClass:[UINavigationController class]] ? viewController : viewController.parentViewController);
            
            viewController = [[navigationController childViewControllers] firstObject];
            
            BOOL isViewIsUnderStatusBar = !viewController.prefersStatusBarHidden;
            
            if (!isViewIsUnderStatusBar && navigationController.parentViewController == nil)
            {
                // strange but true
                isViewIsUnderStatusBar = ![self isNavigationBarInNavigationControllerHidden:navigationController];
            }
<<<<<<< HEAD:Pod/Classes/TSMessageView.m
            BOOL isNavBarIsHidden = !navigationController || [TSMessage isNavigationBarInNavigationControllerHidden:navigationController];
            BOOL isNavBarIsOpaque = !navigationController.navigationBar.isTranslucent && navigationController.navigationBar.alpha == 1;
=======
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
            
            if (![self isNavigationBarInNavigationControllerHidden:navigationController])
            {
                offset = [navigationController navigationBar].bounds.size.height;
                addStatusBarHeightToVerticalOffset();
            }
            else if (isViewIsUnderStatusBar)
            {
                addStatusBarHeightToVerticalOffset();
            }
        }
        else
        {
            addStatusBarHeightToVerticalOffset();
        }
        
        if (self.position == TSMessagePositionTop)
        {
            y = offset + heightOffset;
        }
        else
        {
            y = self.viewController.view.bounds.size.height - heightOffset;
            
            if (!self.viewController.navigationController.isToolbarHidden)
            {
                y -= CGRectGetHeight(self.viewController.navigationController.toolbar.bounds);
            }
        }
    }
    
    CGPoint center = CGPointMake(self.center.x, y);
    
    return center;
}

#pragma mark - Actions

- (void)handleButtonTap:(id) sender
{
    if (self.buttonCallback)
    {
        self.buttonCallback(self);
    }
}

<<<<<<< HEAD:Pod/Classes/TSMessageView.m
- (void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.duration == TSMessageNotificationDurationEndless && self.superview && !self.window )
    {
        // view controller was dismissed, let's fade out
        [self fadeMeOut];
=======
- (void)handleViewTap:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state != UIGestureRecognizerStateRecognized) return;
    
    if (self.isUserDismissEnabled)
    {
        [self dismiss];
    }
    
    if (self.tapCallback)
    {
        self.tapCallback(self);
>>>>>>> upstream/develop:TSMessages/Views/TSMessageView.m
    }
}

- (void)handleViewSwipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if (swipeRecognizer.state != UIGestureRecognizerStateRecognized) return;
    
    if (self.isUserDismissEnabled)
    {
        [self dismiss];
    }
    
    if (self.swipeCallback)
    {
        self.swipeCallback(self);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return !([touch.view isKindOfClass:[UIControl class]]);
}

- (void)dismiss
{
    if (self == [TSMessage sharedMessage].currentMessage)
    {
        [[TSMessage sharedMessage] performSelectorOnMainThread:@selector(dismissCurrentMessage) withObject:nil waitUntilDone:NO];
    }
    else
    {
        [[TSMessage sharedMessage] performSelectorOnMainThread:@selector(dismissMessage:) withObject:self waitUntilDone:NO];
    }
}

- (void)setPosition:(TSMessagePosition)position {
    _position = position;
    
    self.swipeRecognizer.direction = (self.position == TSMessagePositionTop ? UISwipeGestureRecognizerDirectionUp : UISwipeGestureRecognizerDirectionDown);
}

#pragma mark - Private

- (NSString *)title
{
    return self.titleLabel.text;
}

- (NSString *)subtitle
{
    return self.contentLabel.text;
}

/** Indicates whether the current navigationBar is hidden by isNavigationBarHidden on the
 UINavigationController or isHidden on the navigationBar of the UINavigationController */
- (BOOL)isNavigationBarInNavigationControllerHidden:(UINavigationController *)navController
{
    if (navController.isNavigationBarHidden) {
        return YES;
    } else if (navController.navigationBar.isHidden) {
        return YES;
    } else {
        return NO;
    }
}

@end
