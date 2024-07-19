import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Page"),
//       ),
//       body: const Center(
//         child: Text(
//           "This is order screen",
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

class SensorExample extends StatefulWidget {
  const SensorExample({super.key});

  @override
  _SensorExampleState createState() => _SensorExampleState();
}

class _SensorExampleState extends State<SensorExample> {
  String orientation = 'Unknown';

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent  event) {
      double xAxisValue = event.x;
      if (xAxisValue  > 8.0) {
        setState(() {
          orientation = 'Upside Down';
        });
      } else {
        setState(() {
          orientation = 'Normal';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Orientation'),
      ),
      body: Center(
        child: Text('Phone Orientation: $orientation'),
      ),
    );
  }
}
