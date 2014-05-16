//
//  RTPhage.m
//  PhageVectorTest
//
//  Created by Ryo Tulman on 5/15/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPhage.h"

@implementation RTPhage

#define TOTAL_TRAVEL_PIX_PER_UPDATE 8

- (instancetype)initWithCell:(RTCell *)cell
{
    if (self = [super init]) {
        self.name = @"Phage";
        self.targetCell = cell;
        self.position = cell.position;
        self.size = CGSizeMake(20, 20);
        if ([cell.fillColor isEqual:[UIColor redColor]]) {
            self.color = [UIColor orangeColor];
        } else {
            self.color = [UIColor purpleColor];
        }
    }
    return self;
}

-(void)updatePhage//WithDeltaTime:(CFTimeInterval)dt
{
    // target is at 40, 50
    // phage is at 20, 25
    if (_targetCell) {
        CGFloat targetCellX = _targetCell.position.x + _targetCell.frame.size.width/2; // 40
        CGFloat targetCellY = _targetCell.position.y + _targetCell.frame.size.height/2; // 50
        CGFloat xDiff = abs(abs(targetCellX) - abs(self.position.x + self.frame.size.width/2)); // 20
        CGFloat yDiff = abs(abs(targetCellY) - abs(self.position.y + self.frame.size.height/2)); // 25

        CGFloat totalDistance = xDiff + yDiff;
        
        //handle orbit
        if (totalDistance < 50) {
            if (_targetCell.player != self.player) {
                [self attackCell];
            } else {
                //ORBIT
                NSInteger xRandomImpulse = arc4random_uniform(5);
                NSInteger yRandomImpulse = 5 - xRandomImpulse;
                NSInteger xDirectionPositive = arc4random() % 2 ? 1 : -1;
                NSInteger yDirectionPositive = arc4random() % 2 ? 1 : -1;
                xRandomImpulse = xDirectionPositive * xRandomImpulse;
                yRandomImpulse = yDirectionPositive * yRandomImpulse;
                self.position = CGPointMake(self.position.x + xRandomImpulse, self.position.y + yRandomImpulse);
                return;
            }
            
        }
        
        CGFloat distanceRatioForX = xDiff/totalDistance;
        CGFloat distanceRatioForY = yDiff/totalDistance;
        
        CGFloat xAbsoluteAmountToMove = distanceRatioForX * TOTAL_TRAVEL_PIX_PER_UPDATE;
        CGFloat yAbsoluteAmountToMove = distanceRatioForY * TOTAL_TRAVEL_PIX_PER_UPDATE;
        
        CGFloat xToMove, yToMove;
        //RESTORE NEGATIVE MOVEMENT IF THE DIFFERENCE IS NEGATIVE
        if (targetCellX - self.position.x < 0) {
            xToMove = -xAbsoluteAmountToMove;
        } else {
            xToMove = xAbsoluteAmountToMove;
        }
        if (targetCellY - self.position.y < 0) {
            yToMove = -yAbsoluteAmountToMove;
        } else {
            yToMove = yAbsoluteAmountToMove;
        }
        
        CGPoint newPosition = CGPointMake(self.position.x + xToMove, self.position.y + yToMove);
        
        self.position = newPosition;        
    }
}
    
-(void)attackCell
{
    /**
     *  BOOM
     */
    //[self.targetCell recycleThisPhage:self];
}

@end
