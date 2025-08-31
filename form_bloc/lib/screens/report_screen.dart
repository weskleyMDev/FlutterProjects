import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/report/report_bloc.dart';
import 'package:form_bloc/screens/loading_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ReportBloc>(context);
    final userId =
        BlocProvider.of<AuthBloc>(context).state.currentUser?.id ?? 'error';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(onPressed: () => print(userId), icon: Icon(Icons.logout)),
        ],
      ),
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state.status == ReportStatus.error) {
            _showSnackBar(state.error.toString());
          }
        },
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            final reports = state.reports;
            ReportStatus? status = state.status;
            if (reports.isEmpty) {
              status = ReportStatus.initial;
            } else {
              status = ReportStatus.success;
            }
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    TextField(
                      key: const ValueKey('reportTextField'),
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'Report',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => bloc.add(SetTextEvent(text: value)),
                      onSubmitted: (_) => _submitReport(bloc, userId),
                    ),
                    const SizedBox(height: 16),
                    if (status == ReportStatus.initial)
                      const Center(child: Text('No reports found.')),
                    if (status == ReportStatus.success)
                      ...reports.map(
                        (report) => ListTile(
                          title: Text(report.text),
                          trailing: IconButton(
                            onPressed: () =>
                                bloc.add(RemoveReportEvent(report: report)),
                            icon: Icon(Icons.delete_outline),
                          ),
                        ),
                      ),
                  ],
                ),
                if (state.status == ReportStatus.waiting)
                  Positioned.fill(child: LoadingScreen()),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submitReport(bloc, userId),
      ),
    );
  }

  void _submitReport(ReportBloc bloc, String userId) {
    bloc.add(SaveReportEvent(userId));
    _textController.clear();
  }
}
