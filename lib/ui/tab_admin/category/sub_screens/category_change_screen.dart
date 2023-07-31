import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/ui/tab_admin/category/utils/utils.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class CategoryAddScreen extends StatefulWidget {
  CategoryAddScreen({super.key, this.categoryModel});

  CategoryModel? categoryModel;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  String? _imageUrl;
  File? image;
  Future pickImage() async {
    try {
      showLoading(context: context);
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(context.mounted){
        hideLoading(dialogContext:context);
      }
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  Future pickCamera() async {
    try {
      showLoading(context: context);
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  Future<void> _uploadImage() async {
    showLoading(context: context);
    String? downloadUrl = await uploadImageToFirebase(image);
    if(context.mounted){
      hideLoading(dialogContext:context);
    }
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  @override
  void initState() {
    if (widget.categoryModel != null) {
      context.read<CategoryProvider>().setInitialValues(widget.categoryModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Provider.of<CategoryProvider>(context, listen: false)
            .clearTexts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryModel == null
              ? "Category Add"
              : "Category Update"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    GlobalTextField(
                        hintText: "Name",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<CategoryProvider>()
                            .categoryNameController),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: GlobalTextField(
                          isDescription: true,
                          hintText: "Description",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.start,
                          controller: context
                              .read<CategoryProvider>()
                              .categoryDescController),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 180,
                          child: TextButton(
                            onPressed: () async {
                              await pickImage();
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text(
                              "Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        if (image != null)
                          Image.file(
                            File(
                              image!.path,
                            ),
                            height: 100.h,
                            width: 50.w,
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              GlobalButton(
                  title: widget.categoryModel == null
                      ? "Add category"
                      : "Update Category",
                  onTap: () async{
                    await _uploadImage();
                    if (_imageUrl!=null) {
                      if (widget.categoryModel == null) {
                        if(context.mounted){
                          context.read<CategoryProvider>().addCategory(
                            context: context,
                            imageUrl: _imageUrl!,
                          );
                        }
                      } else {
                       if(context.mounted){
                         context.read<CategoryProvider>().updateCategory(
                             context: context,
                             imagePath: _imageUrl!,
                             currentCategory: widget.categoryModel!);
                       }
                      }
                    } else {
                      if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 500),
                            backgroundColor: Colors.red,
                            margin: EdgeInsets.symmetric(
                              vertical: 100,
                              horizontal: 20,
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Select image!!!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  }),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }

}
