//
//  CustomnViewButtonForSegmentControll.h
//  TaxiTest
//
//  Created by Yevgenii Pasko on 4/30/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

#import <UIKit/UIKit.h>
IBInspectable
IB_DESIGNABLE

@interface CustomnViewButtonForSegmentControll : UIButton

@property (strong,nonatomic) IBInspectable NSString *title;
@property (strong,nonatomic) IBInspectable UIImage *segmentImage;

@end
