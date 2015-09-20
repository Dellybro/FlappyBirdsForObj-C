//
//  GameScene.m
//  Flappy
//
//  Created by Travis Delly on 9/19/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "GameScene.h"
#import <math.h>
#import "SpriteWithCount.h"


@interface GameScene()

//Reset
@property SKLabelNode* restartLabel;
@property SKSpriteNode* restartButton;

//Game Objects
@property SKNode *movingObjects;
@property SKSpriteNode *labelHolder;
@property SKSpriteNode *bird;
@property SKSpriteNode *background;
@property SKSpriteNode *ground;
@property SKLabelNode *scoreBoard;
@property int gameOver;
@property int score;

//Groupings
@property float birdGroup;
@property float objGroup;
@property float gapGroup;
@property float bonusGroup;



@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.physicsWorld.contactDelegate = self;
    
    _gameOver = 0;
    _score = 0;
    _birdGroup = 1;
    _objGroup = 2;
    _gapGroup = 0 << 3;
    _bonusGroup = 0x1 << 4;
    [self setup];
    /* Setup your scene here */
}
-(void)makeBackground{
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"bg"];
    
    SKAction *moveBG = [SKAction moveByX:-backgroundTexture.size.width y:0 duration:9];
    SKAction *repeatBackground = [SKAction moveByX:backgroundTexture.size.width y:0 duration:0];
    SKAction *movebackgroundForever = [SKAction repeatActionForever:[SKAction sequence:@[moveBG, repeatBackground]]];
    for (CGFloat i = 0; i < 3; i++) {
        _background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        _background.position = CGPointMake(backgroundTexture.size.width/2 + backgroundTexture.size.width * i, CGRectGetMidY(self.frame));
        _background.size = CGSizeMake(_background.size.width, self.frame.size.height);
        [_background runAction:movebackgroundForever];
        _background.zPosition = 1;
        
        [_movingObjects addChild:_background];
    }
    
}
-(void)runPipes{
    //Gapheight should be 4x size of bird
    CGFloat gapHeight = _bird.size.height*4;
    CGFloat movementAmmount = fmodf(arc4random(), self.frame.size.height/2);
    CGFloat pipeOffset = movementAmmount - self.frame.size.height/4;
    
    //MovePipes for a duration of time
    SKAction *movePipes = [SKAction moveByX:-self.frame.size.width * 2 y:0 duration:10.25];
    SKAction *removePipes = [SKAction removeFromParent];
    SKAction *moveAndRemovePipes = [SKAction sequence:@[movePipes, removePipes]];
    
    //CreatePipes
    SKTexture *upPipeTexture = [SKTexture textureWithImageNamed:@"pipe1"];
    SKSpriteNode *upPipe = [SKSpriteNode spriteNodeWithTexture:upPipeTexture];
    upPipe.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) + upPipe.size.height/2 + gapHeight/2 + pipeOffset);
    [upPipe runAction:moveAndRemovePipes];
    upPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:upPipe.size];
    upPipe.physicsBody.dynamic = FALSE;
    upPipe.physicsBody.categoryBitMask = _objGroup;
    upPipe.physicsBody.collisionBitMask = _birdGroup;
    upPipe.physicsBody.contactTestBitMask = _birdGroup;
    upPipe.zPosition = 5;
    
    
    SKTexture *downPipeTexture = [SKTexture textureWithImageNamed:@"pipe2"];
    SKSpriteNode* downPipe = [SKSpriteNode spriteNodeWithTexture:downPipeTexture];
    downPipe.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) - downPipe.size.height/2 - gapHeight / 2 + pipeOffset);
    [downPipe runAction:moveAndRemovePipes];
    downPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:downPipe.size];
    downPipe.physicsBody.dynamic = FALSE;
    downPipe.physicsBody.categoryBitMask = _objGroup;
    downPipe.physicsBody.collisionBitMask = _birdGroup;
    downPipe.physicsBody.contactTestBitMask = _birdGroup;
    downPipe.zPosition = 5;
    
    //Make Gap to keep Score
    
    SKNode *gap = [[SKNode alloc] init];
    gap.position = CGPointMake( CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) + pipeOffset);
    gap.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(upPipe.size.width, gapHeight)];
    [gap runAction:moveAndRemovePipes];
    gap.physicsBody.dynamic = false;
    gap.physicsBody.categoryBitMask = _gapGroup;
    gap.physicsBody.collisionBitMask = _birdGroup;
    gap.physicsBody.contactTestBitMask = _birdGroup;
    
    //Candy
    
    float candyNumber = arc4random_uniform(100);
    NSLog(@"candy number: %f", candyNumber);
    
    if(fmodf(candyNumber, 5) == 0){
        SKTexture *chocolatebarSprite = [SKTexture textureWithImageNamed:@"chocolateBar"];
        SpriteWithCount *candy = [self makeCandy:chocolatebarSprite and:3];
        [candy runAction:moveAndRemovePipes];
        [_movingObjects addChild:candy];
    }else if (fmodf(candyNumber, 3) == 0){
        SKTexture *candycornSprite = [SKTexture textureWithImageNamed:@"candycorn"];
        SpriteWithCount *candy = [self makeCandy:candycornSprite and:2];
        [candy runAction:moveAndRemovePipes];
        [_movingObjects addChild:candy];
    }else if(fmodf(candyNumber, 2) == 0){
        SKTexture *pumpkinSprite = [SKTexture textureWithImageNamed:@"pumpkin"];
        SpriteWithCount *candy = [self makeCandy:pumpkinSprite and:1];
        [candy runAction:moveAndRemovePipes];
        [_movingObjects addChild:candy];
    }
    
    
    [_movingObjects addChild:gap];
    [_movingObjects addChild:downPipe];
    [_movingObjects addChild:upPipe];
    
    
    
}

