//
//  ViewController.m
//  TaxiTest
//
//  Created by Yevgenii Pasko on 4/30/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

#import "TaxiOrderViewController.h"

@interface TaxiOrderViewController ()

@end

@implementation TaxiOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Заказ такси";
    UIColor *backgroundColor = [UIColor colorWithRed:69.0/255.0 green:71.0/255.0 blue:84.0/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = backgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backIndicatorImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:254.0/255.0 green:208.0/255.0 blue:0.0/255.0 alpha:1],
       NSFontAttributeName:[UIFont fontWithName:@"System Font" size:19]}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotate {
    [self.taxiSegmentControll updateView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
