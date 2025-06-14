import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final localData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: localData.latitude ?? 0.0,
      longitude: localData.longitude ?? 0.0,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: _previewImageUrl == null
              ? Center(child: Text('Informe uma localização!'))
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _getCurrentUserLocation,
                  icon: Icon(Icons.location_on_sharp),
                  label: Text('Localização atual'),
                ),
              ),
              SizedBox(
                height: 16.0,
                child: const VerticalDivider(width: 10.0, thickness: 2.0),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.map_sharp),
                  label: Text('Selecione no mapa'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
