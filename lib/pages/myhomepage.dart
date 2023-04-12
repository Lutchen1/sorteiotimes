//import 'dart:js_util';
//import 'dart:js_util';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorteiotimes/models/jogadores.dart';
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
  final TextEditingController equipesController = TextEditingController(); 
  
  List<Jogador> jogadores = [];
  Jogador? jogadorDeletado;
  int?posJogadorDeletado;
  List<Jogador>? jogadoresDeletados;
 

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String text;
    

    int qtdEquipes = 0;
    //List<String> equipes = [];
    List<String> times = [];   
    int nivel = 0;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),   
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),   
            onPressed: ()=>{
              setState(() {
                onDeleteAll();
              }),              
            },
          ), 
                              
        ],     
      ),

      // ignore: prefer_const_constructors
      body:Center(
        child:Padding(
          padding: const EdgeInsets.fromLTRB(16,16,16,80),
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
                        labelText: "Jogador",
                        hintText: "Perna de pau",
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
                          
                          Jogador newJogador = Jogador(
                            nome: text , 
                            nivel: 0,
                          );
                          jogadores.add(newJogador); 

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
              const SizedBox(height: 8),
              Row(
              children: [
                Expanded(
                  flex: 3,
                    child: TextField(
                      controller: equipesController,
                      decoration: const InputDecoration(
                        labelText: "Equipes",
                        hintText: "Quantidade de equipes",                        
                        //border: OutlineInputBorder(),                        
                      ),
                      keyboardType: TextInputType.number,                      
                    ),
                  ),
                  const SizedBox(width: 8),                
                ],    
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                shrinkWrap: true,
                  children: [
                    for(Jogador jogador in jogadores)
                      ListJogadores(
                        jogador:jogador,
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

          if (equipesController.text.isNotEmpty) {

            qtdEquipes = int.tryParse(equipesController.text)!,

            if (qtdEquipes > 1){
          
              times = separarTimes(jogadores,qtdEquipes,),

              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>TimesSorteados(times: times,))),
            }
            else{
              _showDialog("Atencao","deve-se informar quantidade de equipes maior do que 1!"),
            }
          }   
          else{
            _showDialog("Atencao","deve-se informar o campo quantidade de equipes!"),
          } 
        },
        tooltip: 'Sortear Equipes',
        child: const Icon(Icons.sports_soccer_sharp),
      ),/// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onDelete(Jogador jogador){
    
    jogadorDeletado = jogador;
    posJogadorDeletado = jogadores.indexOf(jogador);

    setState(() {
      jogadores.remove(jogador);
    });    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'jogador ${jogador.nome} foi removido com sucesso!',
          style: const TextStyle(color: Colors.blue),
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

  void onDeleteAll(){

    
    if (jogadores.isNotEmpty){
      
      jogadoresDeletados = jogadores;
      //jogadores = [];

      jogadores.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'jogadores foram removidos com sucesso!',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,  
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed:() {
              setState(() {
                jogadores = jogadoresDeletados!;
              });
            },
          ),
        ),
      );

    }else{
      _showDialog("Atencao","Nao existe nenhum jogador adicionado na lista para ser excluido!");
    }
    

  }

  void _showDialog(String ctit,String cmsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(ctit),
          content: Text(cmsg),
            actions: <Widget>[
              // define os botões na base do dialogo
              TextButton (
                child: const Text("Fechar"),
                onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<String> separarTimes(List<Jogador> jogadores, int numTimes) {

    List<String> times = [];
    List<Jogador> jogNv0 = [];
    List<Jogador> jogNv1 = [];
    List<Jogador> jogNv2 = [];
    List<Jogador> jogNv3 = [];
    List<Jogador> jogNv4 = [];
    List<Jogador> jogNv5 = [];
    //final numJogadoresPorTime = (jogadores.length / numTimes).ceil();
    final random = Random();

    for (var i = 0; i < jogadores.length; i++){
        if (jogadores[i].nivel == 0) {
          jogNv0.add(jogadores[i]);
        }else if(jogadores[i].nivel == 1) {
          jogNv1.add(jogadores[i]);
        }else if(jogadores[i].nivel == 2){
          jogNv2.add(jogadores[i]);
        }else if(jogadores[i].nivel == 3){
          jogNv3.add(jogadores[i]);
        }else if(jogadores[i].nivel == 4){
          jogNv4.add(jogadores[i]);
        }else if(jogadores[i].nivel == 5){
          jogNv5.add(jogadores[i]);
        }
    }


    //jogadores.shuffle(random);
    jogNv0.shuffle(random);
    jogNv1.shuffle(random);
    jogNv2.shuffle(random);
    jogNv3.shuffle(random);
    jogNv4.shuffle(random);
    jogNv5.shuffle(random);


    final timesAux = List.generate(numTimes, (_) => <String>[]);

    for (var i = 0; i < jogNv0.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv0[i].nome);
    }

    for (var i = 0; i < jogNv1.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv1[i].nome);
    }

    for (var i = 0; i < jogNv2.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv2[i].nome);
    }

    for (var i = 0; i < jogNv3.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv3[i].nome);
    }

    for (var i = 0; i < jogNv4.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv4[i].nome);
    }

    for (var i = 0; i < jogNv5.length; i++) {
      final timeIndex = i % numTimes;
      timesAux[timeIndex].add(jogNv5[i].nome);
    }                

    for (var i = 0; i < timesAux.length; i++){
      
      times.add('EQUIPE ${i+1}');
      for (var j = 0; j < timesAux[i].length; j++){
        times.add(timesAux[i][j]);
      }  
    }
    return times;
  }



}