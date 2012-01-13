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
    [self performSelectorInBackground:@selector(startAudioWorkaround) withObject:nil];
    
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

- (void) addObserverWithID:(NSString *)id forLine:(NSString *)lineID andBusstop:(NSString *)busstopID withTolerance:(NSNumber *)tolerance
{
    
}

- (void) removeObserverWithID:(NSString *)id
{
    
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

@end
