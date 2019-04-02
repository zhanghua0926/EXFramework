//
//  EXPickerTextField.m
//  EXFrameWork
//
//  Created by Eric on 2019/1/23.
//  Copyright © 2019 icety. All rights reserved.
//

#import "EXPickerTextField.h"

@interface EXPickerTextField ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UITextField *textView;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, copy) NSString *contentText;

@end


@implementation EXPickerTextField
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createContentView];
    }
    
    return self;
}


- (void)createContentView {
    self.textView = [[UITextField alloc] initWithFrame:self.bounds];
    self.textView.font = self.textFont;
    [self addSubview:_textView];
    
    _pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.textView.inputView = _pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.textView.inputAccessoryView = toolBar;
}


- (void)setTextFont:(UIFont *)textFont {
    self.textView.font = textFont;
}


- (void)setPlaceHolder:(NSString *)placeHolder {
    self.textView.placeholder = placeHolder;
}


- (void)cancelTouched:(UIBarButtonItem *)sender {
    // hide the picker view
    [self.textView resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(pickerText:cancelButtonPressed:)]) {
        [self.delegate pickerText:self cancelButtonPressed:sender];
    }
}


- (void)doneTouched:(UIBarButtonItem *)sender {
    // hide the picker view
    [self.textView resignFirstResponder];
    
    self.textView.text = self.contentText;
    if (!_contentText) {
        self.textView.text = _titles.firstObject;
    }
    //    [self.textView contentSizeToFit];
    
    if ([self.delegate respondsToSelector:@selector(pickerText:indexRow:doneButtonPressed:)]) {
        [self.delegate pickerText:self indexRow:[_titles indexOfObject:_textView.text] doneButtonPressed:sender];
    }
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _titles.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _titles[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (!_titles) return;
    
    self.contentText = _titles[row];
}

@end

