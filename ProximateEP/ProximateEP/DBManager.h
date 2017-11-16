//
//  DBManager.h
//  ProximateEP
//
//  Created by Julio Torres on 16/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelUsuario.h"

#import <sqlite3.h>


@interface DBManager : NSObject{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)guardar:(DataModelUsuario*)Usuario;
-(BOOL)eliminar;
-(DataModelUsuario *)obtenerUsuario:(NSString*)token;

@end
