import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  var inputFieldBorderStyle = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 4,
        color: Colors.teal.shade400,
      ));

  bool isValidEmail = true;
  bool isValidPassword = true;

  void setEmailValidator(valid) {
    setState(() {
      isValidEmail = valid;
    });
  }

  void setPasswordValidator(valid) {
    setState(() {
      isValidPassword = valid;
    });
  }

  void login(isAllValid) {
    if (isAllValid) {
      context.goNamed("Home");
    }
  }

  void register() {
    context.goNamed("Register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Text(
              "Login",
              style: GoogleFonts.poppins(fontSize: 34, color: Colors.teal, fontWeight: FontWeight.w300, decoration: TextDecoration.none),
            ),
            Image.asset(
              "assets/images/Welcome1.png",
              width: 300,
              isAntiAlias: true,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
                controller: emailFieldController,
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setEmailValidator(value.isNotEmpty && emailRegex.hasMatch(value));
                },
                decoration: InputDecoration(
                  hintText: "example@xyz.com",
                  hintStyle: GoogleFonts.poppins(color: Colors.black26),
                  errorText: isValidEmail ? null : "Please enter a valid email!",
                  errorStyle: GoogleFonts.poppins(),
                  border: inputFieldBorderStyle,
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: passwordFieldController,
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: GoogleFonts.poppins(color: Colors.black26),
                  errorText: isValidPassword ? null : "Incorrect password!",
                  errorStyle: GoogleFonts.poppins(),
                  border: inputFieldBorderStyle,
                )),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 130,
              height: 40,
              child: ElevatedButton.icon(
                  onPressed: () {
                    setEmailValidator(emailFieldController.text.isNotEmpty && emailRegex.hasMatch(emailFieldController.text));
                    setPasswordValidator(passwordFieldController.text.isNotEmpty);
                    login(isValidEmail && isValidPassword);
                  },
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
              width: 175,
              height: 40,
              child: ElevatedButton.icon(
                  onPressed: () => register(),
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade300,
                    foregroundColor: Colors.white,
                  ),
                  label: Text(
                    "New User?",
                    style: GoogleFonts.poppins(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
