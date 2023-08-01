import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/ui/tab_user/category/category_detail_screen/category_detail_screen.dart';

class CategoryUserScreen extends StatefulWidget {
  const CategoryUserScreen({super.key});

  @override
  State<CategoryUserScreen> createState() => _CategoryUserScreenState();
}

class _CategoryUserScreenState extends State<CategoryUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  CategoryModel categoryModel = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.withOpacity(0.8),
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetailScreen(categoryModel: categoryModel)));
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          height: 50.h,
                          width: 50.h,
                          imageUrl: categoryModel.imageUrl,
                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      title: Text(categoryModel.categoryName,style: TextStyle(fontSize: 24.spMin,color: Colors.black,fontWeight: FontWeight.w700),),
                      subtitle: Text(categoryModel.description,style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                    ),
                  );
                },
              ),
            )
                :  Center(child: Text("Empty!",style: TextStyle(fontSize: 40.spMin,color: Colors.white,fontWeight: FontWeight.w700),));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CupertinoActivityIndicator(radius: 20,));
        },
      ),
    );
  }
}
