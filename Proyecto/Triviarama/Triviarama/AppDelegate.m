/*
 Archivo: AppDelegate.m
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 23/Octubre/2014
 Descripción general: Clase que administra la aplicacion en general
 
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

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    // Override point for customization after application launch.
        self.music = YES;
        self.soundEffects= YES;
        NSString *music = [[NSBundle mainBundle]pathForResource:@"music" ofType:@"wav"];
        self.audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
        self.audioPlayer1.delegate=self;
        self.audioPlayer1.numberOfLoops = -1;
        [self.audioPlayer1 play];

        
        // Override point for customization after application launch.
        return YES;
}

//detiene o reproduce la musica del juego
- (void)musicChanged{
    if (self.music) {
        [self.audioPlayer1 play];
    }
    else{
        [self.audioPlayer1 stop];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if(self.music){
        [self.audioPlayer1 stop];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (self.music) {
        [self.audioPlayer1 play];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
