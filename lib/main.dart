import 'package:flutter/material.dart';
import 'screens/orders_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Orders Dashboard',
      debugShowCheckedModeBanner: false,
      home: OrdersDashboard(),
    );
  }
}
