#import <EXBrightness/EXBrightness.h>
#import <EXBrightness/EXSystemBrightnessPermissionRequester.h>
#import <ExpoModulesCore/EXUtilities.h>
#import <ExpoModulesCore/EXPermissionsInterface.h>
#import <ExpoModulesCore/EXPermissionsMethodsDelegate.h>

#import <UIKit/UIKit.h>

@interface EXBrightness ()

@property (nonatomic, weak) id<EXPermissionsInterface> permissionsManager;

@end

@implementation EXBrightness

EX_EXPORT_MODULE(ExpoBrightness);

- (void)setModuleRegistry:(EXModuleRegistry *)moduleRegistry
{
  _permissionsManager = [moduleRegistry getModuleImplementingProtocol:@protocol(EXPermissionsInterface)];
  [EXPermissionsMethodsDelegate registerRequesters:@[[EXSystemBrightnessPermissionRequester new]] withPermissionsManager:_permissionsManager];
}

EX_EXPORT_METHOD_AS(getPermissionsAsync,
                    getPermissionsAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  [EXPermissionsMethodsDelegate getPermissionWithPermissionsManager:_permissionsManager
                                                      withRequester:[EXSystemBrightnessPermissionRequester class]
                                                            resolve:resolve
                                                             reject:reject];
}

EX_EXPORT_METHOD_AS(requestPermissionsAsync,
                    requestPermissionsAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  [EXPermissionsMethodsDelegate askForPermissionWithPermissionsManager:_permissionsManager
                                                         withRequester:[EXSystemBrightnessPermissionRequester class]
                                                               resolve:resolve
                                                                reject:reject];
}

EX_EXPORT_METHOD_AS(setBrightnessAsync,
                    setBrightnessAsync:(NSNumber *)brightnessValue
                    resolver:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  [EXUtilities performSynchronouslyOnMainThread:^{
    [UIScreen mainScreen].brightness = [brightnessValue floatValue];
  }];
  resolve(nil);
}

EX_EXPORT_METHOD_AS(getBrightnessAsync,
                    getBrightnessAsyncWithResolver:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  __block float result = 0;
  [EXUtilities performSynchronouslyOnMainThread:^{
    result = [UIScreen mainScreen].brightness;
  }];
  resolve(@(result));
}

EX_EXPORT_METHOD_AS(getSystemBrightnessAsync,
                    getSystemBrightnessAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

EX_EXPORT_METHOD_AS(setSystemBrightnessAsync,
                    setSystemBrightnessAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

EX_EXPORT_METHOD_AS(useSystemBrightnessAsync,
                    useSystemBrightnessAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

EX_EXPORT_METHOD_AS(isUsingSystemBrightnessAsync,
                    isUsingSystemBrightnessAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

EX_EXPORT_METHOD_AS(getSystemBrightnessModeAsync,
                    getSystemBrightnessModeAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

EX_EXPORT_METHOD_AS(setSystemBrightnessModeAsync,
                    setSystemBrightnessModeAsync:(EXPromiseResolveBlock)resolve
                    rejecter:(EXPromiseRejectBlock)reject)
{
  // stub for jest-expo-mock-generator
}

@end
