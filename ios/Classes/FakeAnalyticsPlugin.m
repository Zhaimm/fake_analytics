#import "FakeAnalyticsPlugin.h"
#import <FakeTalkingdataAnalytics/TalkingData.h>

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
static NSString * const METHOD_TRACKEVENT = @"trackEvent";
static NSString * const METHOD_STARTPAGETRACKING = @"startPageTracking";
static NSString * const METHOD_STOPPAGETRACKING = @"stopPageTracking";

static NSString * const ARGUMENT_KEY_APPID = @"appId";
static NSString * const ARGUMENT_KEY_CHANNELID = @"channelId";
static NSString * const ARGUMENT_KEY_ENABLEDEBUG = @"enableDebug";

static NSString * const ARGUMENT_KEY_TYPE = @"type";
static NSString * const ARGUMENT_KEY_UID = @"uid";
static NSString * const ARGUMENT_KEY_NAME = @"name";

static NSString * const ARGUMENT_KEY_EVENTID = @"eventId";
static NSString * const ARGUMENT_KEY_EVENTLABEL = @"eventLabel";
static NSString * const ARGUMENT_KEY_EVENTPARAMS = @"eventParams";

static NSString * const ARGUMENT_KEY_PAGENAME = @"pageName";

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([METHOD_STARTWORK isEqualToString:call.method]) {
        NSString * appId = call.arguments[ARGUMENT_KEY_APPID];
        NSString * channelId = call.arguments[ARGUMENT_KEY_CHANNELID];
        NSNumber * enableDebug = call.arguments[ARGUMENT_KEY_ENABLEDEBUG];
        [TalkingData sessionStarted:appId withChannelId:channelId];
        [TalkingData setExceptionReportEnabled:YES];
        [TalkingData setLogEnabled:enableDebug.boolValue];
        result(nil);
    } else if ([METHOD_SIGNUP isEqualToString:call.method]) {
        NSNumber * type = call.arguments[ARGUMENT_KEY_TYPE];
        NSString * uid = call.arguments[ARGUMENT_KEY_UID];
        NSString * name = call.arguments[ARGUMENT_KEY_NAME];
        [TalkingData onRegister:uid type:type.unsignedIntegerValue name:name];
        result(nil);
    } else if ([METHOD_SIGNIN isEqualToString:call.method]) {
        NSNumber * type = call.arguments[ARGUMENT_KEY_TYPE];
        NSString * uid = call.arguments[ARGUMENT_KEY_UID];
        NSString * name = call.arguments[ARGUMENT_KEY_NAME];
        [TalkingData onLogin:uid type:type.unsignedIntegerValue name:name];
        result(nil);
    } else if ([METHOD_TRACKEVENT isEqualToString:call.method]) {
        NSString * eventId = call.arguments[ARGUMENT_KEY_EVENTID];
        NSString * eventLabel = call.arguments[ARGUMENT_KEY_EVENTLABEL];
        NSDictionary * eventParams = call.arguments[ARGUMENT_KEY_EVENTPARAMS];
        [TalkingData trackEvent:eventId label:eventLabel parameters:eventParams];
        result(nil);
    } else if ([METHOD_STARTPAGETRACKING isEqualToString:call.method]) {
        NSString * pageName = call.arguments[ARGUMENT_KEY_PAGENAME];
        [TalkingData trackPageBegin:pageName];
        result(nil);
    } else if ([METHOD_STOPPAGETRACKING isEqualToString:call.method]) {
        NSString * pageName = call.arguments[ARGUMENT_KEY_PAGENAME];
        [TalkingData trackPageEnd:pageName];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
