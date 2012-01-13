//
//  BusObserver.h
//  MaisMobilis
//
//  Created by tom on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BusObserver : NSObject
{
    NSMutableDictionary * _observerInstances;
    AVAudioPlayer * _player;
}

+ (BusObserver *) getInstance;
- (void) addObserverWithID:(NSString *)id forLine:(NSString *)lineID andBusstop:(NSString *)busstopID withTolerance:(NSNumber *)tolerance;
- (void) removeObserverWithID:(NSString *)id;
- (void) startAudioWorkaround;

@end
