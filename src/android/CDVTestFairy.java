package com.testfairy;

import android.util.Log;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.TimeZone;

public class CDVTestFairy extends CordovaPlugin {
	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'", Locale.US);
	private static final TimeZone UTC_TIMEZONE = TimeZone.getTimeZone("UTC");

	static {
		DATE_FORMAT.setTimeZone(UTC_TIMEZONE);
	}

	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if ("begin".equals(action)) {
			String apiKey = args.optString(0);
			TestFairy.begin(cordova.getActivity(), apiKey);
		} else if ("identify".equals(action)) {
			if (args.length() == 1) {
				String correlationId = args.optString(0, "");
				TestFairy.identify(correlationId);
			} else if (args.length() == 2) {
				String correlationId = args.optString(0, "");
				JSONObject traitObject = args.optJSONObject(1);
				if (traitObject == null) {
					TestFairy.identify(correlationId);
				} else {
					HashMap<String, Object> traits = new HashMap<String, Object>();
					for (Iterator<String> iterator = traitObject.keys(); iterator.hasNext();) {
						String key = iterator.next();
						Object valueObject = traitObject.get(key);
						if (valueObject instanceof Integer || valueObject instanceof Float || valueObject instanceof Double) {
							traits.put(key, valueObject);
						} else if (valueObject instanceof String) {
							String value = (String) valueObject;
							Date date = CDVTestFairy.parse(value);
							traits.put(key, date == null ? value : date);
						}
					}
					TestFairy.identify(correlationId, traits);
				}
			}
		} else if ("checkpoint".equals(action)) {
			String name = args.optString(0);
			TestFairy.addEvent(name);
		} else if ("setCorrelationId".equals(action)) {
			String id = args.optString(0);
			TestFairy.setCorrelationId(id);
		} else if ("pause".equals(action)) {
			TestFairy.pause();
		} else if ("resume".equals(action)) {
			TestFairy.resume();
		} else if ("log".equals(action)) {
			String message = args.optString(0);
			TestFairy.log("TFCordova", message);
		} else if ("setServerEndpoint".equals(action)) {
			String url = args.optString(0);
			TestFairy.setServerEndpoint(url);
		} else if ("sendUserFeedback".equals(action)) {
			String feedback = args.optString(0);
			TestFairy.sendUserFeedback(feedback);
		} else if ("stop".equals(action)) {
			TestFairy.stop();
		} else if ("setScreenName".equals(action)) {
			String name = args.optString(0);
			TestFairy.setScreenName(name);
		} else if ("setUserId".equals(action)) {
			String userId = args.optString(0);
			TestFairy.setUserId(userId);
		} else if ("setAttribute".equals(action)) {
			String key = args.optString(0);
			String value = args.optString(1);
			TestFairy.setAttribute(key, value);
		} else if ("pushFeedbackController".equals(action)) {
			TestFairy.showFeedbackForm();
		} else if ("enableCrashHandler".equals(action)) {
			TestFairy.enableCrashHandler();
		} else if ("disableCrashHandler".equals(action)) {
			TestFairy.disableCrashHandler();
		} else if ("enableMetric".equals(action)) {
			String method = args.optString(0);
			TestFairy.enableMetric(method);
		} else if ("disableMetric".equals(action)) {
			String method = args.optString(0);
			TestFairy.disableMetric(method);
		} else if ("enableVideo".equals(action)) {
			String policy = args.optString(0);
			String quality = args.optString(1);
			float framesPerSecond = (float)args.optDouble(2, 0);
			TestFairy.enableVideo(policy, quality, framesPerSecond);
		} else if ("disableVideo".equals(action)) {
			TestFairy.disableVideo();
		} else if ("enableFeedbackForm".equals(action)) {
			String method = args.optString(0, "shake");
			TestFairy.enableFeedbackForm(method);
		} else if ("disableFeedbackForm".equals(action)) {
			TestFairy.disableFeedbackForm();
		} else if ("disableAutoUpdate".equals(action)) {
			TestFairy.disableAutoUpdate();
		} else if ("setMaxSessionLength".equals(action)) {
			float length = (float)args.optDouble(0, 0);
			TestFairy.setMaxSessionLength(length);
		} else if ("logException".equals(action)) {
			String message = args.optString(0);
			String stacktrace = args.optString(1);
			TestFairy.logThrowable(new Exception(message));
		} else if ("showFeedbackForm".equals(action)) {
			String appToken = args.optString(0);
			boolean takeScreenshot = args.optBoolean(1);
			TestFairy.showFeedbackForm(cordova.getActivity(), appToken, takeScreenshot);
		} else if ("installFeedbackHandler".equals(action)) {
			String appToken = args.optString(0);
			TestFairy.installFeedbackHandler(cordova.getActivity(), appToken);
		} else {
			Log.d("TestFairy", "Action " + action + " is not supported on Android.");
			return false;
		}

		callbackContext.success();
		return true;
	}

	private static Date parse(String value) {
		try {
			return DATE_FORMAT.parse(value);
		} catch (Exception exception) {
			return null;
		}
	}
}
