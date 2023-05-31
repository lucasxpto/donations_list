import 'package:donations_list/donations_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();

  Future<void> cadastrarFirebase() async {
    var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controladorEmail.text, password: _controladorSenha.text);

    final user = credential.user;

    if(user != null)
      user.sendEmailVerification();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DonationsList()),
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _controladorSenha,
              decoration: InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: cadastrarFirebase, child: Text('Registrar'))
          ],
        ),
      ),
    );
  }
}