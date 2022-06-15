import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key? key, this.lat, this.lng}) : super(key: key);
  Function? lat;
  Function? lng;
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController? mapsController;
  MarkerId markerId = MarkerId("1");
  
  bool showMap = true;
  LatLng? latlng;
  @override
  void initState() {
      Marker(
        markerId: markerId,
        position: LatLng(11.5999389, 104.8853553),
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: showMap
          ? ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latlng == null ? LatLng(11.5999389, 104.8853553):latlng!,
                  zoom: 14,
                ),
                myLocationButtonEnabled: true,
                
                myLocationEnabled: true,
                markers: Set<Marker>.of(<Marker>[
                  Marker(
                    markerId: MarkerId("1"),
                    draggable: true,
                    position: latlng == null ? LatLng(11.5999389, 104.8853553):latlng!,
                    onDragEnd: ((newPosition) {
                      latlng = newPosition;
                      setState(() {
                        widget.lat!(latlng!.latitude);
                        widget.lng!(latlng!.longitude);
                      });
                      // print(latlng!.latitude);
                      // print(latlng!.longitude);
                     }
                    ),)
                ]),
                mapType: MapType.terrain,
                scrollGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  mapsController = controller;
                  setState(() {});
                },
                onCameraMove: (position) async {
                  setState(() {
                    latlng = position.target;
                  });
                  // print(latlng);
                },
              ),
            )
          : CircularProgressIndicator(
              color: kPrimaryColor,
            ),
    );
  }
}
