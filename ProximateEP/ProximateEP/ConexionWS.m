//
//  ConexionWS.m
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "ConexionWS.h"

@implementation ConexionWS

-(id)init
{
    if ( (self = [super init]) ){}
    return self;
}


- (void)conexion:(NSURL *)url cuerpo:(NSString *)cuerpo metodo:(NSString *)metodo token:(NSString*)token regresaWS:(void (^)(NSData *, NSString *))regresaWS{
    
    NSData *postData = [cuerpo dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{ @"Content-Type" :@"application/json", @"Authorization" :token};
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:metodo];
    [request setHTTPBody: postData];
    
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                regresaWS(data, @"200");
            });
        }else if (HTTPResponse.statusCode == 400) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoMasTarde);
            });
        }else if (HTTPResponse.statusCode == 500) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoMasTarde);
            });
        }else if (HTTPResponse.statusCode == 440) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoNuevamente);
            });
        }else if (HTTPResponse.statusCode == 444) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoConexion);
            });
        }else if (HTTPResponse.statusCode == 520) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoNuevamente);
            });
        }else if (HTTPResponse.statusCode == 521) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoMasTarde);
            });
        }else if (HTTPResponse.statusCode == 526) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoMasTarde);
            });
        }else if (HTTPResponse.statusCode == 404) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoNuevamente);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                regresaWS(data, msjGenericoInternet);
            });
        }
    }];
    [uploadTask resume];
    
}
@end
