//
//  ViewController.m
//  EXFramework
//
//  Created by Eric on 2019/4/1.
//  Copyright © 2019 icety. All rights reserved.
//

#import "ViewController.h"
#import "CALayer+EX.h"
#import "EXSearchPath.h"
#import "EXFileManager.h"

#define kRandomColor [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:arc4random() % 255 / 255.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    for (NSInteger i = 0; i < 10; i ++)
//    {
//        [self addAView:i];
//    }
    
    [self searchPath];
}


- (void)searchPath {
    NSLog(@"%@",[EXSearchPath searchDocumentPath]);
    [EXFileManager createFolder:@"Rhesis" directory:[EXSearchPath searchDocumentPath]];
    [EXFileManager createFile:@"test.txt" directory:[EXSearchPath searchDocumentPath]];
    [EXFileManager writeFile:@"test.txt" content:@"qwertyuiopasdfghjklzxcvbn" directory:[EXSearchPath searchDocumentPath]];
    NSLog(@"%@", [EXFileManager readFile:@"test.txt" directory:[EXSearchPath searchDocumentPath]]);
    for (int i = 0; i < 2; i++) {
        NSString *file = [NSString stringWithFormat:@"%dtext.txt",i];
        NSString *path = [[EXSearchPath searchDocumentPath] stringByAppendingPathComponent:@"Rhesis"];
        [EXFileManager writeFile:file content:@"qwertyuiopasdfghjklzxcvbn" directory:path];
    }
    
    NSLog(@"file size is %llu", [EXFileManager fileSizeAtPath:@"test.txt" directory:[EXSearchPath searchDocumentPath]]);
    NSLog(@"folder size is %f", [EXFileManager folderSizeAtPath:@"Rhesis" directory:[EXSearchPath searchDocumentPath]]);
}


- (void)addAView:(NSInteger)index
{
    UIView *view = [self createAView:index];
    [self.view addSubview:view];
    
    // 添加光晕层 不会影响layer(view)的背景色
    if (index % 2 == 0)
    {
        [self resetHaloColor:view];
    }
    else
    {
        [self resetHaloColorWithRadius:view];
    }
}


- (UIView *)createAView:(NSInteger)index
{
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    [view setFrame:CGRectMake(20 + (100 + 20) * (index % 2), 20 + (50 + 15) * (index / 2), 100, 48)];
    if (index % 2 == 0)
    {
        [view addTarget:self action:@selector(resetHaloColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [view addTarget:self action:@selector(resetHaloColorWithRadius:) forControlEvents:UIControlEventTouchUpInside];
    }
    return view;
}

- (void)resetHaloColorWithRadius:(UIView *)view
{
    [view.layer haloLayerWithRadius:8 color:kRandomColor];//圆角
}

- (void)resetHaloColor:(UIView *)view
{
    [view.layer haloLayerWithStroke:8 color:kRandomColor];//无圆角
}

@end
