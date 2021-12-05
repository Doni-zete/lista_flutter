import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InserirDocumentoPage extends StatefulWidget {
  const InserirDocumentoPage({Key? key}) : super(key: key);

  @override
  _InserirDocumentoPageState createState() => _InserirDocumentoPageState();
}

class _InserirDocumentoPageState extends State<InserirDocumentoPage> {
   var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  //
  // RETORNAR UM DOCUMENTO a partir do ID
  //
  getDocumentById(id) async{
    
    // select * from tb_Listas where id = 1;
    await FirebaseFirestore.instance.collection('Listas')
      .doc(id).get().then((doc){
        txtNome.text = doc.get('nome');
        txtPreco.text = doc.get('preco');
      });

  }

  @override
  Widget build(BuildContext context) {

    //
    // RECUPERAR o ID do Café
    //
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null){
      if (txtNome.text.isEmpty && txtPreco.text.isEmpty){
        getDocumentById(id);
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Criptomoeda'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[400],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
             TextField(
              controller: txtNome,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit),
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtPreco,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container( width: 150,
                  color: Colors.blue[400],
                  child: OutlinedButton(
                    child: const Text('Salvar', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                    onPressed: () {

                      if (id == null){
                        //
                        // ADICIONAR DOCUMENTO NO FIRESTORE
                        //
                        FirebaseFirestore.instance
                            .collection('Listas')
                            .add({'nome': txtNome.text, 'preco': txtPreco.text});
                      }else{
                        //
                        // ATUALIZAR DOCUMENTO NO FIRESTORE
                        //
                        FirebaseFirestore.instance
                            .collection('Listas')
                            .doc(id.toString()).set({'nome': txtNome.text, 'preco': txtPreco.text});
                      }


                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Operação realizada com sucesso!'),
                        duration: Duration(seconds: 2),
                      ));

                      Navigator.pop(context);
                    },
                  ),
                ),
                Container( width: 150,
                  color: Colors.blue[400],
                  child: OutlinedButton(
                    child: const Text('Cancelar', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}