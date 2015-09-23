//
//  HomeScreen.m
//  Flappy
//
//  Created by Travis Delly on 9/22/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "HomeScreen.h"
#import "GameScene.h"
#import "CharacterScreen.h"
#import "AppDelegate.h"
#import "BackgroundScene.h"

@interface HomeScreen()

@property SKLabelNode *titleNode;

@property SKSpriteNode *start;
@property SKSpriteNode *more_characters;

@property SKSpriteNode *playingSkin;

@property SKSpriteNode *background;
@property SKSpriteNode* more_background;

@property AppDelegate *sharedDelegate;

@property SKLabelNode* labelLeft;
@property SKLabelNode* labelMid;
@property SKLabelNode* labelRight;

@end

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation HomeScreen{
    
    int charSkin;
}

-(id)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self){
        _sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        
        _background = [SKSpriteNode spriteNodeWithTexture:_sharedDelegate.appBackground];
        _background.position = CGPointMake(self.size.width/2, self.size.height/2);
        _background.size = CGSizeMake(_background.size.width, self.frame.size.height);
        
        _start = [SKSpriteNode spriteNodeWithImageNamed:@"start"];
        _start.position = CGPointMake(self.size.width/2, self.size.height/2+80);
        _start.name = @"start";
        
        _more_characters = [SKSpriteNode spriteNodeWithImageNamed:@"moreChars"];
        _more_characters.position = CGPointMake(self.size.width/2, self.size.height/2);
        _more_characters.zPosition = 10;
        _more_characters.name = @"moreChars";
        
        _more_background = [SKSpriteNode spriteNodeWithImageNamed:@"moreBack1"];
        _more_background.position = CGPointMake(self.size.width/2, self.size.height/2-194);
        _more_background.zPosition = 10;
        _more_background.name = @"moreBack";
        
        
        NSLog(@"%@", _sharedDelegate.appBackground);
        _playingSkin = [SKSpriteNode spriteNodeWithTexture:_sharedDelegate.characterTextureStand];
        _playingSkin.position = CGPointMake(self.size.width/2, self.size.height/2-100);
        _playingSkin.name = @"skin";
        
        _labelLeft = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _labelLeft.fontSize = 40;
        _labelLeft.position = CGPointMake(self.size.width/2-90, 520);
        [_labelLeft setText:@"October"];
        _labelLeft.zPosition = 10;
        
        _labelMid = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _labelMid.position = CGPointMake(self.size.width/2, 600);
        _labelMid.fontSize = 50;
        [_labelMid setText:@"Flappy"];
        _labelMid.zPosition = 10;
        
        _labelRight = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _labelRight.position = CGPointMake(self.size.width/2+90, 520);
        _labelRight.fontSize = 40;
        [_labelRight setText:@"Edition"];
        _labelRight.zPosition = 10;
        
        [self addChild:_labelLeft];
        [self addChild:_labelMid];
        [self addChild:_labelRight];
        
        [self addChild:_more_background];
        [self addChild:_more_characters];
        [self addChild:_background];
        [self addChild:_playingSkin];
        [self addChild:_start];
        
    }
    return self;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _start.texture = [SKTexture textureWithImageNamed:@"start"];
    _more_characters.texture = [SKTexture textureWithImageNamed:@"moreChars"];
    _more_background.texture = [SKTexture textureWithImageNamed:@"moreBack1"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"start"]){
            
            GameScene *game = [GameScene unarchiveFromFile:@"GameScene"];
            game.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:game transition:[SKTransition fadeWithDuration:1]];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"moreChars"]){
            
            CharacterScreen *charScreen = [[CharacterScreen alloc] initWithSize:self.size];
            [self.view presentScene:charScreen transition:[SKTransition fadeWithDuration:2]];
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"moreBack"]){
            
            BackgroundScene *back = [[BackgroundScene alloc]initWithSize:self.size];
            [self.view presentScene:back transition:[SKTransition fadeWithDuration:2]];
            
        }
        
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"start"]){
            _start.texture = [SKTexture textureWithImageNamed:@"startselected"];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"moreChars"]){
            _more_characters.texture = [SKTexture textureWithImageNamed:@"moreCharsSelected"];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"moreBack"]){
            _more_background.texture = [SKTexture textureWithImageNamed:@"moreBack2"];
        }
        
    }
}

@end
