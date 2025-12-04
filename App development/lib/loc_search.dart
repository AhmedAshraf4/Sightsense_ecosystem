import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/directions.dart' as google_directions;
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // Import FlutterPolylinePoints

class LocationResult {
  static const String apiKey = ''; // Replace with your API key

Future<LatLng> searchLocationAndDrawRoute({
  required String query,
  required LatLng currentLocation,
  required GoogleMapController mapController,
  required Set<Polyline> polylines,
  required Set<Marker> markers,
}) async {
  final places = GoogleMapsPlaces(apiKey: apiKey);
  PlacesSearchResponse response = await places.searchByText(query);
  if (response.isOkay && response.results.isNotEmpty) {
    final place = response.results.first;
    final destination = LatLng(
      place.geometry!.location.lat,
      place.geometry!.location.lng,
    );

    final directions = google_directions.GoogleMapsDirections(apiKey: apiKey);
    final directionsResponse = await directions.directions(
      google_directions.Location(
        lat: currentLocation.latitude,
        lng: currentLocation.longitude,
      ),
      google_directions.Location(
        lat: destination.latitude,
        lng: destination.longitude,
      ),
      travelMode: google_directions.TravelMode.walking,
    );

    if (directionsResponse.isOkay) {
      final routes = directionsResponse.routes;
      if (routes.isNotEmpty) {
        final route = routes.first;
        final polylinePoints = PolylinePoints();
        List<PointLatLng> decodedPoints =
            polylinePoints.decodePolyline(route.overviewPolyline.points);
        List<LatLng> polylineCoordinates = decodedPoints
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(currentLocation.latitude, destination.latitude),
                min(currentLocation.longitude, destination.longitude),
              ),
              northeast: LatLng(
                max(currentLocation.latitude, destination.latitude),
                max(currentLocation.longitude, destination.longitude),
              ),
            ),
            50,
          ),
        );

        // Clear existing polylines and markers
        polylines.clear();
        markers.clear();

        // Add new polyline to the set
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            width: 5,
            color: Colors.blue,
          ),
        );

        // Add marker for the searched location
        markers.add(
          Marker(
            markerId: MarkerId('destination'),
            position: destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );

        // Return destination
        return destination;
      }
    }
  }
  throw Exception('Failed to retrieve location information');
}
}
