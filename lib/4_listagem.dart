import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AdiconarLista extends StatefulWidget {
  const AdiconarLista({Key? key}) : super(key: key);

  @override
  _AdiconarListaState createState() => _AdiconarListaState();
}

class _AdiconarListaState extends State<AdiconarLista> {
  //Referenciar a Coleção de Cafés
  late CollectionReference Listas;

  @override

  
  void initState() {
    super.initState();

    Listas = FirebaseFirestore.instance.collection('Listas');
  }

  //
  // Item Lista
  // Definir a aparência de cada item da lista
  Widget itemLista(item) {
    String nome = item.data()['nome'];
    String preco = item.data()['preco'];

    return ListTile(

      
      title: Text(nome, style: const TextStyle(fontSize: 30)),
      subtitle: Text(preco, style: const TextStyle(fontSize: 25)),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //
            // apagar um documento da criação
            //
            Listas.doc(item.id).delete();
          }),
      onTap: () {
        Navigator.pushNamed(context, '/inserir', arguments: item.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adiconar Listas'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        automaticallyImplyLeading: false,
        actions: [
        
        ],
      ),

      //
      // EXIBIR OS DOCUMENTOS DA COLEÇÃO DE Listas
      //
      body: StreamBuilder<QuerySnapshot>(

          //fonte de dados (coleção)
          stream: Listas.snapshots(),

          //exibir os dados retornados
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                    child: Text('Não foi possível conectar ao Firebase'));

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              //dados recebidos
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      return itemLista(dados.docs[index]);
                    });
            }
          }),

      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue[400],
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/inserir');
        },
      ),
    );
  }
}
