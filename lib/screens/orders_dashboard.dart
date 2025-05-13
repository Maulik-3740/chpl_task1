import 'package:flutter/material.dart';
import 'package:flutter_task1/colors/colors.dart';
import 'package:flutter_task1/widgets/insights_panel.dart';
import '../data/orders_sample.dart';
import '../widgets/order_card.dart';

class OrdersDashboard extends StatefulWidget {
  const OrdersDashboard({super.key});

  @override
  State<OrdersDashboard> createState() => _OrdersDashboardState();
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  List<Map<String, dynamic>> allOrders = orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: ConstColors.mainColor,
        title: const Text(
          "Customer Orders Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              "Insights",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                InsightCard(
                  label: "Most Ordered",
                  value: InsightCard.getMostFrequentProduct(allOrders),
                  icon: Icons.shopping_bag,
                ),
                InsightCard(
                  label: "High ₹ Orders",
                  value:
                      InsightCard.highValueOrders(allOrders).length.toString(),
                  icon: Icons.trending_up,
                  onTap: () => highOrderBottomSheet(),
                ),
                InsightCard(
                  label: "Unique Products",
                  value:
                      InsightCard.getUniqueProducts(
                        allOrders,
                      ).length.toString(),
                  icon: Icons.inventory,
                  onTap: () => uniqueBottomSheet(),
                ),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allOrders.length,
                  itemBuilder: (context, index) {
                    final person = allOrders[index];
                    return InsightCard(
                      label: person['customer'],
                      value:
                          OrderCard.calculateTotal(
                            person['items'].toList(),
                          ).toString(),
                      icon: Icons.person,
                    );
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: allOrders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: allOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  highOrderBottomSheet() {
    final data = InsightCard.highValueOrders(allOrders);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "High Orders",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final value = data[index];
                  final items = value["items"];
                  final total = OrderCard.calculateTotal(items);

                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text(value['customer'])),
                        Text(
                          "₹${total.toString()}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  uniqueBottomSheet() {
    final uniqueProducts = InsightCard.getUniqueProducts(allOrders);

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Unique Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...uniqueProducts.map(
                        (product) => bottomSheetText(product: product),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bottomSheetText({required String product}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: ConstColors.mainColor,
        child: const Icon(size: 20, Icons.shopping_cart, color: Colors.white),
      ),
      title: Text(product),
    );
  }
}
