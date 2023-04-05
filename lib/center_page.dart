import 'package:flutter/material.dart';
import 'package:gestor_financeiro/widgetUtils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'crudBD.dart';
import 'despesas.dart';
import 'receita.dart';

class centerScreen extends StatefulWidget {
  const centerScreen({Key? key}) : super(key: key);

  @override
  CenterScreen createState() => CenterScreen();
}

class CenterScreen extends State<centerScreen> {

  @override
  initState() {
    listarBancos();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                    child: SfRadialGauge(
                      title: const GaugeTitle(
                          text: 'Saúde Financeira',
                          backgroundColor: Colors.lightGreenAccent,
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black, fontFamily: 'Times'),
                          alignment: GaugeAlignment.center),
                      backgroundColor: Colors.lightGreenAccent,
                      enableLoadingAnimation: true,
                      axes:<RadialAxis>[
                        RadialAxis(
                            showLabels: false,
                            showAxisLine: false,
                            showTicks: false,
                            startAngle: 180,
                            endAngle: 0,
                            minimum: 0, maximum: 99,
                            canScaleToFit: true,
                            ranges: <GaugeRange>[
                              GaugeRange(startValue: 0,
                                  endValue: 33,
                                  gradient: const SweepGradient(
                                      colors: <Color>[Color(0xFFB71C1C), Color(0xFFE53935)],
                                      stops: <double>[0.25, 0.75]),
                                  startWidth: 10,
                                  endWidth: 10
                              ),
                              GaugeRange(startValue: 33,
                                  endValue: 66,
                                  gradient: const SweepGradient(
                                      colors: <Color>[Color(0xFFF57F17), Color(0xFFFDD835)],
                                      stops: <double>[0.25, 0.75]),
                                  startWidth: 10,
                                  endWidth: 10
                              ),
                              GaugeRange(startValue: 66,
                                  endValue: 99,
                                  gradient: const SweepGradient(
                                      colors: <Color>[Color(0xFF43A047), Color(0xFF2E7D32)],
                                      stops: <double>[0.25, 0.75]),
                                  startWidth: 10,
                                  endWidth: 10
                              )
                            ],
                          pointers: const <GaugePointer>[NeedlePointer(
                            value: 20,
                            needleLength: 0.5,
                            enableAnimation: true,
                            animationDuration: 4000,
                          ),
                        ]
                        )
                      ],
                    )
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                ),
                              ),
                              child: SizedBox.expand(
                                  child: ClipOval(
                                      child: Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            splashColor: Colors.green[700],
                                            onTap: () async {
                                              await listartransacoes();
                                              if (!mounted) return;
                                              if(await temReceita()) {
                                                Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => const receita()));
                                              } else {
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Você ainda não tem receitas adicionadas.'),
                                                    content: const Text('Adicione uma receita no botão inferior.'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.monetization_on_sharp,
                                                  size: 35,
                                                  color: Colors.green[700],
                                                ),
                                                Text(
                                                  "Receitas",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.green[700],
                                                      fontFamily: 'Raleway'),
                                                ),
                                              ],
                                            ),
                                          )))))),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.0),
                            ),
                          ),
                            child: SizedBox.expand(
                                child: ClipOval(
                                    child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colors.red[700],
                                          onTap: () async {
                                            await listartransacoes();
                                            if (!mounted) return;
                                            if(await temDespesa()) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => const despesa()));
                                            } else {
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Você ainda não tem despesas adicionadas.'),
                                                  content: const Text('Adicione uma despesa no botão inferior.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, 'OK'),
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.money_off_sharp,
                                                size: 35,
                                                color: Colors.red[700],
                                              ),
                                              Text(
                                                "Despesas",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red[700],
                                                    fontFamily: 'Raleway'),
                                              ),
                                            ],
                                          ),
                                        ))))
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
            width: double.infinity,
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
                ),
              ),
              child: ListView.builder(
                  itemCount: bancos.length,
                  itemBuilder: (context,index){
                    return bancos[index];
                  }),
            ),
          )
        ],
      ),
    );
  }
}
