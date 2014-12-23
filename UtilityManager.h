

#include <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@protocol UtilityManagerDelegate <NSObject>

@optional
- (void) doneButtonDidPressed:(id)sender;

@end

@interface UtilityManager : NSObject
{
	BOOL				isRunning;
	BOOL				locationServicesEnabled;
}

@property BOOL isRunning;
@property (nonatomic, retain) UIView *activityView;

+ (void)hideActivityViewer:(UIView *)view;
+ (void)showActivityViewer:(UIView *)view withString:(NSString *)text;
+ (void)showActivityViewer:(UIView *)view;

+ (void) setAlert:(NSString *)title withMessage:(NSString *)message 
	 withDelegate:(UIViewController*)delegate withTag:(NSInteger)tag 
	   andButtons:(NSString *)buttons, ... NS_REQUIRES_NIL_TERMINATION;

+(NSString*) getUDID;

+(NSString*)getTextFromString:(NSString *)strString;

+ (BOOL) isDeviceiPad;
+ (BOOL) isDeviceiPhone5;

+ (void) addDoneButtonForTextField:(UITextField*)input WithDelegate:(id)deleagte;
+ (void) addDoneButtonForTextView:(UITextView*)input WithDelegate:(id)delegate InView:(UIView *)objV;

+ (NSString *) getDocumentDirPath;
+ (void) addLogToDocumentFolder;

// System Version Info
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@end

