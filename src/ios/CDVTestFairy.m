#import "CDVTestFairy.h"
#import <TestFairy/TestFairy.h>
#import <CoreLocation/CoreLocation.h>
#import <Cordova/CDVPluginResult.h>

@implementation CDVTestFairy

- (void)begin:(CDVInvokedUrlCommand*)command
{
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *APIKey = [arguments objectAtIndex:0];
		[TestFairy begin:APIKey];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"API Key is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)pushFeedbackController:(CDVInvokedUrlCommand*)command
{
	[TestFairy pushFeedbackController];
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)updateLocation:(CDVInvokedUrlCommand*)command
{
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0)
	{
		NSDictionary *locationData = [arguments firstObject];
		NSDictionary *coord = [locationData objectForKey:@"coords"];
		CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([[coord objectForKey:@"latitude"] doubleValue], [[coord objectForKey:@"longitude"] doubleValue])
															 altitude:[[coord objectForKey:@"altitude"] longValue]
												   horizontalAccuracy:[[coord objectForKey:@"accuracy"] longValue]
													 verticalAccuracy:[[coord objectForKey:@"altitudeAccuracy"] doubleValue]
															timestamp:[NSDate date]];
		[TestFairy updateLocation:[NSArray arrayWithObject:location]];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"location is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)checkpoint:(CDVInvokedUrlCommand*)command
{
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {

		NSString *name = [arguments objectAtIndex:0];
		[TestFairy checkpoint:name];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"name is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setCorrelationId:(CDVInvokedUrlCommand*)command
{
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {

		NSString *correlationId = [arguments objectAtIndex:0];
		[TestFairy setCorrelationId:correlationId];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"correlation ID is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)pause:(CDVInvokedUrlCommand*)command
{
	[TestFairy pause];
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)resume:(CDVInvokedUrlCommand*)command
{
	[TestFairy resume];
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)identify:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] <= 0) {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Correlation ID cannot be empty"];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}

	NSString *correlationId = [arguments objectAtIndex:0];
	NSDictionary *traitValues = [command argumentAtIndex:1 withDefault:@{}];
	if ([traitValues count] == 0) {
		[TestFairy identify:correlationId];
	} else {
//		NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
//		NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
//		[_dateFormatter setLocale:enUSPOSIXLocale];
//		[_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'"];
//
//		NSMutableDictionary *traits = [NSMutableDictionary dictionaryWithCapacity:[traitValues count]];
//		for (NSString* key in traitValues) {
//			id value = [traitValues objectForKey:key];
//			NSDate *date = [_dateFormatter dateFromString:value];
//			[traits setObject:(date == nil ? value : date) forKey:key];
//		}
		[TestFairy identify:correlationId traits:traitValues];
	}

	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)log:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *message = [arguments objectAtIndex:0];
		TFLog(@"%@", message);
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"message is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setServerEndpoint:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *url = [arguments objectAtIndex:0];
		[TestFairy setServerEndpoint:url];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"url is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)hideWebViewElements:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *cssSelector = [arguments objectAtIndex:0];
		[TestFairy hideWebViewElements:cssSelector];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"selector is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)sendUserFeedback:(CDVInvokedUrlCommand *)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *feedback = [arguments objectAtIndex:0];
		[TestFairy sendUserFeedback:feedback];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"feedback is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stop:(CDVInvokedUrlCommand *)command  {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy stop];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setScreenName:(CDVInvokedUrlCommand *)command  {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *name = [arguments objectAtIndex:0];
		[TestFairy setScreenName:name];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"screen name is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUserId:(CDVInvokedUrlCommand *)command  {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 0) {
		NSString *userId = [arguments objectAtIndex:0];
		[TestFairy setUserId:userId];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"userId is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setAttribute:(CDVInvokedUrlCommand *)command  {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = nil;

	if ([arguments count] > 1) {
		NSString *key = [arguments objectAtIndex:0];
		NSString *value = [arguments objectAtIndex:1];
		[TestFairy setAttribute:key withValue:value];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"key and value are missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)enableCrashHandler:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy enableCrashHandler];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)disableCrashHandler:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy disableCrashHandler];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)enableMetric:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 0) {
		NSString *metric = [arguments objectAtIndex:0];
		[TestFairy enableMetric:metric];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"metric is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)disableMetric:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 0) {
		NSString *metric = [arguments objectAtIndex:0];
		[TestFairy disableMetric:metric];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"metric is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)enableVideo:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 2) {
		NSString *policy = [arguments objectAtIndex:0];
		NSString *quality = [arguments objectAtIndex:1];
		float framesPerSecond = [[arguments objectAtIndex:2] floatValue];
		[TestFairy enableVideo:policy quality:quality framesPerSecond:framesPerSecond];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"arguments are missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)disableVideo:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy disableVideo];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)enableFeedbackForm:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 0) {
		NSString *method = [arguments objectAtIndex:0];
		[TestFairy enableFeedbackForm:method];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"method is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)disableFeedbackForm:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy disableFeedbackForm];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)disableAutoUpdate:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	[TestFairy disableAutoUpdate];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setMaxSessionLength:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 0) {
		float length = [[arguments objectAtIndex:0] floatValue];
		[TestFairy setMaxSessionLength:length];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"length is missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)logException:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 1) {
		NSString *message = [arguments objectAtIndex:0];
		NSString *trace = [arguments objectAtIndex:1];
		NSError *error = [NSError errorWithDomain:@"com.testfairy.cordova" code:-1 userInfo:@{NSLocalizedDescriptionKey: message}];
		[TestFairy logError:error stacktrace:[trace componentsSeparatedByString:@"\n"]];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"arguments are missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)showFeedbackForm:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 1) {
		NSString *appToken = [arguments objectAtIndex:0];
		BOOL takeScreenshot = [[arguments objectAtIndex:1] boolValue];
		[TestFairy showFeedbackForm:appToken takeScreenshot:takeScreenshot];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"arguments are missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)installFeedbackHandler:(CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

	if ([arguments count] > 0) {
		NSString *appToken = [arguments objectAtIndex:0];
		[TestFairy installFeedbackHandler:appToken method:@"shake|screenshot"];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"arguments are missing"];
	}

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
