import 'package:admin_fribe/blocs/logs/logs_bloc.dart';
import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/logs/enum/log_action.dart';
import 'package:admin_fribe/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<LogsBloc, LogsState, String>(
          selector: (state) => state.productId,
          builder: (context, productId) {
            return BlocSelector<ProductBloc, ProductState, String?>(
              selector: (state) => state.products
                  .where((p) => p?.id == productId)
                  .map((p) => p?.name)
                  .firstOrNull,
              builder: (context, name) {
                return Text('${name ?? 'Product'} LOGS');
              },
            );
          },
        ),
      ),
      body: BlocConsumer<LogsBloc, LogsState>(
        listenWhen: (prev, curr) =>
            prev.errorMessage != curr.errorMessage && curr.errorMessage != null,

        listener: (context, state) {
          if (state.errorMessage != null) {
            debugPrint('[LogsScreen] ${state.errorMessage}');

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },

        builder: (context, state) {
          return Column(
            children: [
              _buildActionSelector(context, state),
              const SizedBox(height: 16),
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Wrap _buildActionSelector(BuildContext context, LogsState state) {
    return Wrap(
      spacing: 8,
      children: LogAction.values.map((action) {
        final selected = state.selectedAction == action;

        return ChoiceChip(
          label: Text(action.label),
          selected: selected,
          onSelected: (_) {
            context.read<LogsBloc>().add(SelectLogAction(action));
          },
        );
      }).toList(),
    );
  }

  Widget _buildContent(LogsState state) {
    if (state.selectedAction == null) {
      return const Center(child: Text('Select an action to view logs'));
    }

    if (state.status == LogsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == LogsStatus.success && state.logs.isEmpty) {
      return const Center(child: Text('No logs found for this action'));
    }

    if (state.status == LogsStatus.success) {
      return ListView.builder(
        itemCount: state.logs.length,
        itemBuilder: (context, index) {
          final log = state.logs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              title: Text(
                '+${log.addedAmount} added',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${log.oldAmount} → ${log.newAmount}\n'
                '${DateFormat('dd/MM/yyyy HH:mm').format(log.timestamp)}',
              ),
            ),
          );
        },
      );
    }

    if (state.status == LogsStatus.failure) {
      return const Center(child: Text('Failed to load logs'));
    }

    return const SizedBox.shrink();
  }
}
