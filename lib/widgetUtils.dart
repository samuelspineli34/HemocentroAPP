import 'package:flutter/material.dart';

import 'crudBD.dart';

Widget receitaWidget(String id, String x, String y, String date) {
  return Container(
    height: 80,
    margin: const EdgeInsets.only(top: 5, left: 8, right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[400],
    ),
    child: Center(
      child: ListTile(
        leading: Icon(
          Icons.monetization_on_sharp,
          size: 40,
          color: Colors.green[700],
        ),
        title: Text(
          "Data: " + "$date",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          "Valor: " + "$x" + " Banco: " + "$y",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            removerReceita(id);
            receitas.removeWhere((id) => true);
          },
          icon: const Icon(
            Icons.delete_forever,
            size: 40,
          ),
        ),
      ),
    ),
  );
}

Widget despesaWidget(String id, String x, String y, String z, String date) {
  return Container(
    height: 80,
    margin: const EdgeInsets.only(top: 5, left: 8, right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[400],
    ),
    child: Center(
      child: ListTile(
        leading: Icon(
          Icons.money_off_sharp,
          size: 40,
          color: Colors.red[700],
        ),
        title: Text(
          "Data: " + "$date",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          "Valor: " + "$x" + " Banco: " + "$y",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            removerDespesa(id);
            despesas.removeWhere((id) => true);
          },
          icon: const Icon(
            Icons.delete_forever,
            size: 40,
          ),
        ),
      ),
    ),
  );
}

Widget bancoWidget(String id, String nome) {
  return Container(
    height: 80,
    margin: const EdgeInsets.only(top: 5, left: 8, right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[400],
    ),
    child: Center(
      child: ListTile(
        leading: const Icon(
          Icons.corporate_fare_outlined,
          size: 40,
          color: Colors.black,
        ),
        title: Text(
          "ID: " + "$id",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          "Nome: " + "$nome",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ),
    ),
  );
}