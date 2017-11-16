//
//  PerfilVC.h
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@interface PerfilVC : ViewController
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblUsuarioID;
@property (weak, nonatomic) IBOutlet UILabel *lblNombres;
@property (weak, nonatomic) IBOutlet UILabel *lblApellidos;
@property (weak, nonatomic) IBOutlet UILabel *lblCorreo;
@property (weak, nonatomic) IBOutlet UILabel *lblNumeroDocumento;
@property (weak, nonatomic) IBOutlet UILabel *lblUltimaSesion;
@property (weak, nonatomic) IBOutlet UILabel *lblDocumentos;
@property (weak, nonatomic) IBOutlet UILabel *lblEstado;
@property (weak, nonatomic) IBOutlet UILabel *lblRutaImagen;
@property (weak, nonatomic) IBOutlet UIImageView *imagenUsuario;
- (IBAction)btnAgregarImagenAct:(UIButton *)sender;

@end
