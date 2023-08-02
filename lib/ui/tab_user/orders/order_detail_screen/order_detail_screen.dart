import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texno_bozor/data/models/order/order_model.dart';



class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderModel});

  final OrderModel orderModel;


  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();


}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail",style: TextStyle(fontSize: 20.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Expanded(child: ListView(
              physics: const ScrollPhysics(),
              children: [
                SizedBox(height: 20.h,),
                Text(widget.orderModel.productName,style: TextStyle(fontSize: 32.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                SizedBox(height: 20.h,),
                SizedBox(height: 20.h,),
                Text("Count: ${widget.orderModel.count}",style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                SizedBox(height: 20.h,),
                Text("Total Price: ${widget.orderModel.totalPrice}",style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                SizedBox(height: 20.h,),
                Text("Created: ${widget.orderModel.createdAt.substring(0,10)}",style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}
