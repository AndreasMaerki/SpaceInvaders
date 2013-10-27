//
//  GameObject.h
//  SpaceInvaders
//
//  Created by andreas märki on 24.10.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AbstractGameObject : NSObject
{
    CGPoint centerOfObject;
    UIImageView *objectRepresentationOnScreen;
    
    BOOL gameObjectIsAlive;
    BOOL gameObjectIsVisible;
    
    int objectSpeed;
    int objectMoveDown;
    int movingDirection; // 0 to the left, 1 to the right
    int leftBoundry;
    int rightBoundry;
    
    
}

-(void)moveObject;
-(void)killGameObject;


@end
