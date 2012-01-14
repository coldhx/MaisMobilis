//
//  BusObserver.m
//  MaisMobilis
//
//  Created by tom on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusObserver.h"

@implementation BusObserver

static BusObserver *_instance = nil;

- (id) init
{
    self = [super init];
    
    _observerInstances = [[NSMutableDictionary alloc] init];
    return self;
}

+ (BusObserver *) getInstance
{
    if(_instance == nil)
    {
        _instance = [[BusObserver alloc] init];
    }
    
    return _instance;
}

- (void) addObserverWithAlert:(Alert *)alert forLine:(NSString *)lineID andBusstop:(NSString *)busstopID withTolerance:(NSNumber *)tolerance
{
    NSMutableArray *busStops = [[NSMutableArray alloc] init];

    //Transform 0 into nil for lineID
    if([lineID isEqualToString:@"0"])
    {
        lineID = nil;
    }
    
    if(lineID != nil)
    {
        BusStop_Line *busstopLine = [DataController getBusstopLineForLineID:lineID andBusstopID:busstopID];
        int toleranceNumeral = [busstopLine.numeral intValue] - [tolerance intValue];
        
        if(toleranceNumeral < 1)
        {
            toleranceNumeral = 1;
        }
        
        BusStop_Line *toleranceBusstopLine = [DataController getBusstopLineForLineID:lineID andNumeral:[NSString stringWithFormat:@"%d", toleranceNumeral]];
        
        BusStop *busStop = [DataController getBusStopByBusStopID:toleranceBusstopLine.busStopID];
        [busStops addObject:busStop];
    }
    else
    {
        NSMutableArray *lines = [DataController getAllLines];
        
        for(int i=0; i<lines.count; i++)
        {
            Line *line = [lines objectAtIndex:i];
            
            BusStop_Line *busstopLine = [DataController getBusstopLineForLineID:line.lineID andBusstopID:busstopID];
            int toleranceNumeral = [busstopLine.numeral intValue] - [tolerance intValue];
            
            if(toleranceNumeral < 1)
            {
                toleranceNumeral = 1;
            }
            
            BusStop_Line *toleranceBusstopLine = [DataController getBusstopLineForLineID:line.lineID andNumeral:[NSString stringWithFormat:@"%d", toleranceNumeral]];
            
            BusStop *busStop = [DataController getBusStopByBusStopID:toleranceBusstopLine.busStopID];
            [busStops addObject:busStop];
        }
    }
    
    //Start workaround with first observer
    if(_observerInstances.count == 0)
    {
        [self startAudioWorkaround];
    }
    
    [_observerInstances setObject:alert forKey:alert.alertID];    
    NSDictionary *objects = [[NSDictionary alloc] initWithObjectsAndKeys:alert, @"alert", busStops, @"busStops", nil];
    
    [self performSelectorInBackground:@selector(beginObserving:) withObject:objects];
}

- (void) removeObserverWithID:(NSString *)alertID
{
    [_observerInstances removeObjectForKey:alertID];
    
    //Stop workaround with last observer
    if(_observerInstances.count == 0)
    {
        [self stopAudioWorkaround];
    }
}

- (void) beginObserving:(NSDictionary *)objects
{
    Alert *alert = [objects objectForKey:@"alert"];
    NSMutableArray *busStops = [objects objectForKey:@"busStops"];
    
    NSTimeInterval start = [alert.startTime timeIntervalSince1970];
    NSTimeInterval stop = [alert.stopTime timeIntervalSince1970];
    NSTimeInterval now;
    
    NSString *alertBody = @"";
    NSString *targetBusStops = @"";
    int numberOfBuses = 0;
    
    NSLog(@"Notification engaged!");
    while([_observerInstances objectForKey:alert.alertID] != nil)
    {
        now = [[[NSDate alloc] init] timeIntervalSince1970];
        
        if(now >= start && now <= stop)
        {
            NSLog(@"Checking notification...");
            [DataController loadAllBusesIntoCoreData];
            NSArray *buses = [DataController getAllBuses];
            numberOfBuses = 0;
            targetBusStops = @"";
            
            for(int i=0; i<buses.count; i++)
            {
                Bus *bus = [buses objectAtIndex:i];
                for(int j=0; j<busStops.count; j++)
                {
                    BusStop *busStop = [busStops objectAtIndex:j];
                    if([[bus lastStopID] isEqualToString:busStop.busStopID])
                    {
                        numberOfBuses++;
                        targetBusStops = [targetBusStops stringByAppendingFormat:@"%@, ", busStop.name];
                    }
                }
            }
            
            if(numberOfBuses != 0)
            {
                NSLog(@"Generating alert!");
                alertBody = [NSString stringWithFormat:@"Existem %d autocarro(s) a chegar à(s) paragem(s): %@", numberOfBuses, targetBusStops];
                
                //TODO: Gerar alerta
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.alertBody = alertBody;
                notification.alertAction = NSLocalizedString(@"Abrir aplicação", nil);
                notification.soundName = UILocalNotificationDefaultSoundName;
                //notification.applicationIconBadgeNumber = 0;
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            }
        }
        //Sleep
        [NSThread sleepForTimeInterval:30];
    }
}

- (void) startAudioWorkaround
{
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: &setCategoryErr];
    
    [[AVAudioSession sharedInstance]
     setActive: YES
     error: &activationErr];
    
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"silence" ofType:@"mp3"]];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.numberOfLoops = -1;
    [_player play];
}

- (void) stopAudioWorkaround
{
    if(_player != nil)
    {
        [_player stop];
    }
}

@end
