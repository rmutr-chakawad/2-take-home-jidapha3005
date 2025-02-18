import 'package:flutter/material.dart';
import 'package:product_firestore_app/widgets/product_list.dart';
import 'package:product_firestore_app/widgets/product_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // เพิ่มสีพื้นหลัง
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Color.fromARGB(255, 22, 22, 22), fontWeight: FontWeight.bold),//ใส่สีตัวอักษร
        ),
        backgroundColor: Colors.blueAccent, // เพิ่มพื้นหลังของProduct List
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => ProductPopup(),
              );
            },
            icon: const Icon(Icons.add, color: Color.fromARGB(255, 18, 7, 116)),//ใส่สีตรงปุ่มadd
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),//ทำให้พื้นหลังเป็นขอบมน
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ProductList(),
          ),
        ),
      ),
    );
  }
}