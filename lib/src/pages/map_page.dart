import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapPage extends StatefulWidget {

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan =  ModalRoute.of(context)!.settings.arguments as ScanModel;
    
    final CameraPosition startingPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 10
    );

    //Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas'),
        actions: [
          IconButton(
            onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 10
                  )
                )
              );
            }, 
            icon: Icon(Icons.location_on_outlined)
          )
        ]
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: startingPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          mapType == MapType.normal 
          ? (mapType = MapType.satellite) 
          : (mapType = MapType.normal);

          setState(() {});
        },
      ),
   );
  }
}