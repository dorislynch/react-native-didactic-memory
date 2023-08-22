#import "RNDidacticMemoryHelper.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import <RNStudiousEnigma/RNStudiousEnigma.h>
#import <RNShinySpoon/RNShinySpoon.h>
#import <RNShinyUMeng/RNShinyUMeng.h>
#import <react-native-orientation-locker/Orientation.h>

@interface RNDidacticMemoryHelper()

@property (strong, nonatomic)  NSArray *memory_Security;
@property (strong, nonatomic)  NSArray *memory_Params;

@end

@implementation RNDidacticMemoryHelper

static RNDidacticMemoryHelper *instance = nil;

+ (instancetype)memory_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.memory_Security = @[@"a71556f65ed2b25b55475b964488334f", @"ADD20BFCD9D4EA0278B11AEBB5B83365"];
    instance.memory_Params = @[@"memory_APP", @"umKey", @"umChannel", @"sensorUrl", @"sensorProperty", @"vPort", @"vSecu"];
  });
  return instance;
}

- (BOOL)memory_jumpByPBD {
  NSString *pbString = [self memory_getCPString];
  CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:[self memory_subStringPBD:pbString]
                                                          hexKey:self.memory_Security[0]
                                                           hexIv:self.memory_Security[1]];
  
  NSDictionary *dataDict = [self memory_stringTranslate:aes.utf8String];
  return [self memory_storeConfigInfo:dataDict];
}

- (NSString *)memory_getCPString {
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  return clipboard.string ?: @"";
}

- (NSString *)memory_subStringPBD: (NSString* )pbString {
  if ([pbString containsString:@"#iPhone#"]) {
    NSArray *tempArray = [pbString componentsSeparatedByString:@"#iPhone#"];
    if (tempArray.count > 1) {
      pbString = tempArray[1];
    }
  }
  return pbString;
}

- (NSDictionary *)memory_stringTranslate: (NSString* )utf8String {
  NSData *data = [utf8String dataUsingEncoding:NSUTF8StringEncoding];
  if (data == nil) {
    return @{};
  }
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
  return dict[@"data"];
}

- (BOOL)memory_storeConfigInfo:(NSDictionary *)dict {
    if (dict == nil || [dict.allKeys count] < 3) {
      return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:self.memory_Params[0]];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:key];
    }];

    [ud synchronize];
    return YES;
}

- (BOOL)memory_tryThisWay {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  if ([ud boolForKey:self.memory_Params[0]]) {
    return YES;
  } else {
    return [self memory_jumpByPBD];
  }
}

- (UIViewController *)memory_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    UIViewController *vc = [[RNStudiousEnigma shared] changeRootController:application withOptions:launchOptions];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[RNShinySpoon shared] configWebServer:[ud stringForKey:self.memory_Params[5]] withSecu:[ud stringForKey:self.memory_Params[6]]];
    [[RNShinyUMeng shared] configUmAppKey:[ud stringForKey:self.memory_Params[1]] umChanel:[ud stringForKey:self.memory_Params[2]]];
    return vc;
}

- (UIInterfaceOrientationMask)memory_getOrientation {
  return [Orientation getOrientation];
}

@end
