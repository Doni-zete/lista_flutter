import 'package:flutter/material.dart';
import 'package:p1_flutter/6_adicionar_firebase_lista.dart';

import '1_InicialPage.dart';
import '2_login.dart';
import '3_cadastro.dart';
import '4_listagem.dart';
import '5_sobre.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ToDoList',
    initialRoute: '/inicial',
    routes: {
      '/inicial': (context) => InicialPage(),
      '/login': (context) => Loginpagina(),
      '/cadastro': (context) => CriarContaPage(),
      '/lista': (context) => AdiconarLista(),
      '/sobre': (context) => PaginaSobre(),
      '/inserir': (context) => InserirDocumentoPage(),

    },
  ));
}
