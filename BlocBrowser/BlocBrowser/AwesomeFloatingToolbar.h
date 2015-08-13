//
//  AwesomeFloatingToolbar.h
//  BlocBrowser
//
//  Created by Joshua on 8/10/15.
//  Copyright (c) 2015 Joshua Novak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwesomeFloatingToolbar;

@protocol AwesomeFloatingToolbarDelegate <NSObject>

@optional

-(void) floatingToolbar: (AwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle:(NSString *)title;

@end

@interface AwesomeFloatingToolbar : UIView

-(instancetype) initWithFourTitle:(NSArray *)titles;

-(void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title;

@property (nonatomic, weak) id <AwesomeFloatingToolbarDelegate> delegate;

@end
