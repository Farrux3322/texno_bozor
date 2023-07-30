import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/ui/tab/category/add_category/add_category_screen.dart';
import 'package:texno_bozor/ui/tab/category/update/update_category_screen.dart';
import 'package:texno_bozor/utils/colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddCategoryScreen()));
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
                  return ListTile(
                    onLongPress: () {

                    },
                    title: Text(categoryModel.categoryName,style: TextStyle(color: Colors.white),),
                    subtitle: Text(categoryModel.description,style: TextStyle(color: Colors.white),),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateCategoryScreen(categoryModel: categoryModel)));
                            },
                            icon: const Icon(Icons.edit,color: Colors.white,),
                          ),
                          IconButton(onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content:const Padding(
                                  padding:  EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Delete Category",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500, color: AppColors.black),
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
                          }, icon: const Icon(Icons.delete,color: Colors.white,))
                        ],
                      ),
                    )
                  );
                },
              ),
            )
                : const Center(child: Text("Empty!",style: TextStyle(fontSize: 50,fontWeight: FontWeight.w700,color: AppColors.white),));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}




