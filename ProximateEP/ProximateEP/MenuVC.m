//
//  MenuVC.m
//  ProximateEP
//
//  Created by Julio Torres on 15/11/17.
//  Copyright © 2017 Julio Torres. All rights reserved.
//

#import "MenuVC.h"
#import "LoginVC.h"

@interface MenuVC ()

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"RutaImagen"] length] > 0){
        _imagenUsuario.image =[UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] stringForKey:@"RutaImagen"]];
    }else{
      _imagenUsuario.image = [UIImage imageNamed:@"usuario"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell1";
    
    if(indexPath.row == 0)
        CellIdentifier = @"Cell1";
    else if(indexPath.row == 1)
        CellIdentifier = @"Cell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 1){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RutaImagen"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        LoginVC * log = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:log animated:YES];
    }
}

@end
