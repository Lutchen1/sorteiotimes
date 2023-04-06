import 'package:flutter/material.dart';
import 'package:share/share.dart';

class TimesSorteados extends StatelessWidget {
  final jogadores;

  const TimesSorteados({super.key, required this.jogadores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Times Sorteados"),
      ),
      body: Table(
        border: TableBorder.all(),
        children: List.generate(jogadores.length, (index) {
          return TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('${jogadores[index]}'),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          Share.share('Conteúdo da tabela aqui'),
        },
        tooltip: 'Compartilhar',
        child: const Icon(Icons.share),
      ),/// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}