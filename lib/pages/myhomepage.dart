//import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:sorteiotimes/pages/times_sorteados.dart';
import 'package:sorteiotimes/widgets/lista_jogadores.dart';
//import 'package:flutter/src/services/hardware_keyboard.dart'


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController jogadoresController = TextEditingController();  
  
  List<String> jogadores = [];
  String? jogadorDeletado;
  int?posJogadorDeletado;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String text;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      // ignore: prefer_const_constructors
      body:Center(
        child:Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Row(
              children: [
                Expanded(
                  flex: 3,
                    child: TextField(
                      controller: jogadoresController,
                      decoration: const InputDecoration(
                        labelText: "Jogadores",
                        hintText: "Nome do perna de pau",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => {
                      text = jogadoresController.text,
                      setState(() {
                        if (text != ''){
                          jogadores.add(text);                                           
                        };
                        jogadoresController.clear();     
                      }),            
                    }, 
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24)
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      size: 20,
                    ),                                   
                  ),
                ],    
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                shrinkWrap: true,
                  children: [
                    for(String jogador in jogadores)
                      ListJogadores(
                        jogador: jogador,
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),  
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          Navigator.push(context,
           MaterialPageRoute(builder: (context)=>TimesSorteados(jogadores: jogadores,))),
        },
        tooltip: 'Sortear Equipes',
        child: const Icon(Icons.sports_soccer_sharp),
      ),/// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onDelete(jogador){
    
    jogadorDeletado = jogador;
    posJogadorDeletado = jogadores.indexOf(jogador);

    setState(() {
      jogadores.remove(jogador);
    });    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'jogador ${jogador} foi removido com sucesso!',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,    
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed:() {
            setState(() {
              jogadores.insert(posJogadorDeletado!,jogadorDeletado!);
            });
          },
        ),  
      ),
    );

  }

}
