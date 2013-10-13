//
//  Game.h
//  SpaceInvaders
//
//  Created by andreas märki on 30.09.13.
//  Copyright (c) 2013 andreas märki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

int ShipMovement;
int BulletMovement;
int MonsterBulletMovement1;
int MonsterBulletMovement2;
int MonsterBulletMovement3;

int BulletsOnScreen;
int ShipBullet1OnScreen;
int ShipBullet2OnScreen;
int ShipBullet3OnScreen;
int MonsterMovement;
int MonsterMoveDown;
int ScreenBottom;

BOOL Monster1Hit;
BOOL Monster2Hit;
BOOL Monster3Hit;
BOOL Monster4Hit;
BOOL Monster5Hit;
BOOL Monster6Hit;
BOOL Monster7Hit;
BOOL Monster8Hit;
BOOL Monster9Hit;
BOOL Monster10Hit;
BOOL ShipWasHit;



@interface Game : UIViewController
{
    IBOutlet UIButton *Start;
    IBOutlet UIButton *Exit;
    IBOutlet UIButton *Shoot;
    IBOutlet UIImageView *Ship;
    IBOutlet UIImageView *Monster1Bullet;
    IBOutlet UIImageView *Monster2Bullet;
    IBOutlet UIImageView *Monster3Bullet;
    IBOutlet UIImageView *Bullet;
    IBOutlet UIImageView *Monster1;
    IBOutlet UIImageView *Monster2;
    IBOutlet UIImageView *Monster3;
    IBOutlet UIImageView *Monster4;
    IBOutlet UIImageView *Monster5;
    IBOutlet UIImageView *Monster6;
    IBOutlet UIImageView *Monster7;
    IBOutlet UIImageView *Monster8;
    IBOutlet UIImageView *Monster9;
    IBOutlet UIImageView *Monster10;
    
    IBOutlet UILabel *WinOrLoose;
    
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *audioPlayer2;
    AVAudioPlayer *audioPlayer3;
    AVAudioPlayer *titleSongPlayer;
    
    NSMutableArray * MonsterArray;
    NSMutableArray * MonsterHitArray;
    NSTimer * MovementTimer;
    NSTimer * ShootTimer;
    
}

-(IBAction)Start:( id)sender;
-(IBAction)Shoot:(id)sender;
-(void)Movement;

-(void)Collition;
-(void)MonsterKilled;
-(void)MonsterMoveDown;
-(void)MonsterFire;
-(void)GameOver;


@end
