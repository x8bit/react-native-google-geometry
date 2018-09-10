
#import "RNGoogleGeometry.h"
#import <GoogleMaps/GMSGeometryUtils.h>
#import <GoogleMaps/GMSMutablePath.h>
#import <GoogleMaps/GMSPolyline.h>
#import <GoogleMaps/GMSPath.h>

@interface RNGoogleGeometry () <RCTBridgeModule>

@property (copy) RCTPromiseResolveBlock resolve;
@property (copy) RCTPromiseRejectBlock reject;

@end

@implementation RNGoogleGeometry

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(
  containsLocation:(NSDictionary *)point
  polygon:(NSArray *)polygon
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject)
{
    self.resolve = resolve;
    self.reject = reject;
    
    CLLocationCoordinate2D locationPoint = CLLocationCoordinate2DMake(
        [[point objectForKey:@"lat"] doubleValue],
        [[point objectForKey:@"lng"] doubleValue]
    );

    GMSMutablePath *polygonPath  = [GMSMutablePath path];

    for(int i = 0; i < [polygon count]; i++) {
        [polygonPath addCoordinate:CLLocationCoordinate2DMake(
            [[polygon[i] objectForKey:@"lat"] doubleValue],
            [[polygon[i] objectForKey:@"lng"] doubleValue]
        )];
    }
    
    BOOL onPath = GMSGeometryContainsLocation(locationPoint, (GMSPath *)polygonPath, NO);
    self.resolve(@(onPath));
}

RCT_EXPORT_METHOD(
  isLocationOnPath:(NSDictionary *)point
  polyline:(NSArray *)polyline
  geodesic:(BOOL *)geodesic
  tolerance:(double) tolerance
  resolver:(RCTPromiseResolveBlock)resolve 
  rejecter:(RCTPromiseRejectBlock)reject)
{
    self.resolve = resolve;
    self.reject = reject;

    CLLocationCoordinate2D locationPoint = CLLocationCoordinate2DMake(
      [[point objectForKey:@"latitude"] doubleValue],
      [[point objectForKey:@"longitude"] doubleValue]
    );
    
    GMSMutablePath *pLine  = [GMSMutablePath path];
    
    for(int i = 0; i < [polyline count]; i++) {
        [pLine addCoordinate:CLLocationCoordinate2DMake(
          [[polyline[i] objectForKey:@"latitude"] doubleValue],
          [[polyline[i] objectForKey:@"longitude"] doubleValue]
        )];
    }
    
    BOOL onPath = GMSGeometryIsLocationOnPathTolerance(locationPoint, (GMSPath *)pLine, geodesic, tolerance);
    self.resolve(@(onPath));
}

RCT_EXPORT_METHOD(decode:(NSString *)encodedPath resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  self.resolve = resolve;
  self.reject = reject;
  
  GMSPath *path = [GMSPath pathFromEncodedPath:encodedPath];
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  for (int i = 0; i< path.count; i++) {
    CLLocationCoordinate2D coord = [path coordinateAtIndex:i];
    NSDictionary *point = [NSDictionary dictionaryWithObjectsAndKeys: 
    @(coord.latitude), @"latitude", @(coord.longitude), @"longitude", nil];
    [arr addObject:point];
  }
  self.resolve(arr);
}
@end
  
