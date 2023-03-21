//
//  HLKNavigationBar.m
//  Glossary of Geotechnical Engineering
//
//  Created by Haluk Isik on 06/05/14.
//  Copyright (c) 2014 Haluk Isik. All rights reserved.
//

#import "HLKNavigationBar.h"

@implementation HLKNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect frame = [self frame];
        frame.size.height = 82.0f;
        [self setFrame:frame];
    }
    return self;
}
/*
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"NavigationBar.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
*/
@end
