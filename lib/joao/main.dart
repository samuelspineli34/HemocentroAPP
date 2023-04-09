import 'package:flutter/material.dart';
import 'center_page.dart';
import 'crudBD.dart';
import 'utils.dart';
import 'add_instance_button.dart';

void main() {
  runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));
}

/// Função que roda a home na main, esse widget deve ser stateful já que
/// o estado muda nas páginas de user e homepage.
class MyApp extends StatefulWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  HomePage createState() => HomePage(); // Estado da primeira Página (Home Page do aplicativo).
}

// Página Inicial, appbar, menu, user, bottombar.
class HomePage extends State<MyApp> {

  @override
  initState() {
    listarBancos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: NavigationDrawerWidget(), // função que chama o drawer estilizado.
      appBar: DefaultAppBar(), // função que chama a appBar estilizada.
      body: centerScreen(), // função que retorna o pageview e as páginas listadas
      floatingActionButton: AddInstanceButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}