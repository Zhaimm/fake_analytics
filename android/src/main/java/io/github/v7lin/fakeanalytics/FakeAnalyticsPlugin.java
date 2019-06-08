package io.github.v7lin.fakeanalytics;

import android.text.TextUtils;

import com.tendcloud.tenddata.TCAgent;
import com.tendcloud.tenddata.TDAccount;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

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
    private static final String METHOD_TRACKEVENT = "trackEvent";
    private static final String METHOD_STARTPAGETRACKING = "startPageTracking";
    private static final String METHOD_STOPPAGETRACKING = "stopPageTracking";

    private static final String ARGUMENT_KEY_APPID = "appId";
    private static final String ARGUMENT_KEY_CHANNELID = "channelId";
    private static final String ARGUMENT_KEY_ENABLEDEBUG = "enableDebug";

    private static final String ARGUMENT_KEY_TYPE = "type";
    private static final String ARGUMENT_KEY_UID = "uid";
    private static final String ARGUMENT_KEY_NAME = "name";

    private static final String ARGUMENT_KEY_EVENTID = "eventId";
    private static final String ARGUMENT_KEY_EVENTLABEL = "eventLabel";
    private static final String ARGUMENT_KEY_EVENTPARAMS = "eventParams";

    private static final String ARGUMENT_KEY_PAGENAME = "pageName";

    private final Registrar registrar;

    private FakeAnalyticsPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (METHOD_STARTWORK.equals(call.method)) {
            String appId = call.argument(ARGUMENT_KEY_APPID);
            String channelId = call.argument(ARGUMENT_KEY_CHANNELID);
            boolean enableDebug = call.argument(ARGUMENT_KEY_ENABLEDEBUG);
            TCAgent.init(registrar.context(), appId, channelId);
            TCAgent.setReportUncaughtExceptions(true);
            TCAgent.LOG_ON = enableDebug;
            result.success(null);
        } else if (METHOD_SIGNUP.equals(call.method)) {
            int type = call.argument(ARGUMENT_KEY_TYPE);
            String uid = call.argument(ARGUMENT_KEY_UID);
            String name = call.argument(ARGUMENT_KEY_NAME);
            TCAgent.onRegister(uid, convertToAccountType(type), name);
            result.success(null);
        } else if (METHOD_SIGNIN.equals(call.method)) {
            int type = call.argument(ARGUMENT_KEY_TYPE);
            String uid = call.argument(ARGUMENT_KEY_UID);
            String name = call.argument(ARGUMENT_KEY_NAME);
            TCAgent.onLogin(uid, convertToAccountType(type), name);
            result.success(null);
        } else if (METHOD_TRACKEVENT.equals(call.method)) {
            String eventId = call.argument(ARGUMENT_KEY_EVENTID);
            String eventLabel = call.argument(ARGUMENT_KEY_EVENTLABEL);
            Map<String, Object> eventParams = call.argument(ARGUMENT_KEY_EVENTPARAMS);
            TCAgent.onEvent(registrar.context(), eventId, !TextUtils.isEmpty(eventLabel) ? eventLabel : "", eventParams);
            result.success(null);
        } else if (METHOD_STARTPAGETRACKING.equals(call.method)) {
            String pageName = call.argument(ARGUMENT_KEY_PAGENAME);
            TCAgent.onPageStart(registrar.context(), pageName);
            result.success(null);
        } else if (METHOD_STOPPAGETRACKING.equals(call.method)) {
            String pageName = call.argument(ARGUMENT_KEY_PAGENAME);
            TCAgent.onPageEnd(registrar.context(), pageName);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    private TDAccount.AccountType convertToAccountType(int type) {
        for (TDAccount.AccountType accountType : TDAccount.AccountType.values()) {
            if (accountType.index() == type) {
                return accountType;
            }
        }
        return TDAccount.AccountType.ANONYMOUS;
    }
}
