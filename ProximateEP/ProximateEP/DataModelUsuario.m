//
//  DataModelUsuario.m
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "DataModelUsuario.h"

@implementation DataModelUsuario
-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return Nil;
    }
    
    self.usuarioId = [aDecoder decodeObjectForKey:@"usuarioId"];
    self.token = [aDecoder decodeObjectForKey:@"token"];
    self.nombres = [aDecoder decodeObjectForKey:@"nombres"];
    self.apellidos = [aDecoder decodeObjectForKey:@"apellidos"];
    self.correo = [aDecoder decodeObjectForKey:@"correo"];
    self.numeroDocumento = [aDecoder decodeObjectForKey:@"numeroDocumento"];
    self.ultimaSesion = [aDecoder decodeObjectForKey:@"ultimaSesion"];
    self.eliminado = [aDecoder decodeObjectForKey:@"eliminado"];
    self.documentosId = [aDecoder decodeObjectForKey:@"documentosId"];
    self.documentosAbrev = [aDecoder decodeObjectForKey:@"documentosAbrev"];
    self.documentosLabel = [aDecoder decodeObjectForKey:@"documentosLabel"];
    self.estadosUsuariosLabel = [aDecoder decodeObjectForKey:@"estadosUsuariosLabel"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.usuarioId forKey:@"usuarioId"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.nombres forKey:@"nombres"];
    [aCoder encodeObject:self.apellidos forKey:@"apellidos"];
    [aCoder encodeObject:self.correo forKey:@"correo"];
    [aCoder encodeObject:self.numeroDocumento forKey:@"numeroDocumento"];
    [aCoder encodeObject:self.ultimaSesion forKey:@"ultimaSesion"];
    [aCoder encodeObject:self.eliminado forKey:@"eliminado"];
    [aCoder encodeObject:self.documentosId forKey:@"documentosId"];
    [aCoder encodeObject:self.documentosAbrev forKey:@"documentosAbrev"];
    [aCoder encodeObject:self.documentosLabel forKey:@"documentosLabel"];
    [aCoder encodeObject:self.estadosUsuariosLabel forKey:@"estadosUsuariosLabel"];
}

- (id)copyWithZone:(NSZone *)zone {
    DataModelUsuario * newKey = [[[self class] allocWithZone:zone] init];
    
    if(newKey){
        [newKey setUsuarioId:[self usuarioId]];
        [newKey setToken:[self token]];
        [newKey setNombres:[self nombres]];
        [newKey setApellidos:[self apellidos]];
        [newKey setCorreo:[self correo]];
        [newKey setNumeroDocumento:[self numeroDocumento]];
        [newKey setUltimaSesion:[self ultimaSesion]];
        [newKey setEliminado:[self eliminado]];
        [newKey setDocumentosId:[self documentosId]];
        [newKey setDocumentosAbrev:[self documentosAbrev]];
        [newKey setDocumentosLabel:[self documentosLabel]];
        [newKey setEstadosUsuariosLabel:[self estadosUsuariosLabel]];
       
    }
    
    return  newKey;
}

@end
