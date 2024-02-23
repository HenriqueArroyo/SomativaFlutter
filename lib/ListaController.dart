import 'package:lista_mercado/ListaModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaController extends ChangeNotifier {
  // Lista de lista
  List<Lista> _lista = [];
  // Getter para acessar a lista de lista
  List<Lista> get lista => _lista;


// Método para adicionar um novo item à lista
void adicionarItem(BuildContext context, String descricao) {
  if (descricao.trim().isNotEmpty) {
    bool tarefaDuplicada =
        _lista.any((tarefa) => tarefa.descricao == descricao);

    if (!tarefaDuplicada) {
      _lista.add(Lista(descricao, false));
      notifyListeners();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Tarefa duplicada'),
          content: Text('A tarefa "$descricao" já existe na lista.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } else {
    final snackBar = SnackBar(
      content: Text('O campo está vazio!'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



  // Método para marcar um item como concluída com base no índice
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _lista.length) {
      _lista[indice].concluida = true;
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para excluir um item com base no índice
  void excluirItem(int indice) {
    if (indice >= 0 && indice < _lista.length) {
      _lista.removeAt(indice);
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para renomear um item
void renomearItem(int indice, String novoNome) {
  if (indice >= 0 && indice < _lista.length) {
    _lista[indice].descricao = novoNome;
    
    notifyListeners();
  }
}
void ordenarLista(String criterio) {
    switch (criterio) {
      case 'descricao':
        _lista.sort((a, b) => a.descricao.compareTo(b.descricao));
        break;
      // Você pode adicionar mais casos para outros critérios de ordenação, se necessário
      default:
        break;
    }
    // Notifica os ouvintes sobre a mudança no estado
    notifyListeners();
  }
}
