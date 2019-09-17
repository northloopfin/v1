//
//  HomeViewController.m
//  
 
#import "CaptureIDController.h"
#import "ViewUtils.h"

@interface CaptureIDController (){
}

@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *snapButton;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIView *vwContainer;
@property (weak, nonatomic) IBOutlet UIView *vwRecordingArea;

@end

@implementation CaptureIDController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // ----- initialize camera -------- //
    
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPreset1280x720
                                                 position:LLCameraPositionRear
                                             videoEnabled:NO];
    
    // attach to a view controller
    [self.camera attachToViewController:self parentView:self.vwContainer withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.width)];
    self.camera.view.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.width);

    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    // you probably will want to set this to YES, if you are going view the image outside iOS.
    self.camera.fixOrientationAfterCapture = NO;
    
    // take the required actions on a device change
    __weak typeof(self) weakSelf = self;
//    [self.camera setOnDeviceChange:^(LLSimpleCamera *camera, AVCaptureDevice * device) {
//
//        NSLog(@"Device changed.");
        // device changed, check if flash is available
//        if([camera isFlashAvailable]) {
//            weakSelf.flashButton.hidden = NO;
//
//            if(camera.flash == LLCameraFlashOff) {
//                weakSelf.flashButton.selected = NO;
//            }
//            else {
//                weakSelf.flashButton.selected = YES;
//            }
//        }
//        else {
//            weakSelf.flashButton.hidden = YES;
//        }
//    }];
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
                
                if(weakSelf.errorLabel) {
                    [weakSelf.errorLabel removeFromSuperview];
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = @"We need permission for the camera.\nPlease go to your settings.";
                label.numberOfLines = 2;
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = NSTextAlignmentCenter;
                [label sizeToFit];
                label.center = CGPointMake(screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);
                weakSelf.errorLabel = label;
                [weakSelf.view addSubview:weakSelf.errorLabel];
            }
        }
    }];

    
    if([LLSimpleCamera isFrontCameraAvailable] && [LLSimpleCamera isRearCameraAvailable]) {
    }else{
        self.switchButton.hidden = YES;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // start the camera
    [self.camera start];
    self.snapButton.selected = NO;
    self.snapButton.enabled = YES;
}

/* camera button methods */

- (IBAction)switchButtonPressed:(UIButton *)button
{
    [self.camera togglePosition];
}

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)flashButtonPressed:(UIButton *)button
{
    if(self.camera.flash == LLCameraFlashOff) {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOn];
        if(done) {
            self.flashButton.selected = YES;
            self.flashButton.tintColor = [UIColor yellowColor];
        }
    }
    else {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOff];
        if(done) {
            self.flashButton.selected = NO;
            self.flashButton.tintColor = [UIColor whiteColor];
        }
    }
}

- (IBAction)snapButtonPressed:(UIButton *)button
{
//    __weak typeof(self) weakSelf = self;
    
        [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
            if(!error) {
                CGRect fr = self.vwRecordingArea.frame;
//                fr.origin.y -= STATUS_BAR*2;
                fr.origin.x *= [UIScreen mainScreen].scale;
                fr.origin.y *= [UIScreen mainScreen].scale;
                fr.size.width *= [UIScreen mainScreen].scale;
                fr.size.height = fr.size.width * 0.7;
                fr.origin.y -= [[UIApplication sharedApplication] statusBarFrame].size.height;

                CGImageRef imageRef = CGImageCreateWithImageInRect([[self normalizedImage:image] CGImage], fr);
                UIImage *editedImage = [UIImage imageWithCGImage:imageRef];
                [self.delegate capturedImage:editedImage];
                CGImageRelease(imageRef);
                [self dismissViewControllerAnimated:YES completion:nil];

            }
            else {
                NSLog(@"An error has occured: %@", error);
            }
        } exactSeenImage:YES];
}

- (UIImage *)normalizedImage:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

/* other lifecycle methods */

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.camera.view.frame = self.view.contentBounds;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
