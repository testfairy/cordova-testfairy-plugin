#import <Cordova/CDVPlugin.h>

@interface CDVTestFairy : CDVPlugin

- (void)begin:(CDVInvokedUrlCommand*)command;
- (void)pushFeedbackController:(CDVInvokedUrlCommand*)command;
- (void)updateLocation:(CDVInvokedUrlCommand*)command;
- (void)checkpoint:(CDVInvokedUrlCommand*)command;
- (void)setCorrelationId:(CDVInvokedUrlCommand*)command;
- (void)pause:(CDVInvokedUrlCommand*)command;
- (void)resume:(CDVInvokedUrlCommand*)command;
- (void)identify:(CDVInvokedUrlCommand*)command;
- (void)log:(CDVInvokedUrlCommand*)command;
- (void)setServerEndpoint:(CDVInvokedUrlCommand*)command;
- (void)hideWebViewElements:(CDVInvokedUrlCommand*)command;
- (void)sendUserFeedback:(CDVInvokedUrlCommand *)command;
- (void)stop:(CDVInvokedUrlCommand *)command;
- (void)setScreenName:(CDVInvokedUrlCommand *)command;
- (void)setUserId:(CDVInvokedUrlCommand *)command;
- (void)setAttribute:(CDVInvokedUrlCommand *)command;
- (void)enableCrashHandler:(CDVInvokedUrlCommand*)command;
- (void)disableCrashHandler:(CDVInvokedUrlCommand*)command;
- (void)enableMetric:(CDVInvokedUrlCommand*)command;
- (void)disableMetric:(CDVInvokedUrlCommand*)command;
- (void)enableVideo:(CDVInvokedUrlCommand*)command;
- (void)disableVideo:(CDVInvokedUrlCommand*)command;
- (void)enableFeedbackForm:(CDVInvokedUrlCommand*)command;
- (void)disableFeedbackForm:(CDVInvokedUrlCommand*)command;
- (void)disableAutoUpdate:(CDVInvokedUrlCommand*)command;
- (void)setMaxSessionLength:(CDVInvokedUrlCommand*)command;
- (void)logException:(CDVInvokedUrlCommand*)command;
- (void)showFeedbackForm:(CDVInvokedUrlCommand*)command;
- (void)installFeedbackHandler:(CDVInvokedUrlCommand*)command;
@end
