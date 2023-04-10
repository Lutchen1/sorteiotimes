import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteiotimes/pages/myhomepage.dart';
import 'package:sorteiotimes/widgets/estrela_niveis.dart';

class ListJogadores extends StatelessWidget {
  const ListJogadores({super.key, required this.index, required this.jogador, required this.nivel, required this.onDelete});

  final int index;
  final String jogador;
  final Function (String jogador) onDelete;
  final int nivel;

  @override
  Widget build(BuildContext context) {
    var onRatingSelected;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),       
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
              Text((index+1).toString()+'. '+jogador,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,                  
                )                                
              ),
              EstrelaNiveis(onRatingSelected: ( nivel ) { },),              
            ], 
          ),          
        ),
      ),      
    );
  }
}