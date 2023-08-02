import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/order/order_model.dart';
import 'package:texno_bozor/provider/order_provider.dart';
import 'package:texno_bozor/ui/tab_user/orders/order_detail_screen/order_detail_screen.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.70,
            child: StreamBuilder<List<OrderModel>>(
              stream: context
                  .read<OrderProvider>()
                  .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
              builder:
                  (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                          (index) {
                        OrderModel orderModel = snapshot.data![index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                          margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.blue.withOpacity(0.5)
                          ),
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(orderModel: orderModel)));
                            },
                            title: Text(orderModel.productName,style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                            subtitle: Text("${orderModel.count} ta ---> ${orderModel.totalPrice}",style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                            trailing: IconButton(onPressed: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  content:const Padding(
                                    padding:  EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Delete Order",
                                      style:
                                      TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                                    ),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        context.read<OrderProvider>().deleteOrder(
                                          context: context,
                                          orderId: orderModel.orderId,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      isDefaultAction: true,
                                      child: const Text("ok"),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      isDefaultAction: true,
                                      child: const Text("cancel"),
                                    ),

                                  ],
                                ),
                              );

                            },icon: const Icon(Icons.delete,color: Colors.red,),)
                          ),
                        );
                      },
                    ),
                  )
                      :  Center(child: Text("Empty!",style: TextStyle(fontSize: 32.spMin,color: Colors.white,fontWeight: FontWeight.w700),));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
            margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.green
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jami: ",style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                Text(Provider.of<OrderProvider>(context,listen: true).getOrdersPrice().toString(),style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
              ],
            ),
          )
        ],
      )
    );
  }
}
