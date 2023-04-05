import 'package:flutter/material.dart';
import 'package:gestor_financeiro/crudBD.dart';
import 'lembrete.dart';

/// Função que estiliza o Drawer do menu principal,
/// Estilizar cores e adicionar funcionalidades posteriormente.
class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer (
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 35,
            ),
          ),
        ),
        ListTile(
          leading: TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const lembrete()));
            },
            style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 25, fontFamily: 'Times'),),
            icon: const Icon(Icons.analytics_sharp, size: 40.0,),
            label: const Text('Análise Receitas'),
          ),
        ),
      ],
    ));
  }
}

/// Função que estilizar a AppBar principal do aplicativo.
/// Rever palheta de cores no futuro.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightGreenAccent,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          iconSize: 35,
          color: Colors.black,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
