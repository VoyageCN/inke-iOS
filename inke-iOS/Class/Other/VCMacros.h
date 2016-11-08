//
//  VCMacros.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#ifndef VCMacros_h
#define VCMacros_h

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define RGB(r,g,b)    [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]

//忽略PerformSelector警告
#define SUPPRESS_PerformSelectorLeak_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//忽略未定义方法警告
#define  SUPPRESS_Undeclaredselector_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//忽略过期API警告
#define SUPPRESS_DEPRECATED_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//忽略未使用变量警告
#define SUPPRESS_Unusedvariable_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wunused-variable\"") \
Stuff; \
_Pragma ("clang diagnositc pop") \
} while (0)

#endif /* VCMacros_h */
