//
//  ConexionWS.h
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIMEOUTREQUEST 60
@interface ConexionWS : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate,NSXMLParserDelegate>{}
@property (strong, nonatomic) NSDictionary * resultadoDic;
@property (strong, nonatomic) NSMutableData * responseData;

// Metodo de comunicacion con el WS
- (void)conexion:(NSURL *)url cuerpo:(NSString *)cuerpo metodo:(NSString *)metodo token:(NSString*)token regresaWS:(void (^)(NSData * resultadoData, NSString * resultadoString))regresaWS;

@end
