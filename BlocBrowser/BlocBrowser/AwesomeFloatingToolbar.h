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
-(void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didTryToPanWithOffset:(CGPoint)offset;
-(void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didPinchWithScale:(CGFloat)scale;
-(void) floatingToolbar:(AwesomeFloatingToolbar *)toolbar didRecieveLongPress:(CGFloat)press;
@end

@interface AwesomeFloatingToolbar : UIView

-(instancetype) initWithFourTitle:(NSArray *)titles;

-(void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title;

@property (nonatomic, weak) id <AwesomeFloatingToolbarDelegate> delegate;

@end
