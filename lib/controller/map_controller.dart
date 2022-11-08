import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smarview_app/models/data_models/camera_model.dart';
import 'package:geolocator/geolocator.dart' as geo;

class MapController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final initialcameraposition = const LatLng(20.5937, 78.9629);

  final location = Location();

  Uint8List? markerIcon;

  GoogleMapController? controller;

  ValueNotifier<Set<Marker>> markersList = ValueNotifier({});

  Set<Circle> circles = {};

  var lat = 0.0.obs;
  var long = 0.0.obs;

  getCurrentLocation() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    lat.value = position.latitude;
    long.value = position.longitude;
    print("latitude of current location:::::: ${position.latitude}");
    print("longitude of current location:::::: ${position.longitude}");
    getCameras();
  }

  onMapCreated(GoogleMapController controller) {
    controller = controller;
    // location.onLocationChanged.listen((l) {
    //   controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         target: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0),
    //         zoom: 11,
    //       ),
    //     ),
    //   );
    // });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  addMarker(double lat, double long, String lable) async {
    markerIcon = await getBytesFromAsset('assets/icons/marker.png', 50);
    var t = markersList.value;
    t.add(
      Marker(
        markerId: MarkerId(lable),
        flat: true,
        visible: true,
        icon: BitmapDescriptor.fromBytes(markerIcon!),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: lable),
      ),
    );
    markersList.value = t;
  }

  getCameras() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("camera_list").get();
    for (var element in snapshot.docs) {
      addMarker((element.data() as Map)["lat"], (element.data() as Map)["long"], (element.data() as Map)["name"]);
    }
  }
}
