import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'loc_search.dart';
import 'package:location/location.dart' as loc;

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;
  late LatLng _currentPosition =
      LatLng(31.2062, 29.9248); // Defaulted to Alexandria, Egypt
  LatLng? _searchedPosition; // Change to nullable LatLng
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  final LocationResult _locationResult = LocationResult();

  // initState() method
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigation & Location Tracking"),
      ),
      body: Column(
        children: [
          // Title bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search logic here
                    _handleSearch();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch() async {
  try {
    final searchResult = await _locationResult.searchLocationAndDrawRoute(
      query: _searchController.text,
      currentLocation: _currentPosition,
      mapController: _mapController,
      polylines: _polylines,
      markers: _markers,
    );
    setState(() {
      _searchedPosition = searchResult;
    });
  } catch (e) {
    // Handle error
    print('Error: $e');
  }
}


  void _getCurrentLocation() async {
    await _requestLocationPermission(); // Request location permissions

    loc.LocationData? locationData;
    var location = loc.Location();
    try {
      locationData = await location.getLocation();
    } catch (e) {
      locationData = null;
    }
    if (locationData?.latitude != null && locationData?.longitude != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData!.latitude!, locationData.longitude!);
        _markers.add(Marker(
          markerId: MarkerId("current_position"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      });
    } else {
      // Handle the case when locationData, latitude, or longitude is null
      print('Error: Location data or its latitude/longitude is null');
    }
  }

  Future<void> _requestLocationPermission() async {
    var location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // Handle the case when location services are not enabled by the user.
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        // Handle the case when location permissions are not granted by the user.
        return;
      }
    }
  }
}