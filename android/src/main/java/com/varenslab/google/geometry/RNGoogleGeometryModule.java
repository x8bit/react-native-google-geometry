
package com.varenslab.google.geometry;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;

import com.google.maps.android.PolyUtil;
import com.google.android.gms.maps.model.LatLng;
import java.util.List;
import java.util.ArrayList;

public class RNGoogleGeometryModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNGoogleGeometryModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNGoogleGeometry";
  }

  // @ReactMethod
  // public void containsLocation(
  //     ReadableMap point,
  //     ReadableArray polygon,
  //     Callback completionCallback) {

  //   LatLng locationPoint = new LatLng(
  //       point.getDouble("lat"),
  //       point.getDouble("lng")
  //   );

  //   List<LatLng> polygonList = new ArrayList<>();

  //   for (int i = 0; i < polygon.size(); i++) {
  //     ReadableMap vertex = polygon.getMap(i);
  //     polygonList.add(
  //         new LatLng(
  //           vertex.getDouble("lat"),
  //           vertex.getDouble("lng")
  //         )
  //     );
  //   }

  //   boolean isWithinCoverage = PolyUtil.containsLocation(locationPoint, polygonList, false);

  //   completionCallback.invoke(isWithinCoverage);
  // }

    // //isLocationOnPath(LatLng point, java.util.List<LatLng> polyline, boolean geodesic)

    @ReactMethod
    public void isLocationOnPath(
        ReadableMap point,
        ReadableArray polyline,
        Boolean geodesic,
        Double tolerance,
        Promise promise) {

        LatLng locationPoint = new LatLng(
            point.getDouble("latitude"),
            point.getDouble("longitude")
        );

        List<LatLng> pL = new ArrayList<>();

        for (int i = 0; i < polyline.size(); i++) {
          ReadableMap p = polyline.getMap(i);
          pL.add(
              new LatLng(
                p.getDouble("latitude"),
                p.getDouble("longitude")
              )
          );
        }

        Boolean onPath = PolyUtil.isLocationOnPath(locationPoint, pL, geodesic, tolerance);
        promise.resolve(onPath);
    }

    @ReactMethod
    public void decode(String encodedPath, Promise promise) {
      List<LatLng> polyPoints = PolyUtil.decode(encodedPath);

      WritableArray points = Arguments.createArray();
      for(LatLng latlng: polyPoints){
        WritableMap map = Arguments.createMap();
        map.putDouble("latitude", latlng.latitude);
        map.putDouble("longitude", latlng.longitude);
        points.pushMap(map);
      }

      promise.resolve(points);
    }
}