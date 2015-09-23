//
//  CharacterScreen.m
//  Flappy
//
//  Created by Travis Delly on 9/23/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "CharacterScreen.h"
#import "AppDelegate.h"
#import "HomeScreen.h"

@interface CharacterScreen()

@property SKSpriteNode* bat;
@property SKSpriteNode *zombie;
@property SKSpriteNode *pumpkinHead;
@property SKSpriteNode *marioSkin;
@property SKSpriteNode *autumnSkin;
@property SKSpriteNode *ghostSkin;
@property SKSpriteNode *birdSkin;

@property SKSpriteNode *select;
@property SKSpriteNode *selection;

@property AppDelegate *sharedDelegate;

@end

@implementation CharacterScreen{
    int charSkin;
}

-(id)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self) {
        _sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        
        
        _bat = [SKSpriteNode spriteNodeWithImageNamed:@"batUp"];
        _bat.position = CGPointMake(75, 500);
        _bat.name = @"bat";
        [self makeAnimation:@"batUp" and:@"batFlap" with:_bat];
        
        
        
        _zombie = [SKSpriteNode spriteNodeWithImageNamed:@"zombieWalk"];
        _zombie.position = CGPointMake(75, 400);
        _zombie.name = @"zombie";
        [self makeAnimation:@"zombieWalk" and:@"zombieJumping" with:_zombie];
        

        _pumpkinHead = [SKSpriteNode spriteNodeWithImageNamed:@"pumpkinHeadStand"];
        _pumpkinHead.position = CGPointMake(75, 300);
        _pumpkinHead.name = @"pumpkin";
        [self makeAnimation:@"pumpkinHeadStand" and:@"pumpkinHeadJump" with:_pumpkinHead];
        
        _marioSkin = [SKSpriteNode spriteNodeWithImageNamed:@"marioStanding"];
        _marioSkin.position = CGPointMake(75, 200);
        _marioSkin.name = @"mario";
        [self makeAnimation:@"marioStanding" and:@"marioJumping" with:_marioSkin];
        
        _birdSkin = [SKSpriteNode spriteNodeWithImageNamed:@"flappy1"];
        _birdSkin.position = CGPointMake(200, 500);
        _birdSkin.name = @"flappy";
        [self makeAnimation:@"flappy1" and:@"flappy2" with:_birdSkin];
        
        _autumnSkin = [SKSpriteNode spriteNodeWithImageNamed:@"autumnFlappy1"];
        _autumnSkin.position = CGPointMake(200, 400);
        _autumnSkin.name = @"autumnFlappy";
        _autumnSkin.zPosition = 10;
        [self makeAnimation:@"autumnFlappy1" and:@"autumnFlappy2" with:_autumnSkin];
        
        _ghostSkin = [SKSpriteNode spriteNodeWithImageNamed:@"ghostimg"];
        _ghostSkin.position = CGPointMake(200, 300);
        _ghostSkin.zPosition = 10;
        _ghostSkin.name = @"ghost";
        [self makeAnimation:@"ghostimg" and:@"ghostimgflap" with:_ghostSkin];
        
        
        _select = [SKSpriteNode spriteNodeWithImageNamed:@"select1"];
        _select.position = CGPointMake(self.frame.size.width/2, 600);
        _select.name = @"select";
        
        charSkin = 1;
        _selection = [SKSpriteNode spriteNodeWithImageNamed:@"selection"];
        _selection.position = _bat.position;
        
        [self addChild:_selection];
        [self addChild:_select];
        [self addChild:_marioSkin];
        [self addChild:_birdSkin];
        [self addChild:_ghostSkin];
        [self addChild:_autumnSkin];
        [self addChild:_bat];
        [self addChild:_zombie];
        [self addChild:_pumpkinHead];
        
        
    }
    return self;
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _select.texture = [SKTexture textureWithImageNamed:@"select1"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"select"]){
            
            if(charSkin == 1){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"batUp"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"batFlap"];
            }else if(charSkin == 2){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"marioStanding"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"marioJumping"];
            }else if(charSkin == 3){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"zombieWalk"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"zombieJumping"];
            }else if(charSkin == 4){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"pumpkinHeadStand"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"pumpkinHeadJump"];
            }else if(charSkin == 5){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"ghostimg"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"ghostimgflap"];
            }else if(charSkin == 6){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"autumnFlappy1"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"autumnFlappy2"];
            }else if(charSkin == 7){
                _sharedDelegate.characterTextureStand = [SKTexture textureWithImageNamed:@"flappy1"];
                _sharedDelegate.characterTextureFlap = [SKTexture textureWithImageNamed:@"flappy2"];
            }
            
            
            HomeScreen *homeScreen = [[HomeScreen alloc] initWithSize:self.size];
            [self.view presentScene:homeScreen];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"bat"]){
            charSkin = 1;
            SKAction *action = [SKAction moveTo:_bat.position duration:.5];
            [_selection runAction:action];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"mario"]){
            charSkin = 2;
            SKAction *action = [SKAction moveTo:_marioSkin.position duration:.5];
            [_selection runAction:action];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"zombie"]){
            
            charSkin = 3;
            SKAction *action = [SKAction moveTo:_zombie.position duration:.5];
            [_selection runAction:action];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"pumpkin"]){
            
            charSkin = 4;
            SKAction *action = [SKAction moveTo:_pumpkinHead.position duration:.5];
            [_selection runAction:action];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ghost"]){
            charSkin = 5;
            SKAction *action = [SKAction moveTo:_ghostSkin.position duration:.5];
            [_selection runAction:action];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"autumnFlappy"]){
            charSkin = 6;
            SKAction *action = [SKAction moveTo:_autumnSkin.position duration:.5];
            [_selection runAction:action];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"flappy"]){
            charSkin = 7;
            SKAction *action = [SKAction moveTo:_birdSkin.position duration:.5];
            [_selection runAction:action];
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
-(void)makeAnimation:(NSString*)nameOfTexture1 and:(NSString*)nameOfTexture2 with:(SKSpriteNode*)node{
    SKTexture *texture1 = [SKTexture textureWithImageNamed:nameOfTexture1];
    SKTexture *texture2 = [SKTexture textureWithImageNamed:nameOfTexture2];
    SKAction *animate = [SKAction animateWithTextures:@[texture1, texture2] timePerFrame:.4];
    SKAction *makeAnimation = [SKAction repeatActionForever:animate];
    
    [node runAction:makeAnimation];
    
}

@end
