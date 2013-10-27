//
//  AlienShip.m
//  SpaceInvaders
//
//  Created by andreas märki on 26.10.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import "AlienShip.h"

@implementation AlienShip



-(void)moveObject
{
    // change direction if boundries are crossed by making the next move, and move 1 step down
    if (centerOfObject.x + objectSpeed > rightBoundry)
    {
        movingDirection = 0;
        centerOfObject.y += objectMoveDown;
    }
    else if (centerOfObject.x - objectSpeed < rightBoundry)
    {
        movingDirection = 1;
        centerOfObject.y += objectMoveDown;
    }
    
    // move the object sideways
    if (movingDirection ==0)
    {
        centerOfObject.x -= objectSpeed;
    }
    else
    {
        centerOfObject.x += objectSpeed;
    }
    objectRepresentationOnScreen.center = centerOfObject;
}

-(void)fire:(UIImageView *)objectToBeFired withYAxisStartPositionOffset:(int) yOffset
{
    objectToBeFired.center = CGPointMake(centerOfObject.x, centerOfObject.y + yOffset);
}




@end
