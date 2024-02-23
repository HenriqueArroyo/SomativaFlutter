import 'package:lista_mercado/ListaController.dart';
import 'package:flutter/material.dart';
import 'package:lista_mercado/ListaModel.dart';
import 'package:provider/provider.dart';

class listaScreen extends StatelessWidget {
  // Controlador para o campo de texto de nova tarefa
  final TextEditingController _controller = TextEditingController();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: [
          // Botão para ordenar a lista de tarefas por descrição
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              Provider.of<ListaController>(context, listen: false)
                  .ordenarLista('descricao');
            },
          ),
        ],
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Campo de texto para adicionar nova tarefa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Novo Item',
                // Ícone para adicionar item ao pressionar o botão
                suffixIcon: IconButton(
                  onPressed: () {
                    Provider.of<ListaController>(context, listen: false)
                        .adicionarItem(context, _controller.text);
                    _controller.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          // Lista de lista usando um Consumer do Provider para atualização automática
          Expanded(
            child: Consumer<ListaController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.lista.length,
                  itemBuilder: (context, index) {
                    final Lista item = model.lista[index];
                    return ListTile(
                      // Exibição do texto da tarefa
                      title: Text(
                        item.descricao,
                        style: TextStyle(
                          decoration: item.concluida
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Botão para marcar a tarefa como concluída
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              model.marcarComoConcluida(index);
                            },
                          ),
                          // Botão para excluir a tarefa
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              model.excluirItem(index);
                            },
                          ),
                          // Botão para editar o nome da tarefa
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final TextEditingController _editController =
                                      TextEditingController();
                                  _editController.text = item.descricao;
                                  return AlertDialog(
                                    title: Text('Editar Item'),
                                    content: TextField(
                                      controller: _editController,
                                      decoration: InputDecoration(
                                        labelText: 'Novo Nome',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          model.renomearItem(
                                              index, _editController.text);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Editar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}