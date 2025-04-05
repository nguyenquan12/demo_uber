import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/components/widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  GoogleMapController? mapController;
  Position? currentPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Độ chính xác cao
        distanceFilter: 10, // Cập nhật vị trí mỗi khi có thay đổi
      ),
    );
    // mapController?.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
    //     zoom: 14.4746,
    //   ),
    // ));
    setState(() {
      currentPosition = position;
      markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: "Current Location"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? Loading()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentPosition?.latitude ?? 0.0,
                    currentPosition?.longitude ?? 0.0),
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: markers,
            ),
    );
  }
}
