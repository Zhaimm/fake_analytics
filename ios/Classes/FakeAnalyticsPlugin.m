#import "FakeAnalyticsPlugin.h"
#import <FakeMobileAnalytics/FakeMobileAnalytics.h>

@implementation FakeAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"v7lin.github.io/fake_analytics"
                                     binaryMessenger:[registrar messenger]];
    FakeAnalyticsPlugin* instance = [[FakeAnalyticsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

static NSString * const METHOD_STARTWORK = @"startWork";
static NSString * const METHOD_SIGNUP = @"signUp";
static NSString * const METHOD_SIGNIN = @"signIn";
static NSString * const METHOD_SIGNOUT = @"signOut";
static NSString * const METHOD_TRACKEVENT = @"trackEvent";
static NSString * const METHOD_STARTEVENTTRACKING = @"startEventTracking";
static NSString * const METHOD_STOPEVENTTRACKING = @"stopEventTracking";
static NSString * const METHOD_STARTPAGETRACKING = @"startPageTracking";
static NSString * const METHOD_STOPPAGETRACKING = @"stopPageTracking";

static NSString * const ARGUMENT_KEY_APPKEY = @"appKey";
static NSString * const ARGUMENT_KEY_APPCHANNEL = @"appChannel";
static NSString * const ARGUMENT_KEY_ENABLEDEBUG = @"enableDebug";

static NSString * const ARGUMENT_KEY_USERID = @"userId";
static NSString * const ARGUMENT_KEY_USERNICK = @"userNick";

static NSString * const ARGUMENT_KEY_EVENTID = @"eventId";
static NSString * const ARGUMENT_KEY_EVENTLABEL = @"eventLabel";

static NSString * const ARGUMENT_KEY_PAGENAME = @"pageName";

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([METHOD_STARTWORK isEqualToString:call.method]) {
        NSString * appKey = call.arguments[ARGUMENT_KEY_APPKEY];
        NSString * appChannel = call.arguments[ARGUMENT_KEY_APPCHANNEL];
        NSNumber * enableDebug = call.arguments[ARGUMENT_KEY_ENABLEDEBUG];
        [[FakeMobileAnalytics shared] startWork:appKey appChannel:appChannel enableDebug:enableDebug.boolValue];
        result(nil);
    } else if ([METHOD_SIGNUP isEqualToString:call.method]) {
        NSString * userId = call.arguments[ARGUMENT_KEY_USERID];
        NSString * userNick = call.arguments[ARGUMENT_KEY_USERNICK];
        [[FakeMobileAnalytics shared] signUp:userId userNick:userNick];
        result(nil);
    } else if ([METHOD_SIGNIN isEqualToString:call.method]) {
        NSString * userId = call.arguments[ARGUMENT_KEY_USERID];
        NSString * userNick = call.arguments[ARGUMENT_KEY_USERNICK];
        [[FakeMobileAnalytics shared] signIn:userId userNick:userNick];
        result(nil);
    } else if ([METHOD_SIGNOUT isEqualToString:call.method]) {
        [[FakeMobileAnalytics shared] signOut];
        result(nil);
    } else if ([METHOD_TRACKEVENT isEqualToString:call.method]) {
        NSString * eventId = call.arguments[ARGUMENT_KEY_EVENTID];
        NSString * eventLabel = call.arguments[ARGUMENT_KEY_EVENTLABEL];
        [[FakeMobileAnalytics shared] trackEvent:eventId eventLabel:eventLabel];
        result(nil);
    } else if ([METHOD_STARTEVENTTRACKING isEqualToString:call.method]) {
        NSString * eventId = call.arguments[ARGUMENT_KEY_EVENTID];
        NSString * eventLabel = call.arguments[ARGUMENT_KEY_EVENTLABEL];
        [[FakeMobileAnalytics shared] startEventTracking:eventId eventLabel:eventLabel];
        result(nil);
    } else if ([METHOD_STOPEVENTTRACKING isEqualToString:call.method]) {
        NSString * eventId = call.arguments[ARGUMENT_KEY_EVENTID];
        NSString * eventLabel = call.arguments[ARGUMENT_KEY_EVENTLABEL];
        [[FakeMobileAnalytics shared] stopEventTracking:eventId eventLabel:eventLabel];
        result(nil);
    } else if ([METHOD_STARTPAGETRACKING isEqualToString:call.method]) {
        NSString * pageName = call.arguments[ARGUMENT_KEY_PAGENAME];
        [[FakeMobileAnalytics shared] startPageTracking:pageName];
        result(nil);
    } else if ([METHOD_STOPPAGETRACKING isEqualToString:call.method]) {
        NSString * pageName = call.arguments[ARGUMENT_KEY_PAGENAME];
        [[FakeMobileAnalytics shared] stopPageTracking:pageName];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
