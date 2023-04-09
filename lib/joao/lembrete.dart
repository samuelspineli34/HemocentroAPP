import 'package:flutter/material.dart';
import 'package:gestor_financeiro/crudBD.dart';
import 'package:gestor_financeiro/utils.dart';

class lembrete extends StatefulWidget {
  const lembrete({Key? key}) : super(key: key);

  @override
  Lembrete createState() => Lembrete();
}

class Lembrete extends State<lembrete> {

  Future<int> calcAllReceita () async {
    return await receitaDeTodosOsBancos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Container(
        height: 80,
        margin: const EdgeInsets.only(top: 5, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.lightBlueAccent,
        ),
        child: FutureBuilder<int> (
          future: calcAllReceita(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Center(
              child: ListTile(
                leading: Icon(
                  Icons.monetization_on_sharp,
                  size: 40,
                  color: Colors.green[700],
                ),
                title: Text(
                  "Receita total: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                subtitle: Text(
                  "$calcAllReceita",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            );
          }
        ),
        ),
      );
  }
}

/*
        child: Center(
          child: ListTile(
            leading: Icon(
              Icons.monetization_on_sharp,
              size: 40,
              color: Colors.green[700],
            ),
            title: Text(
              "Receita total: ",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            subtitle: Text(
              "",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            ),
          ),
 */
