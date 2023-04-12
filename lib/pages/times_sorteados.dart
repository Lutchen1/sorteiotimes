import 'package:flutter/material.dart';
import 'package:share/share.dart';

class TimesSorteados extends StatelessWidget {
  final times;

  const TimesSorteados({super.key, required this.times});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Times Sorteados"),
      ),
        body:Center(
          child:Padding(
            padding: const EdgeInsets.fromLTRB(16,16,16,80),
              child:SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Table(          
              border: TableBorder.all(),
              children: List.generate(times.length, (index) {
                return TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('${times[index]}'),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
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