import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_download/bloc/pdf_generator_bloc.dart';
import 'package:pdf_download/widget/build_pdf_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PdfGeneratorBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const PdfGeneratorScreen(),
      ),
    );
  }
}

class PdfGeneratorScreen extends StatelessWidget {
  const PdfGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerador de PDF')),
      body: BlocConsumer<PdfGeneratorBloc, PdfGeneratorState>(
        listener: (context, state) {
          if (state.status == PdfGeneratorStatus.success) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(content: Text('PDF gerado com sucesso!')),
              );
          } else if (state.status == PdfGeneratorStatus.failure) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(content: Text('Falha ao gerar o PDF.')));
          }
        },
        builder: (context, state) {
          return BuildPdfScreen(state: state);
        },
      ),
    );
  }
}
