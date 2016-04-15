//
//  AnimationViewController.m
//  TestWork
//
//  Created by Nikolay Berlioz on 15.04.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "AnimationViewController.h"
#import "FigureView.h"

@interface AnimationViewController ()

@property (assign, nonatomic) __block NSInteger positionY;
@property (assign, nonatomic) __block CGFloat speedDelta;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.positionY = 1;
    self.speedDelta = 1.f;
    self.animationSpeed = 0.2f;
    
    [self createFigureWithCountPosition:0];
}

#pragma mark - Private Methods

- (void) createFigureWithCountPosition:(NSInteger)count
{
    __block NSInteger countPosition = count;
    
    //задаем фрейм фигуре
    FigureView *figure = [[FigureView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 6 * countPosition, 0,
                                                                   CGRectGetWidth(self.view.bounds) / 6,
                                                                   CGRectGetWidth(self.view.bounds) / 6)];
    figure.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:figure];
    
    //рассчитываем время и планируем уведомление
    NSInteger countInterration = CGRectGetMaxY(self.view.bounds) / (CGRectGetWidth(self.view.bounds) / 6);
    
    CGFloat timeInterval = self.animationSpeed * 6 * countInterration;
    
    NSDate *alarmDate = [[NSDate date] dateByAddingTimeInterval:timeInterval];
    
    [self scheduleAlarmForDate:alarmDate];
    
    [UIView animateWithDuration:self.animationSpeed
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //конечный фрейм фигуры
                         figure.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 6 * countPosition,
                                                CGRectGetMaxY(self.view.bounds) - ((CGRectGetWidth(self.view.bounds) / 6) * self.positionY),
                                                CGRectGetWidth(self.view.bounds) / 6,
                                                CGRectGetWidth(self.view.bounds) / 6);
                         
                     } completion:^(BOOL finished) {
                         
                         countPosition++;
                         
                         if (countPosition == 6)
                         {
                             countPosition = 0;
                             self.positionY++;
                             //self.speedDelta -= 0.07;
                         }
                         
                         if (figure.frame.origin.y < CGPointZero.y + 40)
                         {
                             //после заполнения экрана показываем алерт
                             [self showAlert];
                         }
                         else
                         {
                             [self createFigureWithCountPosition:countPosition];
                         }
                     }];
}

- (void) showAlert
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:@"Screen is full!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)scheduleAlarmForDate:(NSDate*)theDate
{
    UIApplication* app = [UIApplication sharedApplication];
    
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    
    //если нужно, удаляем старые нотификации
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
    
    
    NSDate *eventDate = theDate;
    NSString *eventInfo = @"Done";
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys: eventInfo, @"eventInfo",
                                                                      eventDate, @"eventDate", nil];
    
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    alarm.userInfo = dic;
    alarm.timeZone = [NSTimeZone defaultTimeZone];
    alarm.fireDate = eventDate;
    alarm.alertBody = eventInfo;
    alarm.applicationIconBadgeNumber = 1;
    alarm.soundName = UILocalNotificationDefaultSoundName;
    
    [app scheduleLocalNotification:alarm];
}

@end




















