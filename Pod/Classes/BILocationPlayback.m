#import "BILocationPlayback.h"
#import "BILocationPlaybackMainViewController.h"
#import "BILocationPlaybackConfiguration.h"
#import "BITripPlaybackPreview.h"
#import "BITrip.h"

@implementation BILocationPlayback {
    UIViewController *_previousVC;
    BILocationPlaybackMainViewController *_locationPlaybackMainVC;
    BILocationPlaybackConfiguration *_configuration;

}

- (instancetype)init {
    self = [super init];
    if (self) {
        _configuration = [BILocationPlaybackConfiguration new];
    }

    return self;
}


+ (BILocationPlayback *)instance {
    static BILocationPlayback *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

-(void) show {
    UIWindow *window = [self getWindow];
    _previousVC = window.rootViewController;
    _locationPlaybackMainVC = [[BILocationPlaybackMainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_locationPlaybackMainVC];
    [window.rootViewController presentViewController:navigationController animated:YES completion:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(closeLocationPlaybackVC:)];
    _locationPlaybackMainVC.navigationItem.rightBarButtonItem = doneButton;

}

- (void)showMiniMapPlayback {
    UIWindow *window = [self getWindow];

    BITrip *trip = [[BITrip alloc] initWithStartDate:[NSDate date] endDate:nil entries:nil name:@"test"];
    __weak BITripPlayback *playback = [[BITripPlayback alloc] initWithTrip:trip];

    BITripPlaybackPreview *previewMap = [[BITripPlaybackPreview alloc] initWithTripPlayback:playback gesturesEnabled:YES];
    previewMap.frame = CGRectMake(0, 0, 200, 200);
    [window.rootViewController.view addSubview:previewMap];
}

- (UIWindow *)getWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window;
}

- (void)closeLocationPlaybackVC:(id)closeLocationPlaybackVC {
    [self hide];
}

-(void) hide {
    UIWindow *window = [self getWindow];
    [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(BILocationPlaybackConfiguration *) getConfiguration {
    return _configuration;
}

@end