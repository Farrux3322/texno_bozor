import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:texno_bozor/data/fairbase/category_service.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider({required this.categoryService});

  final CategoryService categoryService;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryDescController = TextEditingController();

  Future<void> addCategory({
    required BuildContext context,
    required String imageUrl,
  }) async {
    String name = categoryNameController.text;
    String categoryDesc = categoryDescController.text;

    if (name.isNotEmpty && categoryDesc.isNotEmpty) {
      CategoryModel categoryModel = CategoryModel(
        categoryId: "",
        categoryName: name,
        description: categoryDesc,
        imageUrl: imageUrl,
        createdAt: DateTime.now().toString(),
      );
      showLoading(context: context);
      UniversalData universalData =
      await categoryService.addCategory(categoryModel: categoryModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    } else {
      showMessage(context, "Maydonlar to'liq emas!!!");
    }
  }

  Future<void> updateCategory({
    required BuildContext context,
    required String imagePath,
    required CategoryModel currentCategory,
  }) async {
    String name = categoryNameController.text;
    String categoryDesc = categoryDescController.text;

    if (name.isNotEmpty && categoryDesc.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await categoryService.updateCategory(
          categoryModel: CategoryModel(
            categoryId: currentCategory.categoryId,
            createdAt: currentCategory.createdAt,
            categoryName: categoryNameController.text,
            description: categoryDescController.text,
            imageUrl: imagePath,
          ));
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required String categoryId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
    await categoryService.deleteCategory(categoryId: categoryId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<CategoryModel>> getCategories() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event1) => event1.docs
            .map((doc) => CategoryModel.fromJson(doc.data()))
            .toList(),
      );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  setInitialValues(CategoryModel categoryModel) {
    categoryNameController =
        TextEditingController(text: categoryModel.categoryName);
    categoryDescController =
        TextEditingController(text: categoryModel.description);
    notifyListeners();
  }

  clearTexts() {
    categoryDescController.clear();
    categoryNameController.clear();
  }
}