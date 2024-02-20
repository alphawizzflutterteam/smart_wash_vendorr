// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LiveTrackPage extends StatefulWidget {
//   const LiveTrackPage({Key? key}) : super(key: key);
//
//   @override
//   _LiveTrackPageState createState() => _LiveTrackPageState();
// }
//
// class _LiveTrackPageState extends State<LiveTrackPage> {
//
//   Completer<GoogleMapController> _controller = Completer();
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   Map<PolylineId, Polyline> polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   List<LatLng> polylineCoordinates = [];
//   // double _originLatitude = 22.7196, _originLongitude = 75.8577;
//   double _originLatitude = 22.7196, _originLongitude = 75.8577;
//   double _destLatitude = 23.2599, _destLongitude = 77.4126;
//   // String googleAPiKey = "AIzaSyBl2FY2AnfX6NwR4LlOOlT9dDve0VwQLAA";
//   String googleAPiKey = "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM";
//   late BitmapDescriptor myIcon;
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(22.7468712, 75.8979976),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       // bearing: 192.8334901395799,
//       target: LatLng(22.7468712, 75.8979976),
//       // tilt: 59.440717697143555,
//       zoom: 19);
//
//   var dNewLat;
//   var dNewLong;
//
//   getDriverLocation()async{
//
//
//     // dNewLat = 22.7196;
//     // dNewLong =  75.8577;
//     //
//     // stream.listen((DatabaseEvent event) {
//     //   dynamic a = event.snapshot.value;
//     //   dNewLat = a["address"]["lat"];
//     //   dNewLong = a["address"]["long"];
//     //   print('Event Type: ${event.type}'); // DatabaseEventType.value;
//     // });
//   }
//   Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
//     //code to run on every 5 seconds
//   });
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _startTimer();
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(10, 10)), 'assets/images/driver.png')
//         .then((onValue) {
//       myIcon = onValue;
//     });
//     getUserCurrentLocation();
//     // getDriverLocation();
//     _getPolyline();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return
//
//       Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         markers: markers.values.toSet(),
//         // polylines: Set<Polyline>.of(polylines.values),
//         myLocationEnabled: true,
//         // onMapCreated: _onMapCreated,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _driver(dNewLat , dNewLong);
//         },
//         child: Icon(Icons.center_focus_strong),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
//
//
//   Future<void> _driver(dlat , dLong) async {
//
//
//     final GoogleMapController controller = await _controller.future;
//
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//
//
//     final marker = Marker(
//       markerId: MarkerId('Driver'),
//       position: LatLng(22.7468712,75.8979976),
//
//       icon: myIcon,
//       infoWindow: InfoWindow(
//         title: 'Driver Name',
//         snippet: 'address',
//       ),
//     );
//     setState(() {
//       markers[MarkerId('place_name')] = marker;
//     });
//   }
//
//   _addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         geodesic: true,
//         jointType: JointType.round,
//         width: 5,
//         polylineId: id, color: Colors.red, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }
//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(_originLatitude, _originLongitude),
//         PointLatLng(_destLatitude, _destLongitude),
//         travelMode: TravelMode.driving , optimizeWaypoints: true);
//     if (result.points.isNotEmpty) {
//       print(result.points);
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     _addPolyLine();
//   }
//
//   var latitude;
//   var longitude;
//
//
//
//
//   Position? currentLocation;
//
//
//   Future getUserCurrentLocation() async {
//
//
//     var status = await Permission.location.request();
//     if (status.isDenied) {
//     } else if (status.isGranted) {
//       await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high)
//           .then((position) {
//         if (mounted)
//           setState(() {
//             currentLocation = position;
//             latitude = currentLocation?.latitude;
//             longitude = currentLocation?.longitude;
//             print('long==============${longitude}');
//             print('lat==============${latitude}');
//           });
//       });
//       // print("LOCATION===" +currentLocation.toString());
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//
//   }
//
//
//
//
//   CollectionReference collectionRef=FirebaseFirestore.instance.collection("94");
//
//
//   Future<void> getdatadriverData() async {
//     print('rajneesh=====================1');
//
//
//     try {
//
  //       DocumentSnapshot document = await collectionRef.doc('qPoeXMGDCkuWuiDkBnf0').get();
//
//       if (document.exists) {
//
//         print('data prasent');
//
//           dNewLat = document.get('lat'); // Replace with your field name
//          dNewLong = document.get('long'); // Replace with your field name
//         print('lat1===========: $dNewLat');
//         print('long1===========: $dNewLong');
//
//       }
//
//     } catch (e) {
//
//       print('rajneesh=====================555');
//
//       // print('Error adding data: $e');
//     }
//
//   }
//   @override
//   void dispose() {
//
//     _timer.cancel();
//
//     super.dispose();
//
//   }
//
//   late Timer _timer;
//
//
//
//   void _startTimer() {
//
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
//       getdatadriverData();
//     });
//   }
//
//
// }




import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class UserMapScreen extends StatefulWidget {


  String? vendorlat;
  String? vendorlang;
  String? Driverid;
  UserMapScreen({
this.Driverid,
    this.vendorlat,
    this.vendorlang,
  });
  @override
  _UserMapScreenState createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  LatLng driverLocation = LatLng(22.7177, 75.8545);
  LatLng userLocation = LatLng(22.7281,  75.8042);

   BitmapDescriptor? myIcon ;

  List<LatLng> routeCoordinates = [];

  List<Polyline> polyLines = [];

  late double bearing ;
   double dNewLat = 0.0 ;
   double dNewLong = 0.0 ;

   CollectionReference collectionRef=FirebaseFirestore.instance.collection("driverlocation");

  Future<void> getdatadriverData() async {

    try {



          DocumentSnapshot document = await collectionRef.doc('${widget.Driverid}').get();

      if (document.exists) {

        // print('data prasent');

          dNewLat = document.get('lat'); // Replace with your field name
         dNewLong = document.get('long'); // Replace with your field name
        driverLocation = LatLng(dNewLat, dNewLong);
        bearing = getBearing( LatLng(dNewLat, dNewLong), LatLng(double.parse(widget.vendorlat ?? '0.0'),double.parse(widget.vendorlang ?? '0.0')));
          init();
        print('${dNewLat}_____get firebase lat__');
        print('${dNewLong}____get firebase lang---');





        setState(() {

        });

      }

    } catch (e) {



      // print('Error adding data: $e');
    }

  }
  late Timer _timer;

  void _startTimer() {



    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      getdatadriverData();
    });
  }


  @override
  void initState() {
    super.initState();
    print('=============${widget.vendorlat}');
    print('=============${widget.vendorlang}');

    userLocation = LatLng(double.parse(widget.vendorlat ?? '0.0'),double.parse(widget.vendorlang ?? '0.0'));
    _startTimer();



    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)), 'assets/images/driver.png')
        .then((onValue) {
      myIcon = onValue;
    });

    // Listen for driver location updates in real-time
    /*collectionRef.id.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Object? locationData = event.snapshot.value;
        print('${locationData})______________');
        setState(() {
          driverLocation = const LatLng(22.7177, 75.8545);
        });
      }
    });*/


        // Fetch and display directions from user to driver
        //fetchDirections();
  }

    // Get user's location (you can use geolocator for this)
    // Update userLocation and Firebase with user's location


  init() async{
  var encodedPoly = await getRouteCoordinates(
       LatLng(dNewLat,  dNewLong),
       LatLng(double.parse(widget.vendorlat ?? '0.0'),double.parse(widget.vendorlang ?? '0.0')));

  polyLines.add(Polyline(
      polylineId: const PolylineId("1"), //pass any string here
      width: 7,
      geodesic: true,
      points: convertToLatLng(decodePoly(encodedPoly)),
      color: Colors.blueAccent));

  setState(() {

  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     init();
      //   },
      //     child: const Icon(Icons.directions)),
      body:
      dNewLong==0.0?
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Center(child: CircularProgressIndicator())):

      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: userLocation,
          zoom: 15.0,
        ),
        markers: <Marker>{
          Marker(
              markerId: const MarkerId('userMarker'),
              position: driverLocation,
              icon: myIcon ?? BitmapDescriptor.defaultMarker,
              anchor: const Offset(0.5, 0.5),
              flat: true,
              rotation: bearing,
              draggable: false),
          Marker(
            markerId: const MarkerId('driverMarker'),
            position: userLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed),
          ),
        },
        polylines: Set<Polyline>.of(
            polyLines) /*{
          Polyline(
            polylineId: const PolylineId('user-driver-polyline'),
            color: Colors.blue,
            points: routeCoordinates,
          ),
        }*/
        ,
      )
    );
  }


  /*Future<void> fetchDirections() async {
    final directions = GoogleMapsDirections(
      apiKey: 'YOUR_API_KEY', // Replace with your Google API Key
    );

    final directionsResponse = await directions.directionsWithLocation(
      Location(latitude: userLocation.latitude,longitude:  userLocation.longitude, timestamp: DateTime.now()),
      Location(latitude:driverLocation.latitude, longitude:driverLocation.longitude,  timestamp: DateTime.now()),
    );

    if (directionsResponse.isOkay) {
      setState(() {
        routeCoordinates = directionsResponse.routes.first.overviewPolyline.decodePolyline();
      });
    }
  }*/

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyDi_XlHtopewZHtpWWxIO-EQ7mCegHr5o0";
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM";
    http.Response response = await http.get(Uri.parse(url));
    print(url);
    Map values = jsonDecode(response.body);
    print("Predictions " + values.toString());
    return values["routes"][0]["overview_polyline"]["points"];
  }


  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
    // if value is negative then bitwise not the value /
    if (result & 1 == 1) {
      result = ~result;
    }
    var result1 = (result >> 1) * 0.00001;
    lList.add(result1);
  } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }


  double getBearing(LatLng begin, LatLng end) {

    double lat = (begin.latitude - end.latitude).abs();

    double lng = (begin.longitude - end.longitude).abs();



    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {

      return (atan(lng / lat) * (180 / pi));

    } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 90;

    } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {

      return (atan(lng / lat) * (180 / pi)) + 180;

    } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 270;

    }

    return -1;

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
}
