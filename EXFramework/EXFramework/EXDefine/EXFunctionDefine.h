//
//  EXFunctionDefine.h
//  EXFrameWork
//
//  Created by Eric on 2019/1/18.
//  Copyright © 2019 icety. All rights reserved.
//

#ifndef EXFunctionDefine_h
#define EXFunctionDefine_h

// Whether the string has a value.
#define STRINGHASVALUE(str)             (str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)

// Whether the array has a value.
#define ARRAYHASVALUE(array)            (array && [array isKindOfClass:[NSArray class]] && [array count] > 0)

// Whether the mutable array has a value.
#define MUTABLEARRAYHASVALUE(array)     (array && [array isKindOfClass:[NSMutableArray class]] && [array count] > 0)

// Whether the dictionary has a value.
#define DICTIONARYHASVALUE(dic)         (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)

// Creates an opaque UIColor object from a byte-value color definition.
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

// Creates a UIColor object from a byte-value color definition and alpha transparency.
#define RGBACOLOR(r,g,b,a)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// Call phone.
#define CALL(NUMBER)                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", NUMBER]]]

// Is iPhone device.
#define IS_IPHONE       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// is iPad device.
#define IS_IPAD         (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#endif /* EXFunctionDefine_h */
