// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:gestor_financeiro/widgetUtils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

/// Metodo para criar o banco de dados e três tabelas.
/// Tabela bancos -> nome.
/// Tabela transações -> valor das transações, id banco e tipo.
recuperarBancoDados() async {
  final caminhoBancoDados = await getDatabasesPath();
  final localBancoDados = join(caminhoBancoDados, "newbd3");
  var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente){
        db.execute("CREATE TABLE IF NOT EXISTS cadBancos (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR); ");
        db.execute("CREATE TABLE IF NOT EXISTS transacoes (id INTEGER PRIMARY KEY AUTOINCREMENT,date VARCHAR, value INTEGER NOT NULL, bancoId INTEGER NOT NULL, type VARCHAR, FOREIGN KEY(bancoId) REFERENCES cadBancos(id)); ");
      }
  );
  return bd;
}

salvarDadosBanco(String name) async{
  Database bd = await recuperarBancoDados();
  Map<String, dynamic> dadosBancos = {
    "name" : name,
  };

  bd.insert("cadBancos", dadosBancos);
}

/// Salvar uma transação feita pelo usuario no banco de dados.
salvarDadosTransacao(int value, int bancoId, String type, bool despesa) async {
  Database bd = await recuperarBancoDados();
  if(despesa) value *= -1;
  if(!despesa) type = '0';
  Map<String, dynamic> dadosTransacao = {
    "value" : value,
    "bancoId" : bancoId,
    //"date" : DateTime.now().toString(),
    "date" : (DateFormat('dd-MM-yyyy').format(DateTime.now())).toString(),
    "type": type
  };
  bd.insert("transacoes", dadosTransacao);
}

Future<bool> temBanco() async{

  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT count(*) FROM cadBancos");

  if((receita[0]['count(*)']) == 0) return false;

  return true;
}

Future<bool> temBancoNome(String name) async{

  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT count(*) FROM cadBancos WHERE name="+name+";");

  if((receita[0]['count(*)']) == 0) return false;

  return true;
}

List<Widget> bancos = [];

/// Listar bancos presentes no sistema *metodo apenas para testes*
listarBancos() async{
  Database bd = await recuperarBancoDados();
  List userData = await bd.rawQuery("SELECT * FROM cadBancos"); //conseguimos escrever a query que quisermos
  for(var usu in userData){
    print(" id: "+usu['id'].toString() +
        " name: "+usu['name']);
  }

  bancos.clear();

  if(await temBanco()) {
    for(var usu in userData) {
      bancos.add(bancoWidget(usu['id'].toString(), usu['name'].toString()));
    }
  }
}

/// Verificar se existem receitas na tabela.
Future<bool> temReceita() async{

  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT count(*) FROM transacoes WHERE type='0';");

  if((receita[0]['count(*)']) == 0) return false;

  return true;
}

Future<bool> temDespesa() async{

  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT count(*) FROM transacoes WHERE type!='0';");

  if((receita[0]['count(*)']) == 0) return false;

  return true;
}

removerBanco(String id) async{

  Database bd = await recuperarBancoDados();
  bd.rawQuery("DELETE FROM cadBancos WHERE id="+id+";");
}

removerReceita(String id) async{

  Database bd = await recuperarBancoDados();
  bd.rawQuery("DELETE FROM transacoes WHERE type='0' AND id="+id+";");
}

removerDespesa(String id) async{

  Database bd = await recuperarBancoDados();
  bd.rawQuery("DELETE FROM transacoes WHERE type!='0' AND id="+id+";");
}

List<Widget> receitas = [];
List<Widget> despesas = [];

/// Listar transações feitas no sistema *metodo apenas para testes*
listartransacoes() async{
  Database bd = await recuperarBancoDados();
  List userData = await bd.rawQuery("SELECT * FROM transacoes"); //conseguimos escrever a query que quisermos
  for(var usu in userData) {
    print(" id: " + usu['id'].toString() +
        " value: " + usu['value'].toString() +
        " date: " + usu['date'].toString() +
        " bancoId: " + usu['bancoId'].toString() +
        " type: " + usu['type']);
  }

  receitas.clear();
  despesas.clear();

  if(await temReceita()) {
    for(var usu in userData) {
      if(usu['value'] > 0) {
          receitas.add(receitaWidget(usu['id'].toString(), usu['value'].toString(), usu[('bancoId')].toString(), usu[('date')]));
      }
    }
  }

  if(await temDespesa()) {
    for(var usu in userData) {
      if(usu['value'] < 0) {
        despesas.add(despesaWidget(usu['id'].toString(), usu['value'].toString(), usu[('bancoId')].toString(), usu[('type')] , usu[('date')]));
      }
    }
  }
}

// Metodo para recuperar a receita de um determinado banco
Future<int> receitaDoBanco(int bancoId) async{
  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT SUM(value) FROM transacoes WHERE type='0' AND bancoId="+bancoId.toString()+";");
  //não sei se o valor userId.toString transforma o 0 para um '0' ou "0", então caso der error tentar conserta ou checar essa possibilidade

  return receita[0]['SUM(value)'];
  //coloquei o valor SUM(value) porque na criação da lista ele é o parametro mais provavel, se não der certo tenta com '0'
}

// Metodo para recuperar a receita de todos os bancos
Future<int> receitaDeTodosOsBancos() async{
  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT SUM(value) FROM transacoes WHERE type='0';");

  return receita[0]['SUM(value)'];
  //coloquei o valor SUM(value) porque na criação da lista ele é o parametro mais provavel, se não der certo tenta com '0'
}

/// Metodo para recuperar despesas do usuario para um determinado banco
Future<int> despesaDoBanco(int bancoId) async{
  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT SUM(value) FROM transacoes WHERE type!='0' AND bancoId="+bancoId.toString()+";");

  return receita[0]['SUM(value)'];
  //coloquei o valor SUM(value) porque na criação da lista ele é o parametro mais provavel, se não der certo tenta com '0'
}

/// Metodo para recuperar despesas do usuario para todos os banco
Future<int> despesaDeTodosOsBancos() async{
  Database bd = await recuperarBancoDados();
  List receita = await bd.rawQuery("SELECT SUM(value) FROM transacoes WHERE type!='0';");

  //print("Despesas:\n");
  //print(receita);
  return receita[0]['SUM(value)'];
  //coloquei o valor SUM(value) porque na criação da lista ele é o parametro mais provavel, se não der certo tenta com '0'
}