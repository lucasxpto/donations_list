import 'package:flutter/material.dart';

void customMaterialBanner (context, String title, Color corDeFundo){
  final materialBanner = MaterialBanner(backgroundColor: corDeFundo, content: Text('${title}'), actions: [GestureDetector(onTap: (){
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  } , child: Icon(Icons.close))]);
  ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
}