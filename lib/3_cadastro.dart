import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CriarContaPage extends StatefulWidget {
  const CriarContaPage({Key? key}) : super(key: key);

  @override
  _CriarContaPageState createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  //
  // RETORNAR UM DOCUMENTO a partir do ID
  //
  getDocumentById(id) async {
    // select * from tb_Usuarios where id = 1;
    await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtSenha.text = doc.get('senha');
      txtEmail.text = doc.get('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text.isEmpty &&
          txtSenha.text.isEmpty &&
          txtEmail.text.isEmpty) {
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Criar Conta'),
          centerTitle: true,
          backgroundColor: Colors.blue[400]),
      backgroundColor: Colors.blueGrey[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextFormField(
              controller: txtNome,
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Nome",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
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
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "E-mail",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              ),
            ),
            SizedBox(height: 15),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    color: Colors.blue[400],
                    child: OutlinedButton(
                        child: const Text(
                          'Criar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () => {
                              criarConta(
                                txtNome.text,
                                txtSenha.text,
                                txtEmail.text,
                              ),
                              if (id == null)
                                {
                                  //
                                  // ADICIONAR DOCUMENTO NO FIRESTORE
                                  //
                                  FirebaseFirestore.instance
                                      .collection('Usuarios')
                                      .add({
                                    'nome': txtNome.text,
                                    'senha': txtSenha.text,
                                    'email': txtEmail.text,
                                  }),
                                }
                              else
                                {
                                  //
                                  // ATUALIZAR DOCUMENTO NO FIRESTORE
                                  //
                                  FirebaseFirestore.instance
                                      .collection('Usuarios')
                                      .doc(id.toString())
                                      .set({
                                    'nome': txtNome.text,
                                    'senha': txtSenha.text,
                                    'email': txtEmail.text
                                  })
                                },
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('Operação realizada com sucesso!'),
                                duration: Duration(seconds: 2),
                              )),
                              Navigator.pop(context),
                            })),
                const SizedBox(height: 40),
                Container(
                  width: 150,
                  color: Colors.blue[400],
                  child: OutlinedButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  //
  // criar conta firebase
  //
  void criarConta(nome, senha, email) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário criado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }).catchError((erro) {
      if (erro.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ERRO: O email informado já está em uso.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ERRO: ${erro.message}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
