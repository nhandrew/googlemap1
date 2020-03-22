import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../models/place.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(places[index].name),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
