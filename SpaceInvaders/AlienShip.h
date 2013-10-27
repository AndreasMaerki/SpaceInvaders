//
//  AlienShip.h
//  SpaceInvaders
//
//  Created by andreas märki on 26.10.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import "AbstractGameObject.h"

@interface AlienShip : AbstractGameObject


-(void)fire: (UIImageView *)objectToBeFired withYAxisStartPositionOffset: (int)yOffset;



@end
