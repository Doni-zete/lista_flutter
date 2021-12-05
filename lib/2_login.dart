import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Loginpagina extends StatefulWidget {
  Loginpagina({Key? key}) : super(key: key);

  @override
  _LoginpaginaState createState() => _LoginpaginaState();
}

class _LoginpaginaState extends State<Loginpagina> {
  
  var txtNome = TextEditingController();
    var txtSenha = TextEditingController();
  var txtEmail = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    return Scaffold(
      body: Container(
            padding: EdgeInsets.only(top: 60, left: 40, right: 40),
            color: Color(0xfffff),
            child: ListView(
              children: <Widget>[
                SizedBox(
                    width: 128,
                    height: 128,
                    child: Center(
                      child: Image.asset("assets/images/fotoLogin.jpg"),
                    )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)),
                ),
              ),
            
            SizedBox(height: 15),
            TextFormField(
              controller: txtSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
              ),
            
            const SizedBox(height: 40),
            Container(
                  child: Column(children: [
                    ElevatedButton(
                        child: SizedBox(
                            width: 150,
                            height: 30,
                            child: Center(child: Text('Login'))),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  login(txtEmail.text, txtSenha.text);
                },
              ),
                  ],
            ),
            ),
            const SizedBox(height: 40),
            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            child: SizedBox(
                                width: 150,
                                height: 30,
                                child:
                                    Center(child: Text('Cadastrar'))),
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
              ),
                        ]
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
//login  firebase
   void login(email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      Navigator.pushNamed(context, '/lista');
    }).catchError((erro) {
      var mensagem = '';
      if (erro.code == 'user-not-found') {
        mensagem = 'ERRO: Usuário não encontrado';
      } else if (erro.code == 'wrong-password') {
        mensagem = 'ERRO: Senha incorreta';
      } else if (erro.code == 'invalid-email') {
        mensagem = 'ERRO: Email inválido';
      } else {
        mensagem = erro.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(mensagem), duration: const Duration(seconds: 2)));
    });
  }
}