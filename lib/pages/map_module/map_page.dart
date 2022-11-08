import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smarview_app/constants/assets.dart';
import 'package:smarview_app/controller/map_controller.dart';
import 'package:smarview_app/widgets/custom_drawer.dart';

import '../../constants/themes/colors.dart';
import '../../widgets/common.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapCon = Get.put(MapController());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    mapCon.getCurrentLocation();
    setState(() {});
  }

  @override
  void dispose() {
    mapCon.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: mapCon.scaffoldKey,
      drawer: const MyDrawer(isFromDashboard: false),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: primarycolor,
        title: appbatTitleText(),
        leading: sidemenuButton(onPressed: () {
          mapCon.scaffoldKey.currentState?.openDrawer();
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Get.offNamed('/home-page');
              },
              icon: Image.asset(
                homeIcon,
                width: 25,
                color: whitecolor,
              ),
            ),
          ),
        ],
      ),
      body: GoogleMap(
        buildingsEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        compassEnabled: true,
        trafficEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        onMapCreated: mapCon.onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(mapCon.lat.value, mapCon.long.value),
          zoom: 11,
        ),
        circles: {
          Circle(
            circleId: const CircleId("1"),
            center: LatLng(mapCon.lat.value, mapCon.long.value),
            radius: 12000,
            strokeWidth: 0,
            fillColor: const Color.fromARGB(26, 0, 0, 255),
            zIndex: 0,
          ),
        },
        markers: mapCon.markersList.value,
      ),
    );
  }
}
