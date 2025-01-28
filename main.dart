
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title:  'Parcel Services',
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/place-order': (context) => PlaceOrderScreen(), 
      '/track-order': (context) => TrackingDetailsScreen(trackingNumber: ''), 
    },
  ));  
}


class ParcelApp extends StatelessWidget {
  const ParcelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ParcelHomePage(),
    );
  }
}

class ParcelHomePage extends StatelessWidget {
  final TextEditingController _trackingController = TextEditingController();

  ParcelHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parcel Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: 'Enter Tracking Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final trackingNumber = _trackingController.text;
                if (trackingNumber.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingDetailsScreen(
                        trackingNumber: trackingNumber,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a tracking number.')),
                  );
                }
              },
              child: Text('Track Parcel'),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingDetailsScreen extends StatelessWidget {
  final String trackingNumber;

  const TrackingDetailsScreen({super.key, required this.trackingNumber});

  @override
  Widget build(BuildContext context) {
    final mockData = {
      '123456': {
        'status': 'In Transit',
        'origin': 'Mumbai, India',
        'destination': 'Gujarat, India',
        'lastUpdated': '2025-01-01 10:00 AM',
      },
      '789012': {
        'status': 'Delivered',
        'origin': 'Goa, India',
        'destination': 'Houston, TX',
        'lastUpdated': '2025-01-02 2:00 PM',
      },
      '345678': {
        'status': 'Out for Delivery',
        'origin': 'South Korea',
        'destination': 'Tokyo, Japan',
        'lastUpdated': '2025-01-03 9:00 AM',
      },
    };

    final data = mockData[trackingNumber] ?? {
      'status': 'Unknown',
      'origin': 'Unknown',
      'destination': 'Unknown',
      'lastUpdated': 'N/A',
    };

    return Scaffold(
      appBar: AppBar(title: Text('Tracking Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tracking Number: $trackingNumber',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Status: ${data['status']}'),
            Text('Origin: ${data['origin']}'),
            Text('Destination: ${data['destination']}'),
            Text('Last Updated: ${data['lastUpdated']}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviousOrdersScreen(),
                  ),
                );
              },
              child: Text('Track Previous Orders'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousOrdersScreen extends StatelessWidget {
  const PreviousOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock previous orders data
    final previousOrders = [
      {'trackingNumber': '123456', 'status': 'Delivered'},
      {'trackingNumber': '789012', 'status': 'In Transit'},
      {'trackingNumber': '345678', 'status': 'Out for Delivery'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Previous Orders')),
      body: ListView.builder(
        itemCount: previousOrders.length,
        itemBuilder: (context, index) {
          final order = previousOrders[index];
          return ListTile(
            title: Text('Tracking Number: ${order['trackingNumber']}'),
            subtitle: Text('Status: ${order['status']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackingDetailsScreen(
                    trackingNumber: order['trackingNumber']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PlaceOrderScreen extends StatelessWidget {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _parcelDetailsController = TextEditingController();

  PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Place an Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _parcelDetailsController,
              decoration: InputDecoration(
                labelText: 'Parcel Details',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final recipient = _recipientController.text;
                final address = _addressController.text;
                final parcelDetails = _parcelDetailsController.text;

                if (recipient.isNotEmpty && address.isNotEmpty && parcelDetails.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order placed successfully!')),
                  );
                  // Clear the fields after placing the order
                  _recipientController.clear();
                  _addressController.clear();
                  _parcelDetailsController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all fields.')),
                  );
                }
              },
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parcel Services')),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlaceOrderScreen()),
                    );
                  },
                  child: Text('Place an Order'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackingDetailsScreen(trackingNumber: '123456'),
                      ),
                    );
                  },
                  child: Text('Track an Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [const Color.fromARGB(255, 243, 241, 99), const Color.fromARGB(255, 224, 143, 77)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


