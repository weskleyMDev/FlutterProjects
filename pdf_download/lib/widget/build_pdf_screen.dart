import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_download/bloc/pdf_generator_bloc.dart';

class BuildPdfScreen extends StatelessWidget {
  const BuildPdfScreen({super.key, required this.state});

  final PdfGeneratorState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pressione o botão para gerar um PDF.'),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    context.read<PdfGeneratorBloc>().add(
                      GeneratePdfEvent(fileName: 'sample.pdf'),
                    );
                  },
                  child: Text('Gerar PDF'),
                ),
              ),
            ],
          ),
        ),
        if (state.status == PdfGeneratorStatus.generating)
          Container(
            color: Colors.black87,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
