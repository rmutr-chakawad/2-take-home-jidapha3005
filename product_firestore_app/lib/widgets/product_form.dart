import 'package:flutter/material.dart';
import 'package:product_firestore_app/modele/product_madel.dart';
import 'package:product_firestore_app/service/Databade.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  final ProductModel? product;
  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final Database db = Database.myInstance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // ป้องกัน Overflow
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ให้ Column ปรับขนาดอัตโนมัติ
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.product == null ? 'เพิ่มสินค้า' : 'แก้ไข ${widget.product!.productName}',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold), //เพิ่มขนาดตัวอักษรให้ใหญ่
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'ชื่อสินค้า',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ราคาสินค้า',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Wrap(      //ใช้ Wrapแทนrowเพราะมีหลายปุ่มจะทำให้ปุ่มเรียงได้สวย
                spacing: 10, // ระยะห่างระหว่างปุ่ม
                children: [
                  showBtnOk(),
                  showBtnCancel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showBtnOk() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // ปุ่มสีน้ำเงิน
        foregroundColor: Colors.white, // สีตัวอักษร
      ),
      onPressed: () async {
        String newId = 'PD${DateTime.now().microsecondsSinceEpoch}';
        await db.setProduct(
          product: ProductModel(
            id: widget.product == null ? newId : widget.product!.id,
            productName: nameController.text,
            price: double.tryParse(priceController.text) ?? 0,
          ),
        );
        nameController.clear();
        priceController.clear();

        if (mounted) { 
          Navigator.of(context).pop(); // ปิด Dialog อย่างปลอดภัย
        }
      },
      child: const Text('เพิ่ม'),
    );
  }

  Widget showBtnCancel() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // ปุ่มสีแดง
        foregroundColor: Colors.white, // สีตัวอักษร
      ),
      onPressed: () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      child: const Text('ปิด'),
    );
  }
}
