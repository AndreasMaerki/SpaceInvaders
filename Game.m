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
    
    Monster1Bullet.hidden = YES;
    Monster2Bullet.hidden = YES;
    Monster3Bullet.hidden = YES;
    
    MonsterHitArray = nil;
    MonsterArray = nil;
    
    for (int i =0; i < MonsterHitArray.count; i++)
    {
        MonsterHitArray[i] = @NO;
        (( UIImageView *)(MonsterArray[i])).hidden = YES; // casting important to tell the compiler what kind of obj he s dealing with
    }
    
    WinOrLoose.hidden = YES;
    MonsterMovement = 5;
    MonsterMoveDown = 5;
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/LASER1.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    
    NSURL *url4 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/starSoundTrack.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSError *error4;
    titleSongPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url4 error:&error4];
    titleSongPlayer.numberOfLoops = -1;
    

    
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer3.numberOfLoops = 0;
    
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/LASER2.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSError *error2;
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:&error2];
    audioPlayer2.numberOfLoops = 0;
    
    [titleSongPlayer prepareToPlay];
    [audioPlayer prepareToPlay];
    [audioPlayer2 prepareToPlay];
    [audioPlayer3 prepareToPlay];
    
    [super viewDidLoad];
}

-(IBAction)Start:( id)sender
{
    
    [titleSongPlayer play];
    Start.hidden = YES;
    Exit.hidden = YES;
    Shoot.hidden = NO;
    ScreenBottom = 578;
    
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
        ShootTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(MonsterFire) userInfo:Nil repeats:YES];
    }
    else
    {
        //houston we have a problem!
        NSLog(@"Array lenghts dont match. No gaming for you today!!");
    }
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


-(void)drawRect: (CGRect)rect
{
    CGColorRef white = [[UIColor whiteColor] CGColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, white);
    CGContextFillRect(context, CGRectMake(10, 10, 100, 100));
    
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
        [titleSongPlayer stop];
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
        Bullet.center = CGPointMake(Ship.center.x, 469);
        BulletsOnScreen += 1;
        BulletMovement = 25;
        if (!audioPlayer.playing)
        {
            [audioPlayer play];
            [audioPlayer3 setCurrentTime:0.0];
        }
        else
        {
            [audioPlayer3 play];
            [audioPlayer setCurrentTime:0.0];
        }
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
        
        if (CGRectIntersectsRect(Monster1Bullet.frame, Ship.frame) ||  CGRectIntersectsRect(Monster2Bullet.frame, Ship.frame) || CGRectIntersectsRect(Monster3Bullet.frame, Ship.frame))
        {
            [self GameOver];
        }
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
    
    //checking wether a monster has reached the screen edge
    // if so, we change the direction in wich all onsters move as well, and move one step down
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
    
    
    // monster bullets
    if (Monster1Bullet.hidden == NO)
    {
        Monster1Bullet.center = CGPointMake(Monster1Bullet.center.x, Monster1Bullet.center.y + MonsterBulletMovement1);
        if (Monster1Bullet.center.y > ScreenBottom)
        {
            Monster1Bullet.hidden = YES;
            MonsterBulletMovement1 = 0;
            Monster1Bullet.center = CGPointMake(Monster1Bullet.center.x, 12);
        }
    }
    if (Monster2Bullet.hidden == NO)
    {
        Monster2Bullet.center = CGPointMake(Monster2Bullet.center.x, Monster2Bullet.center.y + MonsterBulletMovement2);
        if (Monster2Bullet.center.y > ScreenBottom)
        {
            Monster2Bullet.hidden = YES;
            MonsterBulletMovement2 = 0;
            Monster2Bullet.center = CGPointMake(Monster2Bullet.center.x, 12);

        }

    }
    if (Monster3Bullet.hidden == NO)
    {
        Monster3Bullet.center = CGPointMake(Monster3Bullet.center.x, Monster3Bullet.center.y + MonsterBulletMovement3);
        if (Monster3Bullet.center.y == ScreenBottom)
        {
            Monster3Bullet.hidden = YES;
            MonsterBulletMovement3 = 0;
            Monster3Bullet.center = CGPointMake(Monster3Bullet.center.x, 12);

        }

    }
    
}




-(void)MonsterMoveDown
{
    for (UIImageView *monster in MonsterArray)
    {
        monster.center = CGPointMake(monster.center.x, monster.center.y + MonsterMoveDown);
    }
    
}


// select a random monster and place the bullet in its center and show it if its not already visible, wich would mean it has been fired.
-(void)MonsterFire
{
    int randomInt = arc4random() % MonsterArray.count;
    int moveBulletBottomOfShip = 35;
    if ([MonsterHitArray[randomInt] boolValue ] == NO)// dont fire if the ship was already destroyed.
    {
        if (Monster1Bullet.hidden)
        {
            Monster1Bullet.center = CGPointMake((( UIImageView *)(MonsterArray[randomInt])).center.x,(( UIImageView *)(MonsterArray[randomInt])).center.y+ moveBulletBottomOfShip);
            Monster1Bullet.hidden= NO;
            MonsterBulletMovement1 = 8;
            [audioPlayer2 play];
        }
        else if (Monster2Bullet.hidden)
        {
            Monster2Bullet.center = CGPointMake((( UIImageView *)(MonsterArray[randomInt])).center.x,(( UIImageView *)(MonsterArray[randomInt])).center.y + moveBulletBottomOfShip);
            Monster2Bullet.hidden= NO;
            MonsterBulletMovement2 = 8;
            [audioPlayer2 play];
        }
        else if (Monster3Bullet.hidden)
        {
            Monster3Bullet.center = CGPointMake((( UIImageView *)(MonsterArray[randomInt])).center.x,(( UIImageView *)(MonsterArray[randomInt])).center.y + moveBulletBottomOfShip);
            Monster3Bullet.hidden= NO;
            MonsterBulletMovement3 = 8;
            [audioPlayer2 play];
        }
    }
}

-(void)GameOver
{
    [titleSongPlayer stop];
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
    [ShootTimer invalidate ];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
