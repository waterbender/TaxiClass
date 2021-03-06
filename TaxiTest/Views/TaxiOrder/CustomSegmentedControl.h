//
//  CustomSegmentedControl.h
//  TaxiTest
//
//  Created by Yevgenii Pasko on 4/30/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

#import <UIKit/UIKit.h>
IBInspectable
IB_DESIGNABLE



@interface CustomSegmentedControl : UIControl <NSCoding>

@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (strong, nonatomic) IBInspectable UIColor *textColor;

@property (strong, nonatomic) IBInspectable UIColor *backgroundLineColor;

@property (strong, nonatomic) IBInspectable UIColor *selectorColor;
@property (strong, nonatomic) IBInspectable UIColor *selectorTextColor;
@property (assign, nonatomic) IBInspectable CGFloat selectorHeight;

@property (strong,nonatomic) IBInspectable NSString *commaSeparatedSegmentImagesNames;
@property (strong,nonatomic) IBInspectable NSString *commaSeparatedEnableSegmentImagesNames;
@property (strong, nonatomic) IBInspectable NSString *commaSeparatedButtonTitles;

@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSMutableArray *selectedImagesArray;
@property (assign, nonatomic) int selectedIndex;
//@property (assign, nonatomic) int selectedSegmentIndex;
-(void)updateView;

@end
