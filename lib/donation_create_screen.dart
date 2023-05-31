import 'dart:io';

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
  late PickedFile _itemImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _itemImage = pickedFile!;
    });
  }

  Future<void> _registerItem() async {
    if (_formKey.currentState!.validate()) {
      // O primeiro passo é carregar a imagem para o Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('item_images').child('${DateTime.now()}.png');
      await storageRef.putFile(File(_itemImage.path));

      // Em seguida, obtenha a URL da imagem carregada
      final imageUrl = await storageRef.getDownloadURL();

      // Agora, vamos salvar o item no Firestore
      FirebaseFirestore.instance.collection('items').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        // Você pode adicionar outros campos aqui, se necessário
      }).then((value) {
        print("Item Added");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added Successfully!")));
      }).catchError((error) {
        print("Failed to add item: $error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add item")));
      });
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
            SizedBox(height: 30),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: _pickImage,
              tooltip: 'Select Image',
            ),
            SizedBox(height: 30),
            TextButton(
              child: Text('Register Item'),
              onPressed: _registerItem,
            ),
          ],
        ),
      ),
    );
  }
}

