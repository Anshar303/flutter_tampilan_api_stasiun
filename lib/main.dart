import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stations List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StationsPage(),
    );
  }
}

class StationsPage extends StatefulWidget {
  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  List<dynamic> stations = [];

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  Future<void> fetchStations() async {
    try {
      final response = await http.get(Uri.parse('https://booking.kai.id/api/stations2'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          setState(() {
            stations = data;
          });
        } else {
          print('Data is null');
        }
      } else {
        print('Failed to fetch stations');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stations List'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return ListTile(
            title: Text(station['station_name'] ?? ''),
            subtitle: Text(station['city_name'] ?? ''),
          );
        },
      ),
    );
  }
}
