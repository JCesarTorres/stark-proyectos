//
//  UsuarioWS.m
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "UsuarioWS.h"

@implementation UsuarioWS
-(void)GetUser:(NSString *)token{
    
    NSString * urlString =[NSString stringWithFormat:@"%@/catalog/dev/webadmin/users/getdatausersession",rutaWS];
    NSURL * url = [NSURL URLWithString:urlString];
    NSString *userUpdate =@"";
    ConexionWS *cone = [[ConexionWS alloc]init];
    [cone conexion:url cuerpo:userUpdate metodo:@"POST" token:token  regresaWS:^(NSData * resultadoData, NSString * resultadoString){
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resultadoData options:0 error:&parseError];
        
        if([resultadoString isEqualToString:@"200"]){
            [self parseJsonUsuario:responseDictionary];
        }else{
            [_wsProtocoloDelegate respuestaErrorWS:@"Atención" messageWS: [responseDictionary objectForKey:@"message"]];
        }
    }];
    
}

-(void)parseJsonUsuario:(NSDictionary*)JSON{
   
    NSInteger success = [[JSON objectForKey:@"success"] integerValue];
    if(success == 1)
    {
        for (id key in [JSON objectForKey:@"data"]) {
            _dataUsuario = [[DataModelUsuario alloc]init];
            [_dataUsuario setUsuarioId:[key valueForKey:@"id"]];
            [_dataUsuario setNombres:[key valueForKey:@"nombres"]];
            [_dataUsuario setApellidos:[key valueForKey:@"apellidos"]];
            [_dataUsuario setCorreo:[key valueForKey:@"correo"]];
            [_dataUsuario setNumeroDocumento:[key valueForKey:@"numero_documento"]];
            [_dataUsuario setUltimaSesion:[key valueForKey:@"ultima_sesion"]];
            [_dataUsuario setEliminado:[key valueForKey:@"eliminado"]];
            [_dataUsuario setDocumentosId:[key valueForKey:@"documentos_id"]];
            [_dataUsuario setDocumentosAbrev:[key valueForKey:@"documentos_abrev"]];
            [_dataUsuario setDocumentosLabel:[key valueForKey:@"documentos_label"]];
            [_dataUsuario setEstadosUsuariosLabel:[key valueForKey:@"estados_usuarios_label"]];
        }
        [_wsProtocoloDelegate respuestaCorrectaUsuarioWS:[JSON objectForKey:@"message"] usuario:_dataUsuario];
    }
    else
    {
        [_wsProtocoloDelegate respuestaErrorWS:@"Atención" messageWS:[JSON objectForKey:@"message"]];
    }
}

@end
