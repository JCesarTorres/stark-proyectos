//
//  PerfilVC.m
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "PerfilVC.h"
@interface PerfilVC ()

@end

@implementation PerfilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self llamarMenuLeft:_btnMenu reveal:[self revealViewController] aplica:self.view];
    DataModelUsuario * usuario = [[DataModelUsuario alloc]init];
    usuario = [[DBManager getSharedInstance]obtenerUsuario:[[NSUserDefaults standardUserDefaults] stringForKey:@"Token"]];
    
    _lblUsuarioID.text = [NSString stringWithFormat:@"Usuario ID: %@",usuario.usuarioId];
    _lblNombres.text =[NSString stringWithFormat:@"Nombre: %@",usuario.nombres];
    _lblApellidos.text =[NSString stringWithFormat:@"Apellidos: %@", usuario.apellidos];
    _lblCorreo.text = [NSString stringWithFormat:@"Correo: %@",usuario.correo];
    _lblNumeroDocumento.text = [NSString stringWithFormat:@"Numero de Documento: %@",usuario.numeroDocumento];
    _lblUltimaSesion.text = [NSString stringWithFormat:@"Ultima sesión: %@",usuario.ultimaSesion];
    _lblDocumentos.text = [NSString stringWithFormat:@"Documento: %@",usuario.documentosLabel];
    _lblEstado.text = [NSString stringWithFormat:@"Estado: %@",usuario.estadosUsuariosLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnAgregarImagenAct:(UIButton *)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Atención"
                                 message:@"Selecciona una acción"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* camara = [UIAlertAction
                             actionWithTitle:@"Camara"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self iniciarCamara];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [view addAction:camara];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

-(void)iniciarCamara{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [_imagenUsuario setImage: chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSData *imageData = UIImagePNGRepresentation(_imagenUsuario.image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:@"imagen.png"];
   
    if (![imageData writeToFile:imagePath atomically:NO])
    {
        _lblRutaImagen.text = @"";
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:imagePath forKey:@"RutaImagen"];
        _lblRutaImagen.text = imagePath;
    }
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
