#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@import CoreLocation;

@interface BITripEntry : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;

-(NSDate *) getTimestamp;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToEntry:(BITripEntry *)entry;

- (NSUInteger)hash;

@end