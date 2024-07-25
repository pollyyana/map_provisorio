import 'package:app_teste/app/model/person_card.dart';
import 'package:app_teste/app/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:app_teste/app/model/edit_card.dart'; 
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _editPerson(int index) async {
    final updatedPerson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCardScreen(index: index),
      ),
    );

    if (updatedPerson != null) {
      context.read<PersonProvider>().updatePerson(index, updatedPerson);
    }
  }

  @override
  Widget build(BuildContext context) {
    final personProvider = context.watch<PersonProvider>();
    
    return Scaffold(
      
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(-15.9160, -48.0180),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(-15.9120, -48.0250),
                    builder: (ctx) => ClipOval(
                      child: Image.asset(
                        'assets/person1.jpg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(-15.9200, -48.0100),
                    builder: (ctx) => ClipOval(
                      child: Image.asset(
                        'assets/person2.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: personProvider.people.length,
                itemBuilder: (context, index) {
                  final person = personProvider.people[index];
                  return GestureDetector(
                    onTap: () => _editPerson(index),
                    child: PersonCard(person: person),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

