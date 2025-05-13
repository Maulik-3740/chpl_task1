import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_task1/colors/colors.dart';

class InsightCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap; // <-- Optional tap handler

  const InsightCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });

  static String getMostFrequentProduct(List<Map<String, dynamic>> orders) {
    final count = <String, int>{};
    for (var order in orders) {
      for (var item in order["items"]) {
        count[item["product"]] = (count[item["product"]] ?? 0) + 1;
      }
    }
    return count.entries.isNotEmpty
        ? count.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : "-";
  }

static List<Map<String, dynamic>> highValueOrders(List<Map<String, dynamic>> orders) {
  List<Map<String, dynamic>> result = [];

  for (var order in orders) {
    List items = order["items"];

    int total = 0;
    for (var item in items) {
      int price = int.parse(item["price"].toString());
      total += price;
    }

    if (total > 2000) {
      result.add(order); 
    }
  }

  return result;
}


  static List<String> getUniqueProducts(List<Map<String, dynamic>> orders) {
    final products = <String>{};
    for (var order in orders) {
      for (var item in order["items"]) {
        products.add(item["product"]);
      }
    }
    return products.toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.42;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12, bottom: 20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: ConstColors.mainColor,
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
