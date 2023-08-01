import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product",style: TextStyle(fontSize: 20.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Expanded(child: ListView(
              physics: const ScrollPhysics(),
              children: [
                Hero(
                  tag: widget.index,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: CachedNetworkImage(
                      height: 250.h,
                      width: 250.h,
                      imageUrl: widget.productModel.productImages.first,
                      placeholder: (context, url) => const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Text(widget.productModel.productName,style: TextStyle(fontSize: 32.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                SizedBox(height: 20.h,),
                Text(widget.productModel.description,style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w400),),
                SizedBox(height: 20.h,),
                Text("Count: ${widget.productModel.count}",style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                SizedBox(height: 20.h,),
                Text("Price: ${widget.productModel.price} ${widget.productModel.currency}",style: TextStyle(fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
              ],
            ),
            ),
            GlobalButton(onTap: (){},title: "Add to Card",)
          ],
        ),
      ),
    );
  }
}
