import 'package:flutter/material.dart';
import 'package:flutter_internship_assignment_quantmhil_it_solutions/pages/home.dart';
import 'package:flutter_internship_assignment_quantmhil_it_solutions/pages/login_page.dart';
import 'package:flutter_internship_assignment_quantmhil_it_solutions/pages/register_page.dart';

import '/pages/auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter routers = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const Auth();
    },
    routes: [
        GoRoute(
      path: "login",
      name: "Login",
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      }),
  GoRoute(
    path: "register",
    name: "Register",
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
    path: "home",
    name: "Home",
    builder: (BuildContext context, GoRouterState state) {
      return const Home();
    },
  )
    ]
  ),
]);
