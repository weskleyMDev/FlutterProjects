import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localdb/blocs/sync_todos/sync_todos_bloc.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/models/todo_model.dart';
import 'package:localdb/widgets/build_todos_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoViewBloc = BlocProvider.of<TodoViewBloc>(context);
    final syncTodosBloc = BlocProvider.of<SyncTodosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          BlocSelector<SyncTodosBloc, SyncTodosState, int>(
            selector: (state) => state.syncedCount,
            builder: (context, syncedCount) {
              final syncState = syncTodosBloc.state;
              return Badge(
                label: Text('$syncedCount'),
                isLabelVisible: syncedCount > 0,
                child: IconButton(
                  onPressed: syncState.isSyncing
                      ? null
                      : () => syncTodosBloc.add(const StartSyncTodosEvent()),
                  icon: const Icon(Icons.cloud_upload_sharp),
                ),
              );
            },
          ),
          BlocSelector<TodoViewBloc, TodoViewState, List<TodoModel>>(
            selector: (state) => state.todos,
            builder: (context, todos) {
              return IconButton(
                icon: Icon(
                  todos.isNotEmpty
                      ? Icons.sync_sharp
                      : Icons.cloud_download_sharp,
                ),
                onPressed: () => todoViewBloc.add(const LoadTodoViewEvent()),
                tooltip: todos.isNotEmpty ? 'Reload Todos' : 'Load Todos',
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      body: BlocConsumer<SyncTodosBloc, SyncTodosState>(
        listener: (context, state) =>
            _handleSyncStatus(context, syncTodosBloc, state),
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: BlocBuilder<TodoViewBloc, TodoViewState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status ||
                          previous.todos != current.todos,
                      builder: (_, todoViewState) {
                        return BuildTodosView(todoViewState: todoViewState);
                      },
                    ),
                  ),
                ],
              ),
              if (state.status == SyncTodosStatus.syncing)
                Container(
                  color: Colors.black54,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('edit-todo'),
        child: Icon(Icons.add),
      ),
    );
  }

  void _handleSyncStatus(
    BuildContext context,
    SyncTodosBloc bloc,
    SyncTodosState state,
  ) {
    final messages = {
      SyncTodosStatus.success: 'Todos synchronized successfully.',
      SyncTodosStatus.partial: 'Some todos failed to synchronize.',
      SyncTodosStatus.failure: 'Failed to synchronize todos.',
    };
    final message = state.snackMessage ?? messages[state.status];
    if (message != null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
    if (state.status != SyncTodosStatus.syncing) {
      Future.delayed(const Duration(seconds: 2), () {
        bloc.add(const ResetSyncTodosStateEvent());
        bloc.add(const GetSyncedCountEvent());
      });
    }
  }
}
