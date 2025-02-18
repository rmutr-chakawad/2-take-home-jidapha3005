import 'package:flutter/material.dart';
import 'package:product_firestore_app/modele/product_madel.dart';
import 'package:product_firestore_app/widgets/product_popup.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductModel product;
  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context, 
          builder: (context){
            return ProductPopup(product: product);
          });
      },
      child: ListTile(
        title: Text(
          product.productName,
          style: const TextStyle(fontSize: 20,color:  Color.fromARGB(255, 10, 10, 10)), // ปรับขนาดและใส่สี
        ),
        trailing: Text(
          '${product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 10, 10, 10)), // ปรับขนาดและใส่สี
        
        ),
       
      ),
    );
  }
}