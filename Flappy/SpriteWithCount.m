//
//  SpriteWithCount.m
//  Flappy
//
//  Created by Travis Delly on 9/19/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "SpriteWithCount.h"

@implementation SpriteWithCount
-(id)initWithTexture:(SKTexture *)texture and:(int)count{
    self = [super initWithTexture:texture];
    if(self) {
        _count = count;
    }
    return self;
    
}
@end
