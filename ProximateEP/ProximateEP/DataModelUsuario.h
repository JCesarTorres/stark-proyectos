//
//  DataModelUsuario.h
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModelUsuario : NSObject

@property (nonatomic, strong) NSString *usuarioId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nombres;
@property (nonatomic, strong) NSString *apellidos;
@property (nonatomic, strong) NSString *correo;
@property (nonatomic, strong) NSString *numeroDocumento;
@property (nonatomic, strong) NSString *ultimaSesion;
@property (nonatomic, strong) NSString *eliminado;
@property (nonatomic, strong) NSString *documentosId;
@property (nonatomic, strong) NSString *documentosAbrev;
@property (nonatomic, strong) NSString *documentosLabel;
@property (nonatomic, strong) NSString *estadosUsuariosLabel;



@end
