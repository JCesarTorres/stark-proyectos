//
//  LoginVC.m
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "LoginVC.h"
#import "LoginWS.h"
#import "UsuarioWS.h"
#import "SWRevealViewController.h"


@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _statusCheck = 0;
    _textCorreo.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Correo"];
    if([_textCorreo.text length] > 0){
        _textCorreo.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Correo"];
        _textContrasenia.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Contrasenia"];
        [self btnRecordarAct:nil];
    }
}


- (IBAction)btnRecordarAct:(UIButton *)sender {
    if(_statusCheck == 1){
        _statusCheck = 0;
        [_btnRecordar setBackgroundImage:[UIImage imageNamed:@"checkOFF"] forState:UIControlStateNormal];
    }else if(_statusCheck == 0){
        _statusCheck = 1;
        [_btnRecordar setBackgroundImage:[UIImage imageNamed:@"checkOn"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnIngresarAct:(UIButton *)sender {
    if([_textCorreo.text length] == 0){
        [self alertaInfo:@"Atención" sub:@"Por favor ingresa el correo"];
    }else  if([_textContrasenia.text length] == 0){
        [self alertaInfo:@"Atención" sub:@"Por favor ingresa la contraseña"];
    }else{
        [self.view endEditing:YES];
        [self iniciarIndicador];
        LoginWS * login = [[LoginWS alloc] init];
        [login setWsProtocoloDelegate:self];
        [login Login:_textCorreo.text pass:_textContrasenia.text];
        //[login Login:@"prueba@proximateapps.com" pass:@"12digo16digo18#$"];


    }
}

-(void)respuestaCorrectaWS:(NSString *)message{
    if(_statusCheck == 1){
        [[NSUserDefaults standardUserDefaults] setValue:_textCorreo.text forKey:@"Correo"];
        [[NSUserDefaults standardUserDefaults] setValue:_textContrasenia.text forKey:@"Contrasenia"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Correo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Contrasenia"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self alertaInfo:@"Correcto" sub:message];
    [[DBManager getSharedInstance]eliminar];
    UsuarioWS * usuario = [[UsuarioWS alloc] init];
    [usuario setWsProtocoloDelegate:self];
    [usuario GetUser:[[NSUserDefaults standardUserDefaults] stringForKey:@"Token"]];
}

-(void)respuestaCorrectaUsuarioWS:(NSString *)message usuario:(DataModelUsuario *)usuario{
    BOOL success = NO;
    [usuario setToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"Token"]];
    success = [[DBManager getSharedInstance]guardar:usuario];
    [self terminarIndicaro];
  
    if (success == NO) {
        [self alertaInfo:@"error" sub:@"No se pudo guardar el Usuario"];
    }else{
        SWRevealViewController * tr = [self.storyboard instantiateViewControllerWithIdentifier:@"principal"];
        [self.navigationController pushViewController:tr animated:YES];
    }
}

-(void)respuestaErrorWS:(NSString *)respuesta messageWS:(NSString *)message{
    [self terminarIndicaro];
    [self alertaInfo:respuesta sub:message];
}

-(void)iniciarIndicador{
    [_indicador startAnimating];
    [_indicador setHidden:NO];
    [_viewIndicador setHidden:NO];
}

-(void)terminarIndicaro{
    [_indicador stopAnimating];
    [_indicador setHidden:YES];
    [_viewIndicador setHidden:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
