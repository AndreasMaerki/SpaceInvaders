//
//  GameObject.m
//  SpaceInvaders
//
//  Created by andreas märki on 24.10.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//


#import "AbstractGameObject.h"

// because no abstract classes exist in obj c, we have to prevent user from calleng methods whitout overriding them
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#define methodNotImplemented() mustOverride()


@interface AbstractGameObject()

@property BOOL gameObjectIsAlive;
@property BOOL gameObjectIsVisible;
@property int objectSpeed;
@property int objectMoveDown;
@property int leftBoundry;
@property int rightBoundry;

@end

@implementation AbstractGameObject

@synthesize gameObjectIsAlive = _gameObjectIsAlive;
@synthesize gameObjectIsVisible = _gameObjectIsVisible;
@synthesize objectSpeed = _objectSpeed;
@synthesize objectMoveDown = _objectMoveDown;
@synthesize leftBoundry = _leftBoundry;
@synthesize rightBoundry = _rightBoundry;


-(void)moveObject
{
    mustOverride();
}


-(void)killGameObject
{
    gameObjectIsVisible = NO;
    gameObjectIsAlive = NO;
    objectRepresentationOnScreen.hidden = YES;
}

@end
