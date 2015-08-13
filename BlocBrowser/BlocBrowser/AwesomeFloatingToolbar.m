//
//  AwesomeFloatingToolbar.m
//  BlocBrowser
//
//  Created by Joshua on 8/10/15.
//  Copyright (c) 2015 Joshua Novak. All rights reserved.
//

#import "AwesomeFloatingToolbar.h"

@interface AwesomeFloatingToolbar()

@property (nonatomic, strong) NSArray *currentTitles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *lables;
@property (nonatomic, weak) UILabel *currentLabel;

@end


@implementation AwesomeFloatingToolbar

-(instancetype) initWithFourTitle:(NSArray *)titles {
    //first call the superclass (UIView)'s initializer, to make sure we do all that set up first.
    self = [super init];
    
    if (self) {
        
        
        //save titles, set four colors
        self.currentTitles = titles;
        self.colors = @[[UIColor colorWithRed:199/255.0 green:158/255.0 blue:203/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:105/255.0 blue:97/255.0 alpha:1],
                        [UIColor colorWithRed:222/255.0 green:165/255.0 blue:164/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:179/255.0 blue:71/255.0 alpha:1]];
        
        NSMutableArray *labelsArray = [[NSMutableArray alloc] init];
        
        //make the 4 lables
        for (NSString *currentTitle in self.currentTitles) {
            UILabel *label = [[UILabel alloc] init];
            label.userInteractionEnabled = NO;
            label.alpha = 0.25;
            
            NSInteger currentTitleIndex = [self.currentTitles indexOfObject:currentTitle]; //0 through 3
            NSString *titleForThisLabel = [self.currentTitles objectAtIndex:currentTitleIndex];
            UIColor *colorForThisLabel = [self.colors objectAtIndex:currentTitleIndex];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:10];
            label.text = titleForThisLabel;
            label.backgroundColor = colorForThisLabel;
            label.textColor = [UIColor whiteColor];
            
            [labelsArray addObject:label];
        }
        
        self.lables = labelsArray;
        
        for (UILabel *thisLabel in self.lables){
            [self addSubview:thisLabel];
        }
    }
    
    return self;
}

-(void) layoutSubviews {
    //set the frames for the 4 labels
    
    for(UILabel *thisLabel in self.lables) {
        NSUInteger currentLabelIndex = [self.lables indexOfObject:thisLabel];
        
        CGFloat labelHeight = CGRectGetHeight(self.bounds) /2;
        CGFloat labelWidth = CGRectGetWidth(self.bounds) /2;
        CGFloat labelx = 0;
        CGFloat labely = 0;
        
        //adjust labelx and labely for each label
        if (currentLabelIndex < 2) {
            //0 or 1, so on top
            labely = 0;
        }else{
            //2 or 3, so on bottom
            labely = CGRectGetHeight(self.bounds) /2;
        }
        
        if (currentLabelIndex % 2 == 0) { // is currentLabelIndex evenly divisible by 2?
            //0 or 2, so on the left
            labelx = 0;
        }else{
            //1 or 3, so on the right
            labelx = CGRectGetWidth(self.bounds) /2;
        }
        
        thisLabel.frame = CGRectMake(labelx, labely, labelWidth, labelHeight);
    }
}

#pragma mark - Touch Handling

- (UILabel *) labelFromTouches:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    UIView *subview = [self hitTest:location withEvent:event];
    
    if ([subview isKindOfClass:[UILabel class]]) {
        return (UILabel *)subview;
    }else{
        return nil;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UILabel *label = [self labelFromTouches:touches withEvent:event];
    
    self.currentLabel = label;
    self.currentLabel.alpha = 0.5;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UILabel *label = [self labelFromTouches:touches withEvent:event];
    
    if (self.currentLabel != label) {
        // The label being touched is no longer the initial label
        self.currentLabel.alpha = 1;
    }else{
        // The label being touched is the initial label
        self.currentLabel.alpha = 0.5;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UILabel *label = [self labelFromTouches:touches withEvent:event];
    
    if (self.currentLabel == label) {
        NSLog(@"Label tapped: %@", self.currentLabel.text);
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)]) {
            [self.delegate floatingToolbar:self didSelectButtonWithTitle:self.currentLabel.text];
        }
    }
    
    self.currentLabel.alpha = 1;
    self.currentLabel = nil;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentLabel.alpha = 1;
    self.currentLabel = nil;
}

#pragma mark - Button Enabling

-(void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title {
    NSUInteger index = [self.currentTitles indexOfObject:title];
    
    if (index != NSNotFound) {
        UILabel *label = [self.lables objectAtIndex:index];
        label.userInteractionEnabled = enabled;
        label.alpha = enabled ? 1.0 : 0.25;
    }
}







@end






