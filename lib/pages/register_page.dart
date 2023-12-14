import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController = TextEditingController();
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  var inputFieldBorderStyle = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 4,
        color: Colors.teal.shade400,
      ));

  bool isValidName = true;
  bool isValidEmail = true;
  bool isValidPassword = true;
  bool isValidConfirmPassword = true;

  void setNameValidator(valid) {
    setState(() {
      isValidName = valid;
    });
  }

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

  void setConfimrPasswordValidator(valid) {
    setState(() {
      isValidConfirmPassword = valid;
    });
  }

  void register(isAllValid) {
    if (isAllValid) {
      context.goNamed("Home");
    }
  }

  void login() {
    context.goNamed("Login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              Text(
                "Register",
                style: GoogleFonts.poppins(fontSize: 34, color: Colors.teal, fontWeight: FontWeight.w300, decoration: TextDecoration.none),
              ),
              Image.asset(
                "assets/images/Welcome2.png",
                width: 300,
                isAntiAlias: true,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                  controller: nameFieldController,
                  style: GoogleFonts.poppins(),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setEmailValidator(value.isNotEmpty);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter a name",
                    hintStyle: GoogleFonts.poppins(color: Colors.black26),
                    errorText: isValidName ? null : "Please enter a name!",
                    errorStyle: GoogleFonts.poppins(),
                    border: inputFieldBorderStyle,
                  )),
              const SizedBox(
                height: 12,
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
                height: 12,
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
                    errorText: isValidPassword ? null : "Enter a password!",
                    errorStyle: GoogleFonts.poppins(),
                    border: inputFieldBorderStyle,
                  )),
              const SizedBox(
                height: 12,
              ),
              TextField(
                  controller: confirmPasswordFieldController,
                  style: GoogleFonts.poppins(),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  autocorrect: false,
                  onChanged: ((value) => {setConfimrPasswordValidator(passwordFieldController.text == value)}),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: GoogleFonts.poppins(color: Colors.black26),
                    errorText: isValidConfirmPassword ? null : "Password must be match!",
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
                      setNameValidator(nameFieldController.text.isNotEmpty);
                      setConfimrPasswordValidator(confirmPasswordFieldController.text == passwordFieldController.text);
                      register(isValidName && isValidEmail && isValidPassword && isValidConfirmPassword);
                    },
                    icon: const Icon(
                      Icons.account_circle,
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
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton.icon(
                    onPressed: () => login(),
                    icon: const Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade300,
                      foregroundColor: Colors.white,
                    ),
                    label: Text(
                      "Already Registered ?",
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
