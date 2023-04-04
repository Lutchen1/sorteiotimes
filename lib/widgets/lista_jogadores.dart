import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sorteiotimes/pages/myhomepage.dart';

class ListJogadores extends StatelessWidget {
  const ListJogadores({super.key, required this.jogador, required this.onDelete});

  final String jogador;
  final Function (String jogador) onDelete;

  @override
  Widget build(BuildContext context) {
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
            color: Color.fromARGB(255, 236, 234, 234),        
          ),    
          padding: const EdgeInsets.all(8),        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(jogador,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )
              ),
            ], 
          ),
        )
      )
    );
  }
}