import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/provider/category_provider.dart';
import 'package:texno_bozor/provider/products_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/ui/tab_admin/category/utils/utils.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class ProductAddScreen extends StatefulWidget {
  ProductAddScreen({super.key, this.productModel});

  ProductModel? productModel;

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {

  String? _imageUrl;
  File? image;
  Future pickImage() async {
    try {
      showLoading(context: context);
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(context.mounted){
        hideLoading(dialogContext: context);
      }
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    // ignore: empty_catches
    } on PlatformException catch (e) {
    }
  }
  Future pickCamera() async {
    try {
      showLoading(context: context);
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(context.mounted){
        hideLoading(dialogContext: context);
      }
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  Future<void> _uploadImage() async {
    showLoading(context: context);
    String? downloadUrl = await uploadImageToFirebase(image);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    setState(() {
      _imageUrl = downloadUrl;
    });
  }
  String currency = "";

  List<String> currencies = ["UZS", "USD", "RUB"];

  String selectedCurrency = "UZS";
  String selectedCategoryId = "";


  @override
  void initState() {
    if (widget.productModel != null) {
      context.read<ProductsProvider>().setInitialValues(widget.productModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductsProvider>(context, listen: false).clearTexts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.productModel == null ? "Product Add" : "Product Update"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlobalTextField(
                        hintText: "Product Name",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductsProvider>()
                            .productNameController),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlobalTextField(
                        isDescription: true,
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductsProvider>()
                            .productDescController),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlobalTextField(
                      digit: true,
                      hintText: "Product Count",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller:
                      context.read<ProductsProvider>().productCountController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GlobalTextField(
                      digit: true,
                      hintText: "Product Price",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller:
                      context.read<ProductsProvider>().productPriceController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 160.w),
                    child: DropdownButton(
                      value: selectedCurrency,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencies.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items,style: TextStyle(fontSize: 18.spMin,color: Colors.blue,fontWeight: FontWeight.w500),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCurrency = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoryModel>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? SizedBox(
                          height: 100,
                               child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              snapshot.data!.length,
                                  (index) {
                                CategoryModel categoryModel =
                                snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryId =
                                          categoryModel.categoryId;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                      color: selectedCategoryId ==
                                          categoryModel.categoryId
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                    height: 100,
                                    margin: const EdgeInsets.all(16),
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: Text(
                                        categoryModel.categoryName,
                                        style: TextStyle(
                                          color: selectedCategoryId ==
                                              categoryModel.categoryId
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                            : const Center(child: Text("Empty!"));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlobalButton(
                  title: widget.productModel == null
                      ? "Add product"
                      : "Update product",
                  onTap: () async{
                    await _uploadImage();
                    if (_imageUrl != null &&
                        selectedCategoryId.isNotEmpty) {
                      if(widget.productModel==null){
                        if(context.mounted){
                          context.read<ProductsProvider>().addProduct(
                            context: context,
                            imageUrls: [_imageUrl!],
                            categoryId: selectedCategoryId,
                            productCurrency: selectedCurrency,
                          );
                        }
                      }else{
                        if(context.mounted){
                          context.read<ProductsProvider>().updateProduct(
                            context: context,
                            imageUrls: [_imageUrl!],
                            categoryId: selectedCategoryId,
                            productCurrency: selectedCurrency,
                          );
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
                              "Ma'lumotlar to'liq emas!!!",
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
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }


}
