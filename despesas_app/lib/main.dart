import 'dart:math';

import 'package:despesas_app/components/chart.dart';
import 'package:despesas_app/components/transacao_form.dart';
import 'package:despesas_app/components/transacao_lista.dart';
import 'package:despesas_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../model/transacao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _mostrarChart = false;
  final List<Transacao> _transacoes = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  List<Transacao> get _recenteTransacao {
    return _transacoes.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransacao(String titulo, double valor, DateTime date) {
    final newTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      date: date,
    );

    setState(() {
      _transacoes.add(newTransacao);
    });

    Navigator.of(context).pop();
  }

  _deleteTransacao(String id) {
    setState(() {
      _transacoes.removeWhere((tr) => tr.id == id);
    });
  }

  _abrirTransacaoFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransacaoForm(_addTransacao);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        capitalizeWords('despesas app flutter'),
        style: TextStyle(
          fontSize: mediaQuery.textScaler.scale(20),
        ),
      ),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _mostrarChart = !_mostrarChart;
              });
            },
            icon: Icon(_mostrarChart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () {
            _abrirTransacaoFormModal(context);
          },
          icon: const Icon(Icons.add),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final alturaResp = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_mostrarChart || !isLandscape)
              SizedBox(
                height: alturaResp * (isLandscape ? 0.7 : 0.3),
                child: Chart(recenteTransacao: _recenteTransacao),
              ),
            if (!_mostrarChart || !isLandscape)
              SizedBox(
                height: alturaResp * 0.58,
                child: TransacaoLista(_transacoes, _deleteTransacao),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirTransacaoFormModal(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
