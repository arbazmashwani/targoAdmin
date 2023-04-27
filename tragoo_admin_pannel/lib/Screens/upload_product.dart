import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

import '../Utilities/constants/app_colors.dart';
import '../Utilities/constants/ui_view.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  _UploadProductScreenState createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  dynamic _title;
  dynamic _price;
  dynamic _description;
  // bool uploading = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  final List<File> _image = [];
  final picker = ImagePicker();

  ///popups
  dynamic selectedCategory;
  List<CategoryDropDownSelectedItem> restTypeItems =
      <CategoryDropDownSelectedItem>[
    const CategoryDropDownSelectedItem(0, '...Select Category...'),
    const CategoryDropDownSelectedItem(1, 'Liquor'),
    const CategoryDropDownSelectedItem(2, 'Beer'),
    const CategoryDropDownSelectedItem(3, 'Cigarette'),
  ];

  ///popups
  dynamic selectedPack;
  List<PackDropDownSelectedItem> packItems = <PackDropDownSelectedItem>[
    const PackDropDownSelectedItem(0, '...Select Pack...'),
    const PackDropDownSelectedItem(1, '12 Pack'),
    const PackDropDownSelectedItem(2, '24 Pack'),
  ];
  final formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryClr,
          centerTitle: true,
          title: const Text(
            'Upload Product',
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 18.0),
          child: Center(
            child: SingleChildScrollView(
              child: _image.isEmpty
                  ? const Center(child: Text('Select maximum 3  Product Image'))
                  : enableUpload(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: chooseImage,
          tooltip: 'Add Image',
          backgroundColor: AppColors.kPrimaryClr,
          child: const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

//
  Widget enableUpload() {
    final signupStyles = ScreenStyles();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child:Column(
          children: [
            SizedBox(
              height: 120,
              child: GridView.builder(
                  itemCount: _image.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index]),
                              fit: BoxFit.cover)),
                    );
                  }),
            ),

            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                return value!.isEmpty ? 'Give a tittle to your Image' : null;
              },
              onSaved: (value) {
                _title = value;
                return _title;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              validator: (value) {
                return value!.isEmpty ? 'Give price of your product' : null;
              },
              onSaved: (value) {
                _price = value;
                return _price;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                return value!.isEmpty ? 'Describe about  your product' : null;
              },
              onSaved: (value) {
                _description = value;
                return _description;
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
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
                const SizedBox(
                  width: 6,
                ),
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
                        if (kDebugMode) {
                          print('selected item ${selectedPack.queryType}');
                        }
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
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 40.0),
              child: signupStyles.customButton(
                btnFunction: () {
                  debugPrint("Sign Up Tab");
                  final isFilled = formKey.currentState?.validate();
                  if (!isFilled!) {
                    return null;
                  } else {
                    // _signupFunction();
                  }
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

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref?.putFile(img).whenComplete(() async {
        await ref?.getDownloadURL().then((value) {
          imgRef?.add({'url': value});
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}

///
// A class containing the menu items
class CategoryDropDownSelectedItem {
  final String queryType;
  final int id;

  const CategoryDropDownSelectedItem(this.id, this.queryType);
}

// A class containing the menu items
class PackDropDownSelectedItem {
  final String queryType;
  final int id;

  const PackDropDownSelectedItem(this.id, this.queryType);
}
