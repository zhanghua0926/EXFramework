//
//  EXBaseViewController.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/22.
//  Copyright © 2019 icety. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, NavBarStyle) {
    NavBarStyleNone             = 0,
    NavBarStyleBack             = 1 << 0,
    NavBarStyleHome             = 2 << 0,
};


@interface EXBaseViewController : UIViewController

/**
 Back button.
 */
@property (nonatomic, strong) UIButton *backBtn;
/**
 The current controller that required data from other view controller.
 */
@property (nonatomic, strong) id controllerData;
/**
 * Determines if the view will be resized automatically to fit the keyboard.
 */
@property (nonatomic) BOOL autoresizesForKeyboard;
/**
 View will appear.
 */
@property (nonatomic) BOOL isViewWillAppear;
/**
 View did appear.
 */
@property (nonatomic) BOOL isViewDidAppear;
/**
 View will disappear.
 */
@property (nonatomic) BOOL isViewWillDisappear;
/**
 View did disappear.
 */
@property (nonatomic) BOOL isViewDidDisappear;


/**
 Initialize required the view controller with data.

 @param data Will be display controller's data.
 @return View controller.
 */
- (instancetype)initWithData:(id)data;


/**
 * Sent to the controller before the keyboard slides in.
 */
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds;


/**
 * Sent to the controller before the keyboard slides out.
 */
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds;


/**
 * Sent to the controller after the keyboard has slid in.
 */
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds;


/**
 * Sent to the controller after the keyboard has slid out.
 */
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds;


/**
 Show navigation bar.
 
 @return Yes/No.
 */
- (BOOL)showNavigationBar;


/**
 Show back bar button.
 
 @param show Whehter the show back bar button, YES display, NO hidden.
 */
- (void)showNavBackBtn:(BOOL)show;


/**
 Navigate to last view controller.
 */
- (void)navBack;


/**
 Push view controller to front.
 
 @param controller UIViewcontroller.
 @param animated Animated.
 */
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;


/**
 Pop current controller from navigation stack.
 */
- (void)popViewcontroller;


/**
 Remove all controller but home and current.
 */
- (void)removeAllController;

@end

