import 'package:flutter/material.dart';

class PaginaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFFFF),
     body: Container(
            padding: EdgeInsets.only(top: 60, left: 40, right: 40),
             child: Column(
              children: [
                Container(
                  color: Color(0xFF8FAADC),
                  height: 50,
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text("Sobre o aplicativo...",
                                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black)),
                  ),
                ),
          Expanded(
            child: Container(
              color: Color(0xFFFFF),
              child: ListView(
                  children: <Widget>[
                   Container(
                      width: 200,
                      height: 300,
                      margin: EdgeInsets.all(20),
                      color: Color(0xFFFFF),
                      child: Row(children: [
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Image.asset("assets/images/dev.jpg"),)
                        ),
                        Expanded(
                          child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Sobre o projeto: Projeto desenvolvido para a disciplina de PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS.\n"
                                "\nObjetivo: O objetivo do aplicativo é auxiliar os seus usuários organizando em um lista suas tarefas diarias ou semanal\n"
                                "\nDesenvolvido por: Bruno William de Souza Camargo"
                                "\nProfessor: Rodrigo de Oliveria Plotze"
                                "\nhttps://github.com/BrunoCamargo-100/P1-Flutter-ADS.git",
                                style: TextStyle(fontSize: 12, color: Colors.black)),
                              ]),
                        )),
                      ]),
              )]))),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: SizedBox(
                          width: 50,
                          height: 30,
                          child: Center(child: Text('Início'))),
                        onPressed: () {
                        Navigator.pop(context);
                        },
                      ),
                        ElevatedButton(
                          child: SizedBox(
                          width: 50,
                          height: 30,
                            child: Center(child: Text('Login'))),
                              onPressed: () {
                              Navigator.pushNamed(context, '/login');
                              },
              )])]))])));         
  }
}