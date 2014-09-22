//
//  CMPopTipView+DMOS.h
//  DMOS
//
//  Created by Summer Green on 6/18/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "CMPopTipView.h"

@interface CMPopTipView (DMOS)
+ (instancetype)toastMessageWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)validationMessageWithTitle:(NSString *)title message:(NSString *)message;
@end
