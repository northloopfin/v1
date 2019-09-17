//
//  CaptureIDController.h
//

#import <UIKit/UIKit.h>
#import "LLSimpleCamera.h"

@class VideoCropView;

@protocol CaptureDelegate <NSObject>

@optional

-(void)capturedImage:(UIImage *)image;

@end

@interface CaptureIDController : UIViewController

@property (nonatomic, strong) id<CaptureDelegate> delegate;

@end
