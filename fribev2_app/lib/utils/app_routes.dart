import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/login_home.dart';
import '../models/product.dart';
import '../pages/receipt/receipt_home.dart';
import '../pages/sales/sales_home_page.dart';
import '../pages/stock/stock_category_page.dart';
import '../pages/stock/stock_home_page.dart';
import '../pages/stock_form_page.dart';
import '../stores/auth.store.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginOrHome()),
    GoRoute(
      path: '/stock-form/add',
      builder: (context, state) => const StockFormPage(),
      redirect: (context, state) {
        final authStore = Provider.of<AuthStore>(context, listen: false);
        final userId = authStore.currentUser?.id;
        final userRole = authStore.currentUser?.role;
        if (userId == null || userRole != 'admin') {
          return '/';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/stock-home',
      name: 'stock-home',
      builder: (context, state) {
        return StockHomePage();
      },
      redirect: (context, state) {
        final authStore = Provider.of<AuthStore>(context, listen: false);
        final userId = authStore.currentUser?.id;
        final userRole = authStore.currentUser?.role;
        if (userId == null || userRole != 'admin') {
          return '/';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/stock/:title/:category',
      name: 'stock-category',
      builder: (context, state) {
        final title = state.pathParameters['title']!;
        final category = state.pathParameters['category']!;
        return StockCategoryPage(title: title, category: category);
      },
      redirect: (context, state) {
        final authStore = Provider.of<AuthStore>(context, listen: false);
        final userId = authStore.currentUser?.id;
        final userRole = authStore.currentUser?.role;
        if (userId == null || userRole != 'admin') {
          return '/';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/stock-form/edit',
      name: 'stock-edit-form',
      builder: (context, state) {
        final product = state.extra as Product?;
        return StockFormPage(product: product);
      },
      redirect: (context, state) {
        final authStore = Provider.of<AuthStore>(context, listen: false);
        final userId = authStore.currentUser?.id;
        final userRole = authStore.currentUser?.role;
        if (userId == null || userRole != 'admin') {
          return '/';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/sales-home',
      name: 'sales-home',
      builder: (context, state) => SalesHomePage(),
    ),
    GoRoute(
      path: '/receipts-home',
      name: 'receipts-home',
      builder: (context, state) => ReceiptHomePage(),
    ),
  ],
);
