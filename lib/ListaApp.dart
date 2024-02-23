import 'package:lista_mercado/ListaController.dart';
import 'package:lista_mercado/ListaView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a TarefasScreen e utilizando o Provider
      home: ChangeNotifierProvider(
        create: (context) => ListaController(),
        child: listaScreen(),
      ),
    );
  }
}