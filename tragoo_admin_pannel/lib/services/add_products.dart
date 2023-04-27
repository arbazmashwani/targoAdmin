

import 'package:firebase_storage/firebase_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as i;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';
import '../services/products.dart';
class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  XFile ? _Image1;
  XFile ? _Image2;
  XFile ? _Image3;
  bool isLoading = false;
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  final SelectedCategoryController = TextEditingController();
  ProductService productService = ProductService();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final signupStyles = ScreenStyles();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          ' ADD PRODUCT ',
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: formKey,
        child: isLoading ?
        Center(
          child: CircularProgressIndicator(
             strokeWidth: 5,

          ),
        )
            :
        ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 2.0, color: black.withOpacity(0.5))),
                    onPressed: () {
                      _selectImage(_picker.pickImage(source: ImageSource.gallery),1);
                    },
                    child: displayChild1()
                  ),
                )),
                Expanded(
                    child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(width: 2.0, color: black.withOpacity(0.5))),
                  onPressed: () {
                    _selectImage(ImagePicker().pickImage(source: ImageSource.gallery),2);
                  },
                  child: displayChild2(),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 2.0, color: black.withOpacity(0.5))),
                    onPressed: () {
                      _selectImage(ImagePicker().pickImage(source: ImageSource.gallery),3);
                    },
                    child: displayChild3()
                  ),
                ))
              ],
            ),
            Column(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: productTitleController,
                  decoration: InputDecoration(labelText: ' Title '),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' You must Enter the Product Title';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: productPriceController,
                  decoration: InputDecoration(labelText: ' Price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' You must Enter the Product Price';
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: productDescriptionController,
                  decoration: InputDecoration(labelText: 'Product Description '),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' You must Enter the Product Description';
                    } else if (value.length > 100) {
                      return 'Product description cant have more than 10 letters';
                    }
                  }),
            ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<CategoryDropDownSelectedItem>(
                        iconSize: 0.0,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors.kGreyClr,
                              fontSize: 15.0,
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(05.0),
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Colors.grey,
                                    style: BorderStyle.none))),
                        value: selectedCategory,
                        hint: const Text(
                          'Category',
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                            print('selected item ${selectedCategory.queryType}');
                          });
                        },
                        validator: (value) =>
                        value == null ? 'Field required' : null,
                        items:
                        restTypeItems.map((CategoryDropDownSelectedItem item) {
                          return DropdownMenuItem<CategoryDropDownSelectedItem>(
                            value: item,
                            child: Text(item.queryType),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: DropdownButtonFormField<PackDropDownSelectedItem>(
                        iconSize: 0.0,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors.kGreyClr,
                              fontSize: 15.0,
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(05.0),
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Colors.grey,
                                    style: BorderStyle.none))),
                        value: selectedPack,
                        hint: const Text(
                          'Select Pack',
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedPack = newValue!;
                            print(selectedPack.queryType);

                          });
                        },
                        validator: (value) =>
                        value == null ? 'Field required' : null,
                        items: packItems.map((PackDropDownSelectedItem item) {
                          return DropdownMenuItem<PackDropDownSelectedItem>(
                            value: item,
                            child: Text(item.queryType),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

              ),
              ],
            ),


            Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 40.0),
              child: signupStyles.customButton(
                btnFunction: () {
                  validateAndUpload();
                },
                btnText: "upload product",
                context: context,
              ),
            )
          ],
        ),
      ),
    );
  }

  //____________________//
  dynamic selectedPack;
  List<PackDropDownSelectedItem> packItems = <PackDropDownSelectedItem>[
    const PackDropDownSelectedItem(0, '...Select Pack...'),
    const PackDropDownSelectedItem(1, '12 Pack'),
    const PackDropDownSelectedItem(2, '24 Pack'),
  ];
  final formKey = GlobalKey<FormState>();





  dynamic selectedCategory;
  List<CategoryDropDownSelectedItem> restTypeItems =
  <CategoryDropDownSelectedItem>[
    const CategoryDropDownSelectedItem(0, '...Select Category...'),
    const CategoryDropDownSelectedItem(1, 'Liquor'),
    const CategoryDropDownSelectedItem(2, 'Beer'),
    const CategoryDropDownSelectedItem(3, 'Cigarette'),
  ];

  void _selectImage(Future<XFile?> pickImage, int imageNumber) async{
    XFile? tempImg = await pickImage;
    switch(imageNumber)
    {
      case 1: setState(() {
        _Image1 =  tempImg;
      });
      break;
      case 2: setState(() {
        _Image2 =  tempImg;
      });
      break;
      case 3: setState(() {
        _Image3 =  tempImg;
      });
    }

  }

 Widget displayChild2() {
    if(_Image2 == null)
      {
        return
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Icon(Icons.add, color: grey),
        );
      }
    else{
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
        child: Image.file(i.File(_Image2!.path),fit: BoxFit.fill,width: double.infinity)
      );
    }
  }
  Widget displayChild1() {
    if(_Image1 == null)
    {
      return
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Icon(Icons.add, color: grey),
        );
    }
    else{
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Image.file(i.File(_Image1!.path),fit: BoxFit.fill,width: double.infinity,)
      );
    }
  }
  Widget displayChild3() {
    if(_Image3 == null)
    {
      return
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Icon(Icons.add, color: grey),
        );
    }
    else{
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Image.file(i.File(_Image3!.path),fit: BoxFit.fill,width: double.infinity)
      );
    }
  }
  void validateAndUpload() async
  {
    if(formKey.currentState!.validate())
      {
        setState(() {
          isLoading = true;
        });
        if(_Image1 != null && _Image2 != null && _Image3 != null)
          {
            print("called_______________________________________");
            String imageUrl1 = "";
            String imageUrl2 = "";
            String imageUrl3 = "";
            FirebaseStorage storage = FirebaseStorage.instance;

            Reference ref1 = storage.ref().child("Image1" + DateTime.now().toString()+".jpg");
            UploadTask uploadTask1 = ref1.putFile(i.File(_Image1!.path));
            uploadTask1.then((res) {
              res.ref.getDownloadURL();
            });
            Reference ref2 = storage.ref().child("Image2" + DateTime.now().toString()+".jpg");
            UploadTask uploadTask2 = ref2.putFile(i.File(_Image2!.path));
            uploadTask2.then((res) {
              res.ref.getDownloadURL();
            });

            Reference ref3 = storage.ref().child("Image3" + DateTime.now().toString()+".jpg");
            UploadTask uploadTask3 = ref3.putFile(i.File(_Image3!.path));
            TaskSnapshot taskSnapshot = await uploadTask3.whenComplete(() async{
              imageUrl1 = await ref1.getDownloadURL();
              imageUrl2 = await ref2.getDownloadURL();
              imageUrl3 = await ref3.getDownloadURL();

            } );

            print("-------------------------------");
            print(imageUrl3);

            List<String> ImageList = [imageUrl1,imageUrl2,imageUrl3];
            print("imageUrl1 : $imageUrl1");
            productService.createProduct(
                productTitleController.text,
                double.parse(productPriceController.text),
                productDescriptionController.text,
                selectedCategory.queryType,
                selectedPack.queryType,
                ImageList
                );
            formKey.currentState?.reset();
            setState(() {
              isLoading = false;
              Fluttertoast.showToast(msg: "Product Added Successfully");
            });

             }

        else
          {
            setState(() {
              Fluttertoast.showToast(msg: "Please All the images must be provided");
              isLoading= false;
            });

          }
      }
    else
      {
        setState(() {
          isLoading = false;
        });
      }
  }

}
class CategoryDropDownSelectedItem {
  final String queryType;
  final int id;

  const CategoryDropDownSelectedItem(this.id, this.queryType);
}
class PackDropDownSelectedItem {
  final String queryType;
  final int id;

  const PackDropDownSelectedItem(this.id, this.queryType);
}
