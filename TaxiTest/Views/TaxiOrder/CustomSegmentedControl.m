//
//  CustomSegmentedControl.m
//  TaxiTest
//
//  Created by Yevgenii Pasko on 4/30/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

#import "CustomSegmentedControl.h"

@interface CustomSegmentedControl()

@property (strong, nonatomic) NSMutableArray *buttonsArray;
@property (strong, nonatomic) UIView *selectedView;

@end

@implementation CustomSegmentedControl


- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = self.frame.size.height / 2;
    [self updateView];
}

-(void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self updateView];
}

-(void)setSelectorColor:(UIColor *)selectorColor {
    _selectorColor = selectorColor;
    [self updateView];
}

-(void)setSelectorTextColor:(UIColor *)selectorTextColor {
    _selectorTextColor = selectorTextColor;
    [self updateView];
}

-(void)setSelectorHeight:(CGFloat)selectorHeight {
    _selectorHeight = selectorHeight;
    [self updateView];
}

-(void)updateView {
    
    [self.buttonsArray removeAllObjects];
    self.buttonsArray = [[NSMutableArray alloc] init];
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    NSArray *componentsTitles = [self.commaSeparatedButtonTitles componentsSeparatedByString:@","];
    
    for (NSString *title in componentsTitles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:button];
    }
    [self.buttonsArray.firstObject setTitleColor:self.selectorTextColor forState:UIControlStateNormal];
    
    CGFloat selectorWidth = self.frame.size.width / (CGFloat)self.buttonsArray.count;
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-self.selectorHeight, selectorWidth, self.selectorHeight)];
    //self.selectedView.layer.cornerRadius = self.frame.size.height / 2;
    self.selectedView.backgroundColor = self.selectorColor;
    [self addSubview:self.selectedView];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.buttonsArray];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:stackView];
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [stackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [stackView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    
}

-(void)buttonTapped:(UIButton*) button {
    for (int i = 0; i<self.buttonsArray.count; i++) {
        UIButton *btn =[self.buttonsArray objectAtIndex:i];
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        if ([btn isEqual:button]) {
            
            self.selectedSegmentIndex = i;
            CGFloat selectedPosition = (self.frame.size.width / (CGFloat)self.buttonsArray.count)*i;
            CGRect rectSelected = self.selectedView.frame;
            CGPoint originSelected = self.selectedView.frame.origin;
            originSelected.x = selectedPosition;
            rectSelected.origin = originSelected;
            [UIView animateWithDuration:0.3 animations:^{
                self.selectedView.frame = rectSelected;
            }];
            [btn setTitleColor:self.selectorTextColor forState:UIControlStateNormal];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
