//
//  LoginVC.h
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ViewController.h"
#import "WS_Protocol.h"
#import "DBManager.h"

@interface LoginVC : ViewController<WS_Protocol>
@property (weak, nonatomic) IBOutlet UITextField *textCorreo;
@property (weak, nonatomic) IBOutlet UITextField *textContrasenia;
@property (assign,nonatomic) NSUInteger statusCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;
@property (weak, nonatomic) IBOutlet UIButton *btnRecordar;
- (IBAction)btnIngresarAct:(UIButton *)sender;
- (IBAction)btnRecordarAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;
@property (weak, nonatomic) IBOutlet UIView *viewIndicador;

@end
