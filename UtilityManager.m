
#import "UtilityManager.h"
#import "SecureUDID.h"

#define ActivityIndicatorTag 99999

@implementation UtilityManager

@synthesize activityView;
@synthesize isRunning;

UIView * activityView;

//hide Activity Indicator.
+ (void)hideActivityViewer:(UIView *) view
{
    [[[activityView subviews] objectAtIndex:0] stopAnimating];
    [activityView removeFromSuperview];
    activityView = nil;
}


+ (void)showActivityViewer:(UIView *)window
{
	if( ![window viewWithTag:ActivityIndicatorTag] )
	{
        [UtilityManager showActivityViewer:window  withString:@"Loading..."];
    }
}

//Show Activity Indicator.
+ (void)showActivityViewer:(UIView *)currentView withString:(NSString *) text
{
	// Added the check that if activityView object is present or not.
	if (activityView == nil)
		activityView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, currentView.frame.size.width, currentView.frame.size.height)];
	
	activityView.backgroundColor = [UIColor clearColor];
	activityView.center = CGPointMake(currentView.frame.size.width/2, currentView.frame.size.height/2);
	activityView.tag = ActivityIndicatorTag;
	
	UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(currentView.frame.size.width / 2 - 12, currentView.frame.size.height / 2 - 12, 24, 24)];
	activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	activityWheel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
									  UIViewAutoresizingFlexibleWidth);
	activityWheel.backgroundColor=[UIColor clearColor];
	activityWheel.center=CGPointMake(currentView.frame.size.width/2, currentView.frame.size.height/2);
	[activityView insertSubview:activityWheel atIndex:1];
    [activityWheel release];
	
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.backgroundColor = [UIColor colorWithRed:254 green:186 blue:4 alpha:1.0];
	imageView.layer.shadowOffset = CGSizeMake(0, 2);
	imageView.layer.shadowOpacity = 70;
	imageView.frame=CGRectMake(currentView.frame.size.width / 2 - 64, currentView.frame.size.height / 2 - 64, 128, 128);
	imageView.center=activityWheel.center;
	[imageView.layer setCornerRadius:5];
	imageView.center=CGPointMake(currentView.frame.size.width/2, currentView.frame.size.height/2);
	[activityView insertSubview:imageView atIndex:0];
	[[[activityView subviews] objectAtIndex:1] startAnimating];
	
	UILabel *lodingLbl = [[UILabel alloc] initWithFrame:CGRectMake(activityView.frame.size.width/2-64, activityView.frame.size.height/2+24 , 128, 40)];
	[lodingLbl setText:text];
	lodingLbl.backgroundColor = [UIColor clearColor];
	lodingLbl.textAlignment = NSTextAlignmentCenter;
	lodingLbl.font = [UIFont fontWithName:@"Heiti TC" size:17];
	lodingLbl.textColor = [UIColor grayColor];
	[activityView insertSubview:lodingLbl atIndex:2];
	
	[activityView.layer setCornerRadius:5];
	[currentView addSubview: activityView];
	activityView.center = currentView.center;
	[imageView release];
	[lodingLbl release];
}

#pragma mark -
#pragma mark AlertView.

// set alert method to show alert view.
+ (void) setAlert:(NSString *)title withMessage:(NSString *)message withDelegate:(UIViewController*)delegate withTag:(NSInteger)tag andButtons:(NSString *)buttons, ... {
	
	UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:nil];
	
	va_list args;
	va_start(args, buttons);
    for (NSString *arg = buttons; arg != nil; arg = va_arg(args, NSString*))
    {
        [alertView addButtonWithTitle:arg];
    }
	va_end(args);
	
	alertView.tag = tag;
	[alertView show];
	[alertView release];
	
}

#pragma mark -
#pragma mark check internet capability.

+ (NSString*) getUDID;
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *defaultRODeviceSecureUDID = [def stringForKey:@"SalesMateSecureUDID"];
    if(defaultRODeviceSecureUDID == nil) {
        NSString *domain     = [NSBundle mainBundle].bundleIdentifier;
        NSString *key        = @"Sales";
        defaultRODeviceSecureUDID = [SecureUDID UDIDForDomain:domain usingKey:key];
        [def setObject:defaultRODeviceSecureUDID forKey:@"SalesMateSecureUDID"];
        [def synchronize];
    }
	return defaultRODeviceSecureUDID;
}

- (void)dealloc
{
	[activityView release];
    [super dealloc];
}

#pragma - Remove Unwanted Characters

+ (NSString*) getTextFromString:(NSString *)strString
{
    NSString *strTemp =  @"";
    
    if (![strString isEqual:[NSNull null]])
    {
        if ([[strString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)
        {
            strTemp = [strString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            return strTemp;
        }
    }
    return strTemp;
}

#pragma mark - Add Done Button

+ (void) addDoneButtonForTextField:(UITextField*)input WithDelegate:(id)deleagte
{
    //Toolbar on NumberPad..
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,200,320,44)];
    toolBar.tintColor = [UIColor blackColor];
    toolBar.items = [NSArray arrayWithObjects:
                     [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                     [[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done",@"") style:UIBarButtonItemStylePlain target:deleagte action:@selector(doneButtonDidPressed:)] autorelease],
                     nil];
    [toolBar sizeToFit];
    input.inputAccessoryView = toolBar;
    [toolBar release];
}

+ (void) addDoneButtonForTextView:(UITextView*)input WithDelegate:(id)delegate InView:(UIView *)objV
{
    //Toolbar on NumberPad..
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,200,320,44)];
    toolBar.tintColor = [UIColor blackColor];
    toolBar.items = [NSArray arrayWithObjects:
                     [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                     [[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done",@"") style:UIBarButtonItemStylePlain target:delegate action:@selector(doneButtonDidPressed:)] autorelease],
                     nil];
    [toolBar sizeToFit];
    input.inputAccessoryView = toolBar;
    [toolBar release];
}

#pragma mark -

+ (BOOL) isDeviceiPad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone5
{
    if(([[UIScreen mainScreen] bounds]).size.height == 568)
    {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *) getDocumentDirPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

#pragma mark - Print Log

+ (void) addLogToDocumentFolder
{
    NSString *fileName =[NSString stringWithFormat:@"%@.log",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"]];
    
    NSString *logFilePath = [[self getDocumentDirPath] stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

@end
