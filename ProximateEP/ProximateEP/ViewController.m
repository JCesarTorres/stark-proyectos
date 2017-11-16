//
//  ViewController.m
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)llamarMenuLeft:(UIButton *)_btnMenuLeft reveal:(SWRevealViewController *)revealVC aplica:(UIView *)miview{
    SWRevealViewController *revealViewController = revealVC;
    if ( revealViewController )
    {
        [revealViewController panGestureRecognizer];
        [_btnMenuLeft addTarget:revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [miview addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}



-(UIButton*)buttonBorder:(UIButton *)butoon{
    [[butoon layer] setCornerRadius:8.0f];
    [butoon.layer setBorderWidth:1];
    return butoon;
}


-(void)alertaInfo:(NSString*)titulo sub:(NSString*)subtitulo{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:titulo
                                                                  message:subtitulo
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* aceptarButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
    [alert addAction:aceptarButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
