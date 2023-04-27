import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteiotimes/widgets/estrela_niveis.dart';
import '../models/jogadores.dart';

class ListJogadores extends StatelessWidget {
  const ListJogadores({super.key, required this.jogador, required this.onDelete/*, required this.index, required this.jogador, required this.nivel, required this.onDelete*/});

  final Jogador jogador;
  //final int index;
  //final String jogador;
  final Function (Jogador) onDelete;
  //final int nivel;

  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),       
      child: Slidable(        
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (context) {
                onDelete(jogador);
              },
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 236, 234, 234),        
          ),    
          padding: const EdgeInsets.all(8),        
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: prefer_interpolation_to_compose_strings
              Text(/*(jogador.nome.indexOf(jogador.nome)+1).toString()+'. '+*/jogador.nome,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,                  
                )                                
              ),
              // ignore: avoid_types_as_parameter_names
              EstrelaNiveis(onRatingSelected: (int ) {  },jogador: jogador),              
            ], 
          ),          
        ),
      ),      
    );
  }
}