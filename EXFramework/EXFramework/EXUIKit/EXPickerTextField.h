//
//  EXPickerTextField.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXPickerTextField;

@protocol EXPickerTextFieldDelegate <NSObject>

@optional
- (void)pickerText:(EXPickerTextField *_Nullable)pickerText indexRow:(NSInteger)row doneButtonPressed:(UIBarButtonItem *_Nullable)sender;

- (void)pickerText:(EXPickerTextField *_Nullable)pickerText cancelButtonPressed:(UIBarButtonItem *_Nullable)sender;

@end


@interface EXPickerTextField : UIView

@property (nonatomic, weak) id<EXPickerTextFieldDelegate> _Nullable delegate;

@property (nonatomic, strong) NSArray * _Nullable titles;

@property (nonatomic, strong) UIFont * _Nullable textFont;

@property (nonatomic, copy) NSString * _Nullable placeHolder;

@property (nonatomic, assign, readonly) NSInteger  * _Nullable selectedRow;

@property (nonatomic, assign, readonly) NSInteger  * _Nullable selectedCompont;

@end

