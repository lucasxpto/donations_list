import 'package:firebase_auth/firebase_auth.dart';
import 'custom_material_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'donations_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();

  Future<void> logarFirebase() async {
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controladorEmail.text, password: _controladorSenha.text);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  Future<void> logarGoogle() async {
    final GoogleSignIn googleSignIn = await GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;
    print(googleAuth?.idToken); // should not be null or empty
    print(googleAuth?.accessToken); // should not be null or empty

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult = await FirebaseAuth.instance
        .signInWithCredential(credential);
    final User? user = authResult.user;

    // customMaterialBanner(context, 'Logado com sucesso!', Colors.green);
    if (user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }

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
        title: Text('Entrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controladorSenha,
              decoration: InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/register");
                },
                child: Text('Não tem conta? Clique aqui!')),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/recoveryPass");
                },
                child: Text('Esqueceu a Senha?')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: logarGoogle, child: Text('Logar usando Conta Google')),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: logarFirebase, child: Text('Logar usando E-mail e Senha'))
          ],
        ),
      ),
    );
  }
}