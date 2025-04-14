import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/jcbDrawerComponent.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/main/searchDestinationScreen.dart';
import 'package:uber_app/utils/constants.dart';

final GlobalKey<ScaffoldState> jcbHomeKey = GlobalKey();

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
    //   CameraPosition(j
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
      key: jcbHomeKey,
      drawer: JCBDrawerComponent(),
      body: currentPosition == null
          ? Loading()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
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
                Container(
                  decoration: BoxDecoration(
                    color: context.scaffoldBackgroundColor,
                    borderRadius: radiusOnly(
                      topLeft: jcbBottomSheetRadius,
                      topRight: jcbBottomSheetRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Where are you going?',
                        style: boldTextStyle(
                            size: 20,
                            color: jcbDarkColor,
                            weight: FontWeight.w600),
                      ),
                      16.height,
                      Text(
                        'Book on demand or pre-schedule rides',
                        style: secondaryTextStyle(color: context.iconColor),
                      ),
                      16.height,
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            borderRadius: radius(jcbBottomSheetRadius),
                            border: Border.all(color: jcbSecBorderColor)),
                        child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          autoFocus: false,
                          textStyle: boldTextStyle(),
                          onChanged: (val) {
                            hideKeyboard(context);
                            SearchDestinationScreen().launch(context);
                          },
                          onTap: () {
                            hideKeyboard(context);
                            SearchDestinationScreen().launch(context);
                          },
                          decoration: InputDecoration(
                            suffixIcon: Image.asset(
                              ic_search,
                              height: 14,
                              width: 14,
                              fit: BoxFit.cover,
                              color: jcbPrimaryColor,
                            ).paddingAll(12),
                            border: InputBorder.none,
                            hintText: 'Enter Destination',
                            hintStyle: boldTextStyle(color: jcbGreyColor),
                          ),
                        ),
                      ),
                      16.height,
                    ],
                  ),
                ),
                16.height,
                // My location
                Positioned(
                  right: 16,
                  bottom: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: radius(8),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          ic_navigation,
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                // Drawer
                Positioned(
                  left: 16,
                  top: 32,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: radius(100),
                        border: Border.all(
                            color: context.scaffoldBackgroundColor, width: 2)),
                    child: Image.asset(
                      img_avatar,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(100).onTap(() {
                      jcbHomeKey.currentState!.openDrawer();
                    }, borderRadius: radius(100)),
                  ),
                )
              ],
            ),
    );
  }
}
