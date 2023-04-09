import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'center_page.dart';
import 'crudBD.dart';
import 'receita.dart';

class AddInstanceButton extends StatelessWidget {
  const AddInstanceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 110.0,
      children: [
        ActionButton(
          onPressed: () => _receita(context, 0),
          icon: const Icon(Icons.attach_money_sharp, color: Colors.black),
        ),
        ActionButton(
          onPressed: () => _banco(context, 1),
          icon: const Icon(Icons.corporate_fare_sharp, color: Colors.black),
        ),
        ActionButton(
          onPressed: () => _despesa(context, 2),
          icon: const Icon(Icons.money_off_sharp, color: Colors.black),
        ),
      ],
    );
  }

  //Método para o formulário de inserção no banco de dados
  void _receita(BuildContext context, int index) {
    TextEditingController valor = TextEditingController();
    TextEditingController banco = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Row(
            children: [
              const Text("Receita"),
              const Spacer(),
              InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: valor,
                      keyboardType: TextInputType.number, //restringir o tipo de teclado do usuario: number, phone, text
                      decoration: const InputDecoration(
                        icon: Icon(Icons.attach_money),
                        hintText: 'Valor',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: banco,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.corporate_fare_outlined),
                        hintText: 'Digite o nome',
                        labelText: 'Banco',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        child: const Text("Submit"),
                        onPressed: () async {
                          await salvarDadosTransacao(int.parse(valor.text), int.parse(banco.text), "", false);
                          print("------ Receita de Todos os Bancos ------");
                          print(await receitaDeTodosOsBancos());
                          //print("\n\nSaldo Total:\n");
                          //int walker = await receitaDeTodosOsBancos();
                          //int walker2 = await despesaDeTodosOsBancos();
                          //int walker3 = walker + walker2;
                          //print(walker3);
                        }),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _banco(BuildContext context, int index) {
    TextEditingController banco = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Row(
            children: [
              const Text("Banco"),
              const Spacer(),
              InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: banco,
                      keyboardType: TextInputType.text, //restringir o tipo de teclado do usuario: number, phone, text
                      decoration: const InputDecoration(
                        icon: Icon(Icons.corporate_fare_outlined),
                        hintText: 'Digite o nome',
                        labelText: 'Banco',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        child: const Text("Submit"),
                        onPressed: () async {
                          await salvarDadosBanco(banco.text);
                          await listarBancos();
                          CenterScreen().initState();
                          await listartransacoes();
                        }),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _despesa(BuildContext context, int index) {
    TextEditingController valor = TextEditingController();
    TextEditingController tipo = TextEditingController();
    TextEditingController banco = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Row(
              children: [
                const Text("Despesa"),
                const Spacer(),
                InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: valor,
                        keyboardType: TextInputType.number, //restringir o tipo de teclado do usuario: number, phone, text
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money_off),
                          hintText: 'Valor',
                        ),
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly], //restringir o user de digitar qualquer coisa além de números
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: tipo,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.article_outlined),
                            hintText: 'Descrição',
                          ),
                        ),
                      ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: banco,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.corporate_fare_outlined),
                            hintText: 'Digite o nome',
                            labelText: 'Banco',
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                          child: const Text("Submit"),
                          onPressed: () async {
                            await salvarDadosTransacao(int.parse(valor.text), int.parse(banco.text), tipo.text, true);
                            print("------ Listando Transacoes ------");
                            await listartransacoes();
                            print("------ Receita de Todos os Bancos ------");
                            print(await receitaDeTodosOsBancos());
                            print("------ Despesa de Todos os Bancos ------");
                            print(await despesaDeTodosOsBancos());
                          }),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //controlando a abertura do botão
  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment:
        Alignment.bottomCenter, //controla a posicao do botao de expansao.
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 50.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1); //espaçamento entre os children
    for (var i = 0, angleInDegrees = 45.0; //muda o angulo dos children. '90' inverterá as posiçoes '45' deixará eles na horizontal
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: Colors.lightGreenAccent,
            child: const Icon(Icons.add_circle_outlined),
          ),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0), //controla o espaçamento entre botões (???)
          progress.value * maxDistance,
        );
        return Positioned(
          right: (MediaQuery.of(context).size.width / 2) - 24 + offset.dx, //controla a posição x dos filhos do botao de expansão, coloque left, right ou width
          //com esse offset.dx podemos controlar a posicao dos childs. coloque ele negativo e os childs vão inverter
          bottom: -10.0 + offset.dy, //controla a posição y dos filhos do botao de expansão,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 1, //controla o angulo dos icones dos childs
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}