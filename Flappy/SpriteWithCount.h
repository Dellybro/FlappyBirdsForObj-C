//
//  SpriteWithCount.h
//  Flappy
//
//  Created by Travis Delly on 9/19/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SpriteWithCount : SKSpriteNode

-(id)initWithTexture:(SKTexture *)texture and:(int)count;

@property int count;

@end
