// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'crudBD.dart';

class despesa extends StatefulWidget {
  const despesa({Key? key}) : super(key: key);

  @override
  Despesas createState() => Despesas();
}

class Despesas extends State<despesa> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receita"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: despesas.length,
            itemBuilder: (context,index){
              return despesas[index];
            }),
      ),
    );
  }
}