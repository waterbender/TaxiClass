//
//  CustomnViewButtonForSegmentControll.m
//  TaxiTest
//
//  Created by Yevgenii Pasko on 4/30/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

#import "CustomnViewButtonForSegmentControll.h"

@implementation CustomnViewButtonForSegmentControll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSegmentImage:(UIImage *)image {
    _segmentImage = image;
    [self setImage:image forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title {
    _title = title;
}

@end
