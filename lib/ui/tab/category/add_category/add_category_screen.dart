import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/utils/colors.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category ",
          style: TextStyle(fontSize: 24.sp, color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                Text("Category Name",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700,color: Colors.white),),
                SizedBox(height: 30.h,),
                GlobalTextField(
                    hintText: "Category Name",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller: context.read<CategoryProvider>().categoryName),
                SizedBox(height: 60.h,),
                Text("Description",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700,color: Colors.white),),
                SizedBox(height: 30.h,),
                GlobalTextField(
                  isDescription: true,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                    controller: context.read<CategoryProvider>().description),
                SizedBox(height: 60.h,),
                GlobalButton(title: "Save", onTap: (){
                  context.read<CategoryProvider>().addCategory(
                    context: context,
                    categoryModel: CategoryModel(
                      categoryId: "",
                      categoryName: context.read<CategoryProvider>().categoryName.text,
                      description: context.read<CategoryProvider>().description.text,
                      imageUrl: "imageUrl",
                      createdAt: DateTime.now().toString(),
                    ),
                  );
                  Navigator.pop(context);
                })
              ],
            ))
          ],
        ),
      ),
    );
  }
}
