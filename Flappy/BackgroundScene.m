//
//  BackgroundScene.m
//  Flappy
//
//  Created by Travis Delly on 9/23/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "BackgroundScene.h"
#import "AppDelegate.h"
#import "HomeScreen.h"

@interface BackgroundScene()

@property SKSpriteNode *backgroundOne;
@property SKSpriteNode *backgroundTwo;

@property SKSpriteNode *select;
@property SKSpriteNode *selection;

@property AppDelegate *sharedDelegate;

@end

@implementation BackgroundScene{
    int backgroundSkin;
}

-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self) {
        
        _sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        _select = [SKSpriteNode spriteNodeWithImageNamed:@"select1"];
        _select.position = CGPointMake(self.frame.size.width/2, 600);
        _select.name = @"select";
        
        _backgroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
        _backgroundOne.size = CGSizeMake(75, 100);
        _backgroundOne.position = CGPointMake(75, 450);
        _backgroundOne.name = @"october";
        
        
        _backgroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        _backgroundTwo.size = CGSizeMake(75, 100);
        _backgroundTwo.position = CGPointMake(200, 450);
        _backgroundTwo.name = @"flappy";
        
        backgroundSkin = 1;
        _selection = [SKSpriteNode spriteNodeWithImageNamed:@"selection"];
        _selection.position = _backgroundOne.position;
        _selection.size = CGSizeMake(80, 120);
        
        [self addChild:_select];
        [self addChild:_selection];
        [self addChild:_backgroundOne];
        [self addChild:_backgroundTwo];
        
    }
    return self;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _select.texture = [SKTexture textureWithImageNamed:@"select1"];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"select"]){
            
            
            if(backgroundSkin == 1){
                _sharedDelegate.appBackground = [SKTexture textureWithImageNamed:@"bg"];
            }else if(backgroundSkin == 2){
                _sharedDelegate.appBackground = [SKTexture textureWithImageNamed:@"background"];
            }
            
            
            HomeScreen *home = [[HomeScreen alloc]initWithSize:self.size];
            [self.view presentScene:home transition:[SKTransition fadeWithDuration:2]];
            
        } else if([[self nodeAtPoint:location].name isEqualToString:@"october"]){
            _selection.position = _backgroundOne.position;
            backgroundSkin = 1;
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"flappy"]){
            _selection.position = _backgroundTwo.position;
            backgroundSkin = 2;
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"select"]){
            _select.texture = [SKTexture textureWithImageNamed:@"select2"];
        }
    }
}

@end
