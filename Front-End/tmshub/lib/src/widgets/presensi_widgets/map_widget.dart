// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:tmshub/src/utils/globals.dart' as globals;

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.latitudeOffice, required this.longtitudeOffice}) : super(key: key);
  final String latitudeOffice;
  final String longtitudeOffice;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Location location = Location();
  final double radius = 30;

  Future<bool> _checkLocationPermission() async {
    final status = await ph.Permission.location.request();
    return status.isGranted;
  }

  Future<LatLng> _getCurrentLocation() async {
    final locationData = await location.getLocation();
    globals.locationNow = "${locationData.latitude}, ${locationData.longitude}";
    globals.latitudeNow = locationData.latitude??0.0;
    globals.longtitudeNow = locationData.longitude??0.0;
    return LatLng(
      locationData.latitude ?? 0.0,
      locationData.longitude ?? 0.0,
    );
  }

  Widget _buildMapWithLocation(LatLng currentLocation) {
    return Container(
      width: 319,
      height: 215,
      child: FlutterMap(
        options: MapOptions(
          center: currentLocation,
          zoom: 17,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: LatLng(double.parse(widget.latitudeOffice), double.parse(widget.longtitudeOffice)),
                color: Colors.blue.withOpacity(0.5),
                useRadiusInMeter: true,
                radius: radius,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: currentLocation, // Menggunakan lokasi saat ini
                builder: (BuildContext context) {
                  return Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      
                      size: 40.0,
                    ),
                  );
                },
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLocationPermission(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return FutureBuilder<LatLng>(
            future: _getCurrentLocation(),
            builder: (context, locationSnapshot) {
              if (locationSnapshot.hasData) {
                return _buildMapWithLocation(locationSnapshot.data!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else if (snapshot.hasData && snapshot.data == false) {
          return Center(
            child: Text('Butuh izin lokasi untuk melihat peta'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}