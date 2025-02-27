import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poli_admin/base/global_widgets/side_navbar.dart';
<<<<<<< HEAD
import 'package:poli_admin/screens/billing/detail_billing.dart';
import 'package:poli_admin/screens/list_pasien/list_pasien_screen.dart';
import 'package:poli_admin/screens/list_pasien/registrasi_screen.dart';
=======
import 'package:poli_admin/base/utils/app_routes.dart';
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
import 'package:poli_admin/screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const SideNavbar(),
      routes: [
        GoRoute(
          path: 'list-pasien',
          builder: (context, state) => const ListPasienScreen(),
          routes: [
            GoRoute(
              path: 'registrasi',
              builder: (context, state) => const RegistrasiScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'billing',
          builder: (context, state) => const ListPasienScreen(),
          routes: [
            GoRoute(
              path: 'detail-billing/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return DetailBilling();
                // return DetailBilling(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'riwayat-pembayaran',
          builder: (context, state) => const ListPasienScreen(),
          routes: [
            GoRoute(
              path: 'detail-riwayat/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return DetailBilling();
                // return DetailBilling(id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Poliklinik Hospitel Bantarangin',
<<<<<<< HEAD
<<<<<<< HEAD
      routerConfig: _router,
=======
      home: LoginScreen(),
=======
      // home: LoginScreen(),
>>>>>>> a3db70518278aadc69b9fab306d1ffca0e6d4826
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.dashboard: (context) => SideNavbar()
      },
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
    );
  }
}
