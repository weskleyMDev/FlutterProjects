import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/screens/contact_form_screen.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/contact-form',
      builder: (context, state) => ContactFormScreen(),
      routes: [
        GoRoute(
          path: '/contact-form/new-contact',
          name: 'new-contact',
          builder: (context, state) => ContactFormScreen(),
        ),
        GoRoute(
          path: '/contact-form/edit-contact',
          name: 'edit-contact',
          builder: (context, state) {
            final contact = state.extra as Contact?;
            return ContactFormScreen(contact: contact);
          },
        ),
      ],
    ),
  ],
);
