//
//  GameViewController.h
//  Flappy
//

//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "HomeScreen.h"
#import "GameScene.h"

@interface GameViewController : UIViewController

@property HomeScreen *home;
@property GameScene *game;


@end
