import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CompassPage(),
    );
  }
}

class CompassPage extends StatefulWidget {
  @override
  _CompassPageState createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double _azimuth = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _azimuth = _calculateAzimuth(event);
      });
    });
  }

  double _calculateAzimuth(AccelerometerEvent event) {
    double pitch = event.y;
    double roll = event.x;
    double azimuth = -roll;

    if (pitch < 0) {
      azimuth += 180;
    } else if (pitch > 0) {
      azimuth += 360;
    }

    return azimuth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compass App'),
      ),
      body: Center(
        child: Transform.rotate(
          angle: _azimuth * (3.1415927 / 180),
          child: Image.asset('assets/images/compass.png'),
        ),
      ),
    );
  }
}
