import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/provider/products_provider.dart';
import 'package:texno_bozor/ui/tab_user/product/product_detail_screen/product_detail_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.categoryModel.categoryName} Category",
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StreamBuilder<List<ProductModel>>(
                stream: context.read<ProductsProvider>().getProducts(
                    widget.categoryModel.categoryId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? Expanded(
                            child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.6),
                            children: [
                              ...List.generate(snapshot.data!.length, (index) {
                                ProductModel productModel =
                                    snapshot.data![index];
                                return ZoomTapAnimation(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                                    productModel: productModel,
                                                    index: index)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0xFF22222A),),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Hero(
                                            tag: index,
                                            child: CachedNetworkImage(
                                              height: 100.h,
                                              width: 100.h,
                                              imageUrl: productModel
                                                  .productImages.first,
                                              placeholder: (context, url) =>
                                                  const CupertinoActivityIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              productModel.productName,
                                              style: TextStyle(
                                                  fontSize: 22.spMin,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              productModel.description,
                                              style: TextStyle(
                                                  fontSize: 18.spMin,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Price: ${productModel.price} ${productModel.currency}",
                                              style: TextStyle(
                                                  fontSize: 18.spMin,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Count: ${productModel.count}",
                                              style: TextStyle(
                                                  fontSize: 18.spMin,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                            ],
                          ))
                        : Center(
                            child: Text(
                            "Product Empty!",
                            style: TextStyle(
                                fontSize: 32.spMin,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ));
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
          ),
        ],
      ),
    );
  }
}
