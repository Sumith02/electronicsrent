import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ElectronicsItemForm extends StatefulWidget {
  static const String id = 'electronics-item-form';
  @override
  _ElectronicsItemFormState createState() => _ElectronicsItemFormState();
}

class _ElectronicsItemFormState extends State<ElectronicsItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _category = '';
  double _price = 0.0;
  int _quantity = 0;
  String _description = '';
  File? _image;
  String? _imageUrl;

  final List<String> _categories = ['Laptop', 'Smartphone', 'Tablet', 'Accessory'];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('electronics_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(_image!);
        _imageUrl = await ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Upload the image first
      await _uploadImage();

      // Save to Firestore with error handling
      try {
        await FirebaseFirestore.instance.collection('electronics_items').add({
          'name': _name,
          'category': _category,
          'price': _price,
          'quantity': _quantity,
          'description': _description,
          'image_url': _imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item added successfully!')),
        );

        // Clear the form
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _imageUrl = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding item: $e')),
        );
        print('Error adding item: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Electronics Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Category'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _quantity = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 20),
                _image == null
                    ? Text('No image selected.')
                    : Image.file(_image!, height: 200),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
