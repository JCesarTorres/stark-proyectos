//
//  ViewController.h
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface ViewController : UIViewController

-(void)llamarMenuLeft:(UIButton *)_btnMenuLeft reveal:(SWRevealViewController *)revealVC aplica:(UIView *)miview;

-(UIButton *)buttonBorder:(UIButton*)butoon;
-(void)alertaInfo:(NSString*)titulo sub:(NSString*)subtitulo;


@end

