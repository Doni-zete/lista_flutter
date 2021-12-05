import 'package:flutter/material.dart';

class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  _InicialPageState createState() => _InicialPageState();

}

class  _InicialPageState extends State<InicialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFF),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 128,
              child: Image.asset("assets/images/logoTelaInicial.png"),
            ),
            Container(
                color: Color(0xFF000),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(30),
                alignment: Alignment.topCenter,
                child: Text("Lista de Tarefas...",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black))),
            Container(
                child: Column(children: [
              ElevatedButton(
                child: Text('Entrar no Aplicativo'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Sobre o Desenvolvedor'),
                onPressed: () {
                  Navigator.pushNamed(context, '/sobre');
                },
              )
            ])),
          ],
        ),
      ),
    );
  }
}
