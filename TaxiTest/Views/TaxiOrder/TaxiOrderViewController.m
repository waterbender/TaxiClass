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
    
    UIColor *yellow = [UIColor colorWithRed:254.0/255.0 green:208.0/255.0 blue:0.0/255.0 alpha:1];
    // add hamb
    UIImage* image3 = [[UIImage imageNamed:@"hamb"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    CGRect frameimg = CGRectMake(0, 0, 8, 8);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addConstraint:[NSLayoutConstraint constraintWithItem:someButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20.0]];
    [someButton addConstraint:[NSLayoutConstraint constraintWithItem:someButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20.0]];
    someButton.tintColor = yellow;
    UIBarButtonItem *hambbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=hambbutton;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:yellow,
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

- (IBAction)choosedItem:(CustomSegmentedControl*)sender {

    NSArray *titles = [sender.commaSeparatedButtonTitles componentsSeparatedByString:@","];
    NSString *message = [NSString stringWithFormat:@"%@", titles[sender.selectedIndex]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You changed type to:" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
