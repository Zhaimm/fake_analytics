package io.github.v7lin.fakeanalytics;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import mobile.analytics.android.MobileAnalytics;

/**
 * FakeAnalyticsPlugin
 */
public class FakeAnalyticsPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "v7lin.github.io/fake_analytics");
        FakeAnalyticsPlugin plugin = new FakeAnalyticsPlugin(registrar);
        channel.setMethodCallHandler(plugin);
    }

    private static final String METHOD_STARTWORK = "startWork";
    private static final String METHOD_SIGNUP = "signUp";
    private static final String METHOD_SIGNIN = "signIn";
    private static final String METHOD_SIGNOUT = "signOut";
    private static final String METHOD_TRACKEVENT = "trackEvent";
    private static final String METHOD_STARTEVENTTRACKING = "startEventTracking";
    private static final String METHOD_STOPEVENTTRACKING = "stopEventTracking";
    private static final String METHOD_STARTPAGETRACKING = "startPageTracking";
    private static final String METHOD_STOPPAGETRACKING = "stopPageTracking";

    private static final String ARGUMENT_KEY_APPKEY = "appKey";
    private static final String ARGUMENT_KEY_APPCHANNEL = "appChannel";
    private static final String ARGUMENT_KEY_ENABLEDEBUG = "enableDebug";

    private static final String ARGUMENT_KEY_USERID = "userId";
    private static final String ARGUMENT_KEY_USERNICK = "userNick";

    private static final String ARGUMENT_KEY_EVENTID = "eventId";
    private static final String ARGUMENT_KEY_EVENTLABEL = "eventLabel";

    private static final String ARGUMENT_KEY_PAGENAME = "pageName";

    private final Registrar registrar;

    private FakeAnalyticsPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (METHOD_STARTWORK.equals(call.method)) {
            String appKey = call.argument(ARGUMENT_KEY_APPKEY);
            String appChannel = call.argument(ARGUMENT_KEY_APPCHANNEL);
            boolean enableDebug = call.argument(ARGUMENT_KEY_ENABLEDEBUG);
            MobileAnalytics.with(registrar.context()).startWork(appKey, appChannel, enableDebug);
            result.success(null);
        } else if (METHOD_SIGNUP.equals(call.method)) {
            String userId = call.argument(ARGUMENT_KEY_USERID);
            String userNick = call.argument(ARGUMENT_KEY_USERNICK);
            MobileAnalytics.with(registrar.context()).signUp(userId, userNick);
            result.success(null);
        } else if (METHOD_SIGNIN.equals(call.method)) {
            String userId = call.argument(ARGUMENT_KEY_USERID);
            String userNick = call.argument(ARGUMENT_KEY_USERNICK);
            MobileAnalytics.with(registrar.context()).signIn(userId, userNick);
            result.success(null);
        } else if (METHOD_SIGNOUT.equals(call.method)) {
            MobileAnalytics.with(registrar.context()).signOut();
            result.success(null);
        } else if (METHOD_TRACKEVENT.equals(call.method)) {
            String eventId = call.argument(ARGUMENT_KEY_EVENTID);
            String eventLabel = call.argument(ARGUMENT_KEY_EVENTLABEL);
            MobileAnalytics.with(registrar.context()).trackEvent(eventId, eventLabel);
            result.success(null);
        } else if (METHOD_STARTEVENTTRACKING.equals(call.method)) {
            String eventId = call.argument(ARGUMENT_KEY_EVENTID);
            String eventLabel = call.argument(ARGUMENT_KEY_EVENTLABEL);
            MobileAnalytics.with(registrar.context()).startEventTracking(eventId, eventLabel);
            result.success(null);
        } else if (METHOD_STOPEVENTTRACKING.equals(call.method)) {
            String eventId = call.argument(ARGUMENT_KEY_EVENTID);
            String eventLabel = call.argument(ARGUMENT_KEY_EVENTLABEL);
            MobileAnalytics.with(registrar.context()).stopEventTracking(eventId, eventLabel);
            result.success(null);
        } else if (METHOD_STARTPAGETRACKING.equals(call.method)) {
            String pageName = call.argument(ARGUMENT_KEY_PAGENAME);
            MobileAnalytics.with(registrar.context()).startPageTracking(pageName);
            result.success(null);
        } else if (METHOD_STOPPAGETRACKING.equals(call.method)) {
            String pageName = call.argument(ARGUMENT_KEY_PAGENAME);
            MobileAnalytics.with(registrar.context()).stopPageTracking(pageName);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }
}