-(SpriteWithCount*)makeCandy:(SKTexture*)skin and:(int)count{
    NSLog(@"Candy made");
    float randomSpot = arc4random_uniform(2);
    if(randomSpot == 0){ randomSpot = 2; }
    
    SpriteWithCount *candy = [[SpriteWithCount alloc] initWithTexture:skin and:count];
    candy.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width+210*randomSpot, 210*randomSpot);
    candy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(candy.size.width, candy.size.height)];
    candy.physicsBody.dynamic = false;
    candy.physicsBody.categoryBitMask = _bonusGroup;
    candy.physicsBody.contactTestBitMask = _birdGroup;
    candy.zPosition = 8;
    
    
    return candy;
}
-(void)setup{
    self.physicsWorld.gravity = CGVectorMake(0, -5);
    _movingObjects = [[SKNode alloc] init];
    _labelHolder = [[SKSpriteNode alloc] init];
    [self addChild:_labelHolder];
    [self addChild:_movingObjects];
    
    
    //SetupBackground + score
    
    _scoreBoard = [[SKLabelNode alloc] init];
    _scoreBoard.fontName = @"Chalkduster";
    _scoreBoard.fontSize = 50;
    _scoreBoard.zPosition = 9;
    _scoreBoard.text = @"0";
    _scoreBoard.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70);
    
    [self makeBackground];
    
    [self addChild:_scoreBoard];
    
    //SetupTextures and animation for bird
    SKTexture *birdTexture = [SKTexture textureWithImageNamed:@"flappy1"];
    SKAction *animationForBird = [SKAction animateWithTextures:@[birdTexture] timePerFrame:.1];
    SKAction *makeBirdFlapWithAnimation = [SKAction repeatActionForever:animationForBird];
    
    //Make Bird
    _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture];
    _bird.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    _bird.zPosition = 10;
    [_bird runAction:makeBirdFlapWithAnimation];
    _bird.physicsBody.categoryBitMask = _birdGroup;
    
    //Create the body for physics stuff.
    _bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_bird.size.height/2];
    _bird.physicsBody.dynamic = YES;
    _bird.physicsBody.allowsRotation = false;
    
    //Run pipes
    NSTimer *pipeTimer = [NSTimer scheduledTimerWithTimeInterval:2.8 target:self selector:@selector(runPipes) userInfo:nil repeats:true];
    
    //Create ground.
    _ground = [[SKSpriteNode alloc] init];
    _ground.position = CGPointMake(0,0);
    _ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, 1)];
    _ground.physicsBody.dynamic = false;
    _ground.physicsBody.categoryBitMask = _objGroup;
    _ground.physicsBody.collisionBitMask = _birdGroup;
    _ground.physicsBody.contactTestBitMask = _birdGroup;
    
    [self addChild:_bird];
    [self addChild:_ground];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if(_gameOver == 0){
        _bird.physicsBody.velocity = CGVectorMake(0, 0);
        [_bird.physicsBody applyImpulse:CGVectorMake(0, 50)];
        SKTexture *birdFlap = [SKTexture textureWithImageNamed:@"flappy2"];
        SKAction *animationForBird = [SKAction animateWithTextures:@[birdFlap] timePerFrame:.3];
        [_bird runAction:animationForBird];
    } else {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            if([[self nodeAtPoint:location].name isEqualToString:@"resetButton"]){
                _score = 0;
                _gameOver = 0;
                _scoreBoard.text = @"0";
                [self addChild:_ground];
                [_movingObjects removeAllChildren];
                [self makeBackground];
                [_labelHolder removeAllChildren];
                _bird.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
                _bird.physicsBody.velocity = CGVectorMake(0, 0);
                _movingObjects.speed = 1;
            }
        }
    }
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    if(contact.bodyA.categoryBitMask == _gapGroup || contact.bodyB.categoryBitMask == _gapGroup){
        _score++;
        _scoreBoard.text = [NSString stringWithFormat:@"%d", _score];
    } else if(contact.bodyA.categoryBitMask == _bonusGroup || contact.bodyB.categoryBitMask == _bonusGroup){
        
        NSLog(@"Here");
        SpriteWithCount *node = (SpriteWithCount*)contact.bodyA.node;
        
        if(node.count == 3){
            _score+=5;
        }else if(node.count == 2){
            _score+=3;
        } else if(node.count == 1){
            _score+=2;
        } else {
            NSLog(@"Error");
        }
        
        _scoreBoard.text = [NSString stringWithFormat:@"%d", _score];
        [node removeFromParent];
    }else if (contact.bodyA.categoryBitMask == _objGroup || contact.bodyB.categoryBitMask == _objGroup){
        _gameOver = 1;
        _movingObjects.speed = 0;
        [_ground removeFromParent];
        
        _restartLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        _restartLabel.fontSize = 20;
        _restartLabel.zPosition = 11;
        _restartLabel.text = @"Game Over!";
        _restartLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [_restartLabel removeFromParent];
        
        SKTexture *resetTexture = [SKTexture textureWithImageNamed:@"reset"];
        _restartButton = [[SKSpriteNode alloc] initWithTexture:resetTexture];
        _restartButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-50);
        _restartButton.name = @"resetButton";
        _restartButton.zPosition = 11;
        
        
        [_labelHolder addChild:_restartLabel];
        [_labelHolder addChild:_restartButton];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
