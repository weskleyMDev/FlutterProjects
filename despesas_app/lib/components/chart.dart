import 'package:despesas_app/components/chart_bar.dart';
import 'package:despesas_app/model/transacao.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recenteTransacao});

  final List<Transacao> recenteTransacao;

  List<Map<String, Object>> get grupoTransacoes {
    return List.generate(7, (index) {
      final semanaDia = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSoma = 0.0;

      for (var i = 0; i < recenteTransacao.length; i++) {
        bool mesmoDia = recenteTransacao[i].date.day == semanaDia.day;
        bool mesmoMes = recenteTransacao[i].date.month == semanaDia.month;
        bool mesmoAno = recenteTransacao[i].date.year == semanaDia.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          totalSoma += recenteTransacao[i].valor;
        }
      }

      return {'dia': DateFormat.E().format(semanaDia)[0], 'valor': totalSoma};
    }).reversed.toList();
  }

  double get _semanaTotal {
    return grupoTransacoes.fold(0.0, (cont, tr) {
      return cont + (tr['valor'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    grupoTransacoes;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoTransacoes.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (tr['dia'] as String),
                (tr['valor'] as double),
                (tr['valor'] as double) / _semanaTotal,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
