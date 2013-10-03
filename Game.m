//
//  Game.m
//  SpaceInvaders
//
//  Created by andreas märki on 30.09.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    Bullet.hidden = YES;
    Shoot.hidden = YES;
    
    for (int i =0; i < MonsterHitArray.count; i++)
    {
        MonsterHitArray[i] = @NO;
        (( UIImageView *)(MonsterArray[i])).hidden = YES; // casting important to tell the compiler what kind of obj he s dealing with
    }
    
    WinOrLoose.hidden = YES;
    MonsterMovement = 5;
    MonsterMoveDown = 5;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if (point.x < 160) ShipMovement = -7;
    else ShipMovement = 7;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    ShipMovement = 0;
}


-(void)MonsterKilled
{
    BulletsOnScreen = 0;
    Bullet.hidden = YES;
    BulletMovement = 0;
    Bullet.center = CGPointMake(222, 556);
    
    int b = 0;// boolean counter
    for (int i =0; i < MonsterHitArray.count; i++)
    {
      if  ([MonsterHitArray[i]  isEqual: @YES])
      {
          b++;
      }
    }
    if (b == MonsterHitArray.count )
    {
        WinOrLoose.text = [NSString stringWithFormat:@"You Win!"];
        WinOrLoose.hidden = NO;
        Ship.hidden= YES;
        Shoot.hidden= YES;
        Exit.hidden = NO;
        Bullet.hidden = YES;
        [MovementTimer invalidate];
    }
    
}

-(IBAction)Shoot:(id)sender
{
    if (BulletsOnScreen ==0)
    {
        Bullet.hidden = NO;
        Bullet.center = CGPointMake(Ship.center.x, 456);
        BulletsOnScreen += 1;
        BulletMovement = 15;
    }
}

-(void)Collition
{
    
    int i =0; // counter for MonsterHitArray wich must have the same length as MonsterArray
    for (UIImageView *monster in MonsterArray)
    {
        if ((CGRectIntersectsRect(Bullet.frame, monster.frame)) && ([MonsterHitArray[i] boolValue] == NO))
        {
            MonsterHitArray[i] = @YES;
            monster.hidden = YES;
            [self MonsterKilled];
            break;
        }
        
        if ((CGRectIntersectsRect(monster.frame, Ship.frame)) && ([MonsterHitArray[i] boolValue] == NO))
        {
            [self GameOver];
        }
        i++;

    }
}



-(void)Movement
{
    [self Collition];
    
    if (((Ship.center.x > 40 )&&(ShipMovement <1)) || ((Ship.center.x < 285)&&(ShipMovement>1)))
    {
        Ship.center = CGPointMake(Ship.center.x + ShipMovement, Ship.center.y);
    }
    Bullet.center = CGPointMake(Bullet.center.x, Bullet.center.y - BulletMovement);
    
    
    BOOL screenEdgeReached = NO;
    for (UIImageView *monster in MonsterArray)
    {
        monster.center = CGPointMake(monster.center.x + MonsterMovement, monster.center.y);
    }
    
    int i =0;
    for (UIImageView *monster in MonsterArray)
    {
        if ((monster.center.x < 15) && ([MonsterHitArray[i]  isEqual: @NO]))
        {
            MonsterMovement = 5;
            screenEdgeReached = YES;
        }
        else if ((monster.center.x > 305) && ([MonsterHitArray[i]  isEqual: @NO]))
        {
            MonsterMovement = -5;
            screenEdgeReached = YES;
        }
        i++;
    }

    if (screenEdgeReached) [self MonsterMoveDown];
    
    if (Bullet.center.y < 0)
    {
        Bullet.hidden = YES;
        BulletsOnScreen = 0;
        BulletMovement = 0;
    }
    
}


-(IBAction)Start:( id)sender
{
    
    
    Start.hidden = YES;
    Exit.hidden = YES;
    Shoot.hidden = NO;
    MonsterArray = [[NSMutableArray alloc] initWithObjects:
                    Monster1,
                    Monster2,
                    Monster3,
                    Monster4,
                    Monster5,
                    Monster6,
                    Monster7,
                    Monster8,
                    Monster9,
                    Monster10,
                    nil];
    // bools can not be assigned to an array because they are primitive types, but numberWithBool is an object
    // and therefore can
    MonsterHitArray = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithBool:Monster1Hit ],
                       [NSNumber numberWithBool:Monster2Hit ],
                       [NSNumber numberWithBool:Monster3Hit ],
                       [NSNumber numberWithBool:Monster4Hit ],
                       [NSNumber numberWithBool:Monster5Hit ],
                       [NSNumber numberWithBool:Monster6Hit ],
                       [NSNumber numberWithBool:Monster7Hit ],
                       [NSNumber numberWithBool:Monster8Hit ],
                       [NSNumber numberWithBool:Monster9Hit ],
                       [NSNumber numberWithBool:Monster10Hit],
                       nil];
    
    for (UIImageView *monster in MonsterArray)
    {
        monster.hidden = NO;
    }
    if (MonsterHitArray.count == MonsterArray.count)// if not checked the app will crash in the collision method!
    {
    MovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(Movement) userInfo:Nil repeats:YES];
    }
    else
    {
        //houston we have a problem!
        NSLog(@"Array lenghts dont match. No gaming for you today!!");
    }
}


-(void)MonsterMoveDown
{
    for (UIImageView *monster in MonsterArray)
    {
        monster.center = CGPointMake(monster.center.x, monster.center.y + MonsterMoveDown);
    }
    
}

-(void)GameOver
{
    WinOrLoose.hidden = NO;
    WinOrLoose.text = [NSString stringWithFormat:@"You Lose!"];
    
    for (UIImageView *monster in MonsterArray)
    {
        monster.hidden = YES;
    }
    Ship.hidden = YES;
    Bullet.hidden = YES;
    Shoot.hidden = YES;
    Exit.hidden = NO;
    [MovementTimer invalidate];// stops timer
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
