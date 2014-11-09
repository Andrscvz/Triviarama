/*
 Archivo: TriviaramaViewController.m
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 23/Octubre/2014
 Descripción general: Controlador que maneja los elementos de la vista con la que inicia la aplicacion
 
 Triviarama - Memorama que consiste en emparejar cada pregunta de trivia con su respuesta correspondiente.
 Copyright (C) 2014 - ITESM
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.
 
 Authors:
 
 ITESM representatives
 Ing. Martha Sordia Salinas <msordia@itesm.mx>
 Ing. Mario de la Fuente <mario.delafuente@itesm.mx>
 
 ITESM students
 Andrés Gerardo Cavazos Hernández – A01195067
 Roberto Carlos Rivera Martínez – A00618181
 Fernando Javier Garza Brambila – A01034753
 Marialicia Villarreal García – A00811095
 */
#import "TriviaramaViewController.h"

@interface TriviaramaViewController ()

@end

@implementation TriviaramaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"LaunchImage0000.png"],
                                 [UIImage imageNamed:@"LaunchImage0001.png"],
                                 [UIImage imageNamed:@"LaunchImage0002.png"],
                                 [UIImage imageNamed:@"LaunchImage0003.png"],
                                 [UIImage imageNamed:@"LaunchImage0004.png"],
                                 [UIImage imageNamed:@"LaunchImage0005.png"],
                                 [UIImage imageNamed:@"LaunchImage0006.png"],
                                 [UIImage imageNamed:@"LaunchImage0007.png"],
                                 [UIImage imageNamed:@"LaunchImage0008.png"],
                                 [UIImage imageNamed:@"LaunchImage0009.png"],
                                 [UIImage imageNamed:@"LaunchImage0010.png"],
                                 [UIImage imageNamed:@"LaunchImage0011.png"],
                                 [UIImage imageNamed:@"LaunchImage0012.png"],
                                 [UIImage imageNamed:@"LaunchImage0013.png"],
                                 [UIImage imageNamed:@"LaunchImage0014.png"],
                                 [UIImage imageNamed:@"LaunchImage0015.png"],
                                 [UIImage imageNamed:@"LaunchImage0016.png"],
                                 [UIImage imageNamed:@"LaunchImage0017.png"],
                                 [UIImage imageNamed:@"LaunchImage0018.png"],
                                 [UIImage imageNamed:@"LaunchImage0019.png"],
                                 [UIImage imageNamed:@"LaunchImage0020.png"],
                                 [UIImage imageNamed:@"LaunchImage0021.png"],
                                 [UIImage imageNamed:@"LaunchImage0022.png"],
                                 [UIImage imageNamed:@"LaunchImage0023.png"],
                                 [UIImage imageNamed:@"LaunchImage0024.png"],
                                 [UIImage imageNamed:@"LaunchImage0025.png"],
                                 [UIImage imageNamed:@"LaunchImage0026.png"],
                                 [UIImage imageNamed:@"LaunchImage0027.png"],
                                 [UIImage imageNamed:@"LaunchImage0028.png"],
                                 [UIImage imageNamed:@"LaunchImage0029.png"],
                                 [UIImage imageNamed:@"LaunchImage0030.png"],
                                 [UIImage imageNamed:@"LaunchImage0031.png"],
                                 [UIImage imageNamed:@"LaunchImage0032.png"],
                                 [UIImage imageNamed:@"LaunchImage0033.png"], nil];
    
    
    _imageView.animationDuration = 3.0;
    _imageView.animationRepeatCount = 1;
    [_imageView startAnimating];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackgroundPantallaInicio.jpg"]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwind1:(UIStoryboardSegue *)segue{
    
}

@end
