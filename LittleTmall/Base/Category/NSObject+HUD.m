//
//  NSObject+HUD.m
//  qisudai
//
//  Created by wzh on 17/3/14.
//
//

#import "NSObject+HUD.h"
#import <objc/runtime.h>

#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;


@implementation NSObject (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}
- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)show_objectHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}



- (void)showHint_object:(NSString *)hint{
    [self showHint_object:hint yOffset:0];
}

- (void)showHint_object:(NSString *)hint yOffset:(float)yOffset {
    [self showHint_object:hint yOffset:yOffset andAfterDelay:2 view:nil];
}

- (void)showHint_object:(NSString *)hint view:(UIView *)view{
    [self showHint_object:hint yOffset:-1 andAfterDelay:2 view:view];
}
- (void)showHint_object:(NSString *)hint yOffset:(float)yOffset view:(UIView *)view{
    [self showHint_object:hint yOffset:yOffset andAfterDelay:2 view:view];
}

- (void)showHint_object:(NSString *)hint yOffset:(float)yOffset andAfterDelay:(NSTimeInterval)delay view:(UIView *)view{
    //显示提示信息
    if(!view){
        view = [[UIApplication sharedApplication].delegate window];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    if(yOffset !=0){
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(hud.offset.x, yOffset);
    }else{
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(hud.offset.x, IS_IPHONE_5?200.f:100.f);
    }
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)hideHudInView:(UIView *)view{
    
    for (UIView *subView in view.subviews) {
        if([subView isKindOfClass:[MBProgressHUD class]]){
            [subView removeFromSuperview];
        }
    }
    [[self HUD] hideAnimated:YES];
}

+ (void)load
{
    
#ifdef DEBUG
    Method  systemM = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method changeM = class_getInstanceMethod([self class], @selector(viewDidLoad_Log));
    BOOL isAdd = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(changeM), method_getTypeEncoding(changeM));
    if (isAdd) {
        // 如果成功 说明类中并不存在这个方法的实现
        class_replaceMethod([self class], @selector(viewDidLoad_Log), method_getImplementation(systemM), method_getTypeEncoding(systemM));
    } else {
        method_exchangeImplementations(systemM, changeM);
    }
#endif
}
- (void)viewDidLoad_Log
{
    [self viewDidLoad_Log];
    NSLog(@"当前控制器:%@", NSStringFromClass([self class]));
}
@end
