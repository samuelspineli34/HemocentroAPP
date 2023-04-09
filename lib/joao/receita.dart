// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'crudBD.dart';
import 'despesas.dart';

class receita extends StatefulWidget {
  const receita({Key? key}) : super(key: key);

  @override
  Receita createState() => Receita();
}

class Receita extends State<receita> {
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receita"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: receitas.length,
            itemBuilder: (context,index){
              return receitas[index];
            }),
      ),
    );
  }
}
