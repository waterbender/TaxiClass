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

CGFloat width = 90.0;
CGFloat stackSpacing = 10;

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

-(void)setBackgroundLineColor:(UIColor *)backgroundLineColor {
    _backgroundLineColor = backgroundLineColor;
    [self updateView];
}

- (void)setCommaSeparatedSegmentImagesNames:(NSString *)commaSeparatedSegmentImagesNames {
    
    _commaSeparatedSegmentImagesNames = commaSeparatedSegmentImagesNames;
    [self.imagesArray removeAllObjects];
    self.imagesArray = nil;
    self.imagesArray = [[NSMutableArray alloc] init];
    
    NSArray *imagesNames = [commaSeparatedSegmentImagesNames componentsSeparatedByString:@","];
    for (NSString *imName in imagesNames) {
        [self.imagesArray addObject:[UIImage imageNamed:imName]];
    }
    [self updateView];
}

-(void)setCommaSeparatedEnableSegmentImagesNames:(NSString *)commaSeparatedEnableSegmentImagesNames {
    
    _commaSeparatedEnableSegmentImagesNames = commaSeparatedEnableSegmentImagesNames;
    [self.selectedImagesArray removeAllObjects];
    self.selectedImagesArray = nil;
    self.selectedImagesArray = [[NSMutableArray alloc] init];
    
    NSArray *imagesNames = [commaSeparatedEnableSegmentImagesNames componentsSeparatedByString:@","];
    for (NSString *imName in imagesNames) {
        UIImage *image = [UIImage imageNamed:imName];
        [self.selectedImagesArray addObject:image];
    }
    [self updateView];
}

-(CGFloat) needdedWidth {
    
    CGRect windowRect = self.window.frame;
    CGFloat windowWidth = windowRect.size.width;
    CGFloat widthCurrent = windowWidth/self.buttonsArray.count;
    if (widthCurrent>width) {
        return widthCurrent;
    } else {
        return width;
    }
}

-(void)updateView {
    
    [self layoutSubviews];
    [self.buttonsArray removeAllObjects];
    self.buttonsArray = [[NSMutableArray alloc] init];
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self setButtons];
    [self setImages];
    
    UILabel *label = [self.buttonsArray.firstObject viewWithTag:45];
    label.textColor = self.selectorTextColor;
    
    if (self.buttonsArray.count == self.selectedImagesArray.count) {
        UIImageView *imageView = [self.buttonsArray[self.selectedIndex] viewWithTag:46];
        imageView.image = self.selectedImagesArray[self.selectedIndex];
    }
    
    
    CGFloat backLineWidth = self.frame.size.width;
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-self.selectorHeight, backLineWidth, self.selectorHeight)];
    bottomLineView.backgroundColor = self.backgroundLineColor;
    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:bottomLineView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    CGFloat widthOfScrollContent = (self.needdedWidth*self.buttonsArray.count)+(stackSpacing*(self.buttonsArray.count-1));
    scrollView.contentSize = CGSizeMake(widthOfScrollContent, self.bounds.size.height);
    [self addSubview:scrollView];
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    [scrollView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    [scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
    [scrollView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = true;
    [scrollView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = true;
    
    CGFloat selectorWidth = self.needdedWidth;
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake((self.selectedIndex*self.needdedWidth)+(self.selectedIndex-1)*stackSpacing, self.bounds.size.height-self.selectorHeight, selectorWidth, self.selectorHeight)];
    self.selectedView.backgroundColor = self.selectorColor;
    [scrollView addSubview:self.selectedView];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.buttonsArray];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = stackSpacing;
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [scrollView addSubview:stackView];
    
    
    CGFloat widthFull = (self.buttonsArray.count*self.needdedWidth)+(self.buttonsArray.count-1)*stackSpacing;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:stackView
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:scrollView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:stackView
                                                           attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0]];
    [stackView addConstraint:[NSLayoutConstraint constraintWithItem:stackView
                                                           attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                              toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0
                                                            constant:widthFull]];
    
    [stackView reloadInputViews];
    [stackView layoutSubviews];
}

-(void) setButtons {
    
    NSArray *componentsTitles = [self.commaSeparatedButtonTitles componentsSeparatedByString:@","];
    
    for (NSString *title in componentsTitles) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        
        CGRect rect = button.bounds;
        rect.size.height = self.bounds.size.height/4;
        rect.origin.y = self.bounds.size.height-self.bounds.size.height/3;
        rect.origin.x = 0;

        // add label
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:rect];
        labelTitle.tag = 45;
        [labelTitle setFont:[UIFont fontWithName:@"System Font" size:12]];
        labelTitle.textColor = self.textColor;
        labelTitle.text = title;
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.userInteractionEnabled = false;
        labelTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        
        [button addSubview:labelTitle];
        [self.buttonsArray addObject:button];
    }
}

-(void) setImages {
    
    NSInteger numButtons = self.buttonsArray.count;
    NSInteger numImages = self.imagesArray.count;
    
    if (numButtons==numImages) {
        for (int i = 0; i<self.imagesArray.count; i++) {
            
            UIImage *image =self.imagesArray[i];
            UIButton *button =self.buttonsArray[i];
            
            CGRect rect = button.bounds;
            rect.size.height = 50;
            rect.origin.y = 0;
            rect.origin.x = 0;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.tag = 46;
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            imageView.userInteractionEnabled = false;
            [button addSubview:imageView];
        }
    }
}

-(void)buttonTapped:(UIButton*) button {
    for (int i = 0; i<self.buttonsArray.count; i++) {
        
        UIButton *btn =[self.buttonsArray objectAtIndex:i];
        UILabel *labelBtn = [btn viewWithTag:45];
        labelBtn.textColor = self.textColor;
        UIImageView *imageView = [btn viewWithTag:46];
        imageView.image = self.imagesArray[i];
        
        if ([btn isEqual:button]) {
            
            self.selectedIndex = i;
            CGFloat selectedPosition = (self.needdedWidth+stackSpacing)*i;
            CGRect rectSelected = self.selectedView.frame;
            CGPoint originSelected = self.selectedView.frame.origin;
            originSelected.x = selectedPosition;
            rectSelected.origin = originSelected;
            [UIView animateWithDuration:0.25 animations:^{
                self.selectedView.frame = rectSelected;
                if (self.selectedImagesArray.count == self.buttonsArray.count) {
                    imageView.image = self.selectedImagesArray[i];
                }
            }];
            UILabel *label = [btn viewWithTag:45];
            label.textColor = self.selectorTextColor;
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
