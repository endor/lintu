//
//  Constants.h
//  lintu
//
//  Created by Frank Prößdorf on 10/3/13.
//  Copyright (c) 2013 Frank Pr√∂√üdorf. All rights reserved.
//

#ifndef lintu_Constants_h
#define lintu_Constants_h


#ifdef TESTING
    NSString *BaseURL = @"http://localhost:9092/";
#else
    NSString *BaseURL = @"http://localhost:9091/";
#endif

#endif
