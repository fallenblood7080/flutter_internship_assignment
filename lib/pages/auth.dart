import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Internship Assignment",
            style: GoogleFonts.poppins(color: Colors.teal.shade600, fontWeight: FontWeight.w400, fontSize: 24),
          ),
          const SizedBox(height: 64,),
          Image.asset('assets/images/explore.png'),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 130,
            height: 40,
            child: ElevatedButton.icon(
                onPressed: () => context.goNamed("Login"),
                icon: const Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                ),
                label: Text(
                  "Login",
                  style: GoogleFonts.poppins(color: Colors.white),
                )),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 130,
            height: 40,
            child: ElevatedButton.icon(
                onPressed: () => context.goNamed("Register"),
                icon: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                ),
                label: Text(
                  "Register",
                  style: GoogleFonts.poppins(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
