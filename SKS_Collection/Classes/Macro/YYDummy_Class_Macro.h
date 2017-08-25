//
//  YYDummy_Class_Macro.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#ifndef YYDummy_Class_Macro_h
#define YYDummy_Class_Macro_h

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 YYSYNTH_DUMMY_CLASS(NSString_YYAdd)
 */
#ifndef YYSYNTH_DUMMY_CLASS
#define YYSYNTH_DUMMY_CLASS(_name_) \
@interface YYSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation YYSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

#endif /* YYDummy_Class_Macro_h */
