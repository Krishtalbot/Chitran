import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController controller; // Declare the MapController variable

  @override
  void initState() {
    super.initState();

    // Initialize the MapController here
    controller = MapController(
      initPosition: GeoPoint(latitude: 27.7045198, longitude: 85.3069725),
      areaLimit: BoundingBox(
        east: 85.3150,
        north: 27.7137,
        south: 27.7020,
        west: 85.3032,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill(
        //   child: Image.asset(
        //     'assets/background.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        OSMFlutter(
          controller: controller, // Use the initialized controller here
          osmOption: OSMOption(
            userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
              initZoom: 8,
              minZoomLevel: 17,
              maxZoomLevel: 19,
              stepZoom: 2.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: RoadOption(
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}