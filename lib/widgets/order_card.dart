import 'package:flutter/material.dart';
import 'package:flutter_task1/colors/colors.dart';
import 'package:flutter_task1/widgets/rich_text.dart';

class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  static int calculateTotal(List items) {
    return items.fold(
      0,
      (sum, item) => sum + int.parse(item["price"].toString()),
    );
  }

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final items = widget.order["items"];
    final total = OrderCard.calculateTotal(items);
    bool expanded = false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: expanded,
          onExpansionChanged: (value) {
            setState(() {
              expanded = value;
            });
          },
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              widget.order["customer"],
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextWidget(
                firstText: "Order ID: ",
                secondText: " ${widget.order["orderId"]}",
              ),
              SizedBox(height: 2),
              RichTextWidget(
                firstText: "Total bill : ",
                secondText: " ₹$total",
              ),
            ],
          ),
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Divider(height: 1),
                );
              },
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: ConstColors.mainColor,
                    child: const Icon(
                      size: 20,
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  horizontalTitleGap: 10,
                  title: Text(item["product"], overflow: TextOverflow.ellipsis),
                  trailing: Text("₹${item["price"]}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
