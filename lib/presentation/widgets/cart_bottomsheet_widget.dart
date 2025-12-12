import 'package:flutter/material.dart';
import 'package:repairo_app_new/presentation/widgets/cart_item_widget.dart';

class CartBottomSheet extends StatelessWidget {
  final Cart cart;

  const CartBottomSheet({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("مجموع: ${cart.total} درهم",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  // الانتقال للخطوة التالية
                },
                child: const Text("التالي"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  title: Text(item.service.name!),
                  subtitle: Text("x${item.quantity}"),
                  trailing: Text(
                      "${double.parse(item.service.price.toString()) * item.quantity} درهم"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
