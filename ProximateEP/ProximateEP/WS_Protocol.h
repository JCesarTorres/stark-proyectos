//
//  WS_Protocol.h
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#ifndef WS_Protocol_h
#define WS_Protocol_h


#endif /* WS_Protocol_h */
#import <Foundation/Foundation.h>

@protocol WS_Protocol <NSObject>

@optional
-(void)respuestaCorrectaWS:(NSString *)message;
-(void)respuestaCorrectaUsuarioWS:(NSString *)message usuario:(NSObject *)usuario;
-(void)respuestaErrorWS:(NSString *)respuesta messageWS:(NSString *)message;

@end
