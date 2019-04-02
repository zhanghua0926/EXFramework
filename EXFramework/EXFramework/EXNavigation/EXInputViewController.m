//
//  EXInputViewController.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXInputViewController.h"

@interface EXInputViewController ()

@end

@implementation EXInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoresizesForKeyboard = YES;
    
    self.frameView = [[UIView alloc] initWithFrame:self.view.frame];
    self.frameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_frameView];
}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    UIView *view = _frameView;
    [self.frameView removeFromSuperview];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:backgroundImage];
    img.frame = self.view.frame;
    [self.view addSubview:img];
    
    self.frameView = view;
    [self.view addSubview:_frameView];
}


- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardWillAppear:animated withBounds:bounds];
    
    self.frameView.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardWillDisappear:animated withBounds:bounds];
    
    self.frameView.frame = CGRectMake(0, -0, self.view.frame.size.width, self.view.frame.size.height);
}


#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
