import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/ui/tab_admin/category/sub_screens/category_change_screen.dart';

class CategoryAdminScreen extends StatefulWidget {
  const CategoryAdminScreen({super.key});

  @override
  State<CategoryAdminScreen> createState() => _CategoryAdminScreenState();
}

class _CategoryAdminScreenState extends State<CategoryAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories Admin"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  CategoryAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
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
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            content:const Padding(
                              padding:  EdgeInsets.only(top: 10),
                              child: Text(
                                "Delete Category",
                                style:
                                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  context.read<CategoryProvider>().deleteCategory(
                                    context: context,
                                    categoryId: categoryModel.categoryId,
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
                      title: Text(categoryModel.categoryName,style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                      subtitle: Text(categoryModel.description,style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return  CategoryAddScreen(
                                  categoryModel: categoryModel,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit,color: Colors.white,),
                      ),
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
