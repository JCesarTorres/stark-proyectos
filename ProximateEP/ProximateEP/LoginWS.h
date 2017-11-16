//
//  LoginWS.h
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ConexionWS.h"
#import "WS_Protocol.h"

@interface LoginWS : ConexionWS
@property (nonatomic, weak) id<WS_Protocol> wsProtocoloDelegate;
-(void)Login:(NSString *)correo pass:(NSString *)contrasenia;


@end
