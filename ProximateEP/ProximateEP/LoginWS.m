//
//  LoginWS.m
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "LoginWS.h"

@implementation LoginWS

-(void)Login:(NSString *)correo pass:(NSString *)contrasenia{
    
    NSString * urlString =[NSString stringWithFormat:@"%@/catalog/dev/webadmin/authentication/login",rutaWS];
    NSURL * url = [NSURL URLWithString:urlString];
    NSString *userUpdate =[NSString stringWithFormat:@"{ \"correo\":\"%@\", \"contrasenia\":\"%@\"}",correo,contrasenia];

        ConexionWS *cone = [[ConexionWS alloc]init];
    [cone conexion:url cuerpo:userUpdate metodo:@"POST" token:@""  regresaWS:^(NSData * resultadoData, NSString * resultadoString){
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resultadoData options:0 error:&parseError];
        
        if([resultadoString isEqualToString:@"200"]){
            [self parseJsonLogin:responseDictionary];
        }else{
            [_wsProtocoloDelegate respuestaErrorWS:@"Atención" messageWS: [responseDictionary objectForKey:@"message"]];
        }
    }];
    
}

-(void)parseJsonLogin:(NSDictionary*)JSON{
   
    NSInteger success = [[JSON objectForKey:@"success"] integerValue];
    if(success == 1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[JSON objectForKey:@"token"] forKey:@"Token"];
        [_wsProtocoloDelegate respuestaCorrectaWS:[JSON objectForKey:@"message"]];
    }
    else
    {
        [_wsProtocoloDelegate respuestaErrorWS:@"Atención" messageWS:[JSON objectForKey:@"message"]];
    }
}


@end
