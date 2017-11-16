//
//  UsuarioWS.h
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ConexionWS.h"
#import "WS_Protocol.h"
#import "DataModelUsuario.h"
@interface UsuarioWS : ConexionWS
@property (nonatomic, weak) id<WS_Protocol> wsProtocoloDelegate;
@property (strong, nonatomic) DataModelUsuario *dataUsuario;
-(void)GetUser:(NSString *)token;
@end
