import 'package:go_router/go_router.dart';
import 'package:localdb/models/todo_model.dart';
import 'package:localdb/screens/edit_todo_screen.dart';
import 'package:localdb/screens/home_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/edit-todo',
      name: 'edit-todo',
      builder: (context, state) {
        final todo = state.extra as TodoModel?;
        return EditTodoScreen(initialTodo: todo);
      },
    ),
  ],
);
