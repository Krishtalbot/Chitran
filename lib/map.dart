import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController controller;
  // final MapBoxNavigation mapBoxNavigation =
  //     MapBoxNavigation(); // Declare the MapController variable

  @override
  void initState() {
    super.initState();

    // Initialize the MapController here
    controller = MapController.customLayer(
      initPosition: GeoPoint(latitude: 27.7045198, longitude: 85.3069725),
      areaLimit: BoundingBox(
        east: 85.3150,
        north: 27.7137,
        south: 27.7020,
        west: 85.3032,
      ),
      customTile: CustomTile(
        sourceName: "cyclemap",
        tileExtension: ".png",
        minZoomLevel: 2,
        maxZoomLevel: 20,
        urlsServers: [
          TileURLs(
            url: "https://tile.thunderforest.com/cycle/",
            subdomains: [],
          )
        ],
        tileSize: 256,
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

        SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: OSMFlutter(
              controller: controller, // Use the initialized controller here
              osmOption: OSMOption(
                userTrackingOption: UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: false,
                ),
                zoomOption: ZoomOption(
                  initZoom: 7,
                  minZoomLevel: 18,
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
          ),
        ),
      ],
    );
  }
}
