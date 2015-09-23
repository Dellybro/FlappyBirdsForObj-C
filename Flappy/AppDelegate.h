//
//  AppDelegate.h
//  Flappy
//
//  Created by Travis Delly on 9/19/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "CustomGUI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property SKTexture* characterTextureStand;
@property SKTexture* characterTextureFlap;
@property SKTexture* appBackground;

@end

