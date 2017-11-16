//
//  DBManager.m
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "DBManager.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager
+(DBManager*)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"usuario.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS USUARIO (ID INTEGER , TOKEN TEXT, NAME TEXT, APELLIDOS TEXT, CORREO TEXT, NUMERO_DOCUMENTO TEXT, ULTIMA_SESION TEXT, DOCUMENTOS TEXT, ESTADO_USUARIO TEXT)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
            
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL)guardar:(DataModelUsuario *)usuario{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into USUARIO (ID, TOKEN, NAME, APELLIDOS, CORREO, NUMERO_DOCUMENTO, ULTIMA_SESION, DOCUMENTOS, ESTADO_USUARIO) values(\"%ld\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",(long)[usuario.usuarioId integerValue], usuario.token, usuario.nombres, usuario.apellidos, usuario.correo, usuario.numeroDocumento, usuario.ultimaSesion, usuario.documentosLabel, usuario.estadosUsuariosLabel];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        } else {
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return NO;
        }
    }
    sqlite3_close(database);
    return NO;
}

- (BOOL)eliminar{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM usuario"];
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, delete_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        } else {
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return NO;
        }
    }
    sqlite3_close(database);
    return NO;
}

- (DataModelUsuario *)obtenerUsuario:(NSString *)token{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    DataModelUsuario * usuario = [[DataModelUsuario alloc]init];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM usuario WHERE token=\"%@\"",
                              token];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                DataModelUsuario * usuario = [[DataModelUsuario alloc]init];
                usuario.usuarioId = [[NSString alloc]
                                     initWithUTF8String:
                                     (const char *) sqlite3_column_text(
                                                                        statement, 0)];
                usuario.token= [[NSString alloc]
                                initWithUTF8String:(const char *)
                                sqlite3_column_text(statement, 1)];
                usuario.nombres= [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 2)];
                usuario.apellidos= [[NSString alloc]
                                    initWithUTF8String:(const char *)
                                    sqlite3_column_text(statement, 3)];
                usuario.correo= [[NSString alloc]
                                 initWithUTF8String:(const char *)
                                 sqlite3_column_text(statement, 4)];
                usuario.numeroDocumento= [[NSString alloc]
                                          initWithUTF8String:(const char *)
                                          sqlite3_column_text(statement, 5)];
                usuario.ultimaSesion= [[NSString alloc]
                                       initWithUTF8String:(const char *)
                                       sqlite3_column_text(statement, 6)];
                usuario.documentosLabel= [[NSString alloc]
                                          initWithUTF8String:(const char *)
                                          sqlite3_column_text(statement, 7)];
                usuario.estadosUsuariosLabel= [[NSString alloc]
                                               initWithUTF8String:(const char *)
                                               sqlite3_column_text(statement, 8)];
                
                sqlite3_finalize(statement);
                sqlite3_close(database);
                
                return usuario;
            } else {
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return usuario;
            }
        }
        sqlite3_close(database);
    }
    sqlite3_close(database);
    return usuario;
}

@end
