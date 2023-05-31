import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:validatorless/validatorless.dart';

class ItemRegistrationPage extends StatefulWidget {
  @override
  _ItemRegistrationPageState createState() => _ItemRegistrationPageState();
}

class _ItemRegistrationPageState extends State<ItemRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  PickedFile _itemImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _itemImage = pickedFile;
    });
  }

  Future<void> _registerItem() async {
    if (_formKey.currentState.validate()) {
      // Upload the item to Firebase Firestore...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register an Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: Validatorless.required('Title is required'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: Validatorless.required('Description is required'),
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: _pickImage,
              label: Text('Select Image'),
            ),
            RaisedButton(
              child: Text('Register Item'),
              onPressed: _registerItem,
            ),
          ],
        ),
      ),
    );
  }
}

