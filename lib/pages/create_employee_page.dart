import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/employee_bloc.dart';
import '/model/employee_data_model.dart';

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({super.key});

  @override
  State<CreateEmployeePage> createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController salaryFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();

  var inputFieldBorderStyle = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 4,
        color: Colors.teal.shade400,
      ));

  bool isValidName = true;
  bool isValidSalary = true;
  bool isValidAge = true;

  RegExp digitValidator = RegExp(r'^[0-9]+$');

  final EmployeeBloc employeePostBloc = EmployeeBloc();

  void setNameValidator(valid) {
    setState(() {
      isValidName = valid;
    });
  }

  void setSalaryValidator(valid) {
    setState(() {
      isValidSalary = valid;
    });
  }

  void setAgeValidator(valid) {
    setState(() {
      isValidAge = valid;
    });
  }

  void submitData(isAllValid) {
    if (isAllValid) {
      employeePostBloc.add(
        EmployeeDataPostEvent(
          model: Employee(
            id: 0,
            name: nameFieldController.text,
            salary: int.parse(salaryFieldController.text),
            age: int.parse(ageFieldController.text),
            imageUrl: "",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Employee"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.w500),
        shadowColor: Colors.teal.shade50,
        elevation: 4,
        backgroundColor: Colors.teal.shade100,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade50,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(
                  5,
                  10,
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    backgroundColor: Colors.white,
                    radius: 64,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                    controller: nameFieldController,
                    style: GoogleFonts.poppins(),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      setNameValidator(value.isNotEmpty);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      hintStyle: GoogleFonts.poppins(),
                      errorText: isValidName ? null : "Please enter a name!",
                      errorStyle: GoogleFonts.poppins(),
                      border: inputFieldBorderStyle,
                    )),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: salaryFieldController,
                  style: GoogleFonts.poppins(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setSalaryValidator(value.isNotEmpty && digitValidator.hasMatch(value));
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Salary",
                    hintStyle: GoogleFonts.poppins(),
                    errorText: isValidSalary ? null : "Please enter a valid salary!",
                    errorStyle: GoogleFonts.poppins(),
                    border: inputFieldBorderStyle,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: ageFieldController,
                  style: GoogleFonts.poppins(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setAgeValidator(value.isNotEmpty && digitValidator.hasMatch(value) && value.length <= 2);
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Your Age",
                      hintStyle: GoogleFonts.poppins(),
                      errorText: isValidAge ? null : "Please Enter a valid Age!",
                      border: inputFieldBorderStyle),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setNameValidator(nameFieldController.text.isNotEmpty);
                        setSalaryValidator(salaryFieldController.text.isNotEmpty && digitValidator.hasMatch(salaryFieldController.text));
                        setAgeValidator(ageFieldController.text.isNotEmpty &&
                            digitValidator.hasMatch(ageFieldController.text) &&
                            ageFieldController.text.length <= 2);
                        submitData(isValidName && isValidAge && isValidSalary);
                      },
                      icon: const Icon(
                        Icons.post_add_outlined,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                      ),
                      label: Text(
                        "Submit",
                        style: GoogleFonts.poppins(color: Colors.white),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Divider(
                    height: 24,
                  ),
                ),
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  bloc: employeePostBloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case const (EmployeePostSuccessState):
                        return const PostReponseMessage(
                          message: "Succesfully Added Employee!",
                        );
                      case const (EmployeePostFailedState):
                        var failedState = state as EmployeePostFailedState;
                        return PostReponseMessage(message: "Please Try again later!\nError:${failedState.errorCode}");
                      case const (EmployeePostLoadingState):
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostReponseMessage extends StatelessWidget {
  const PostReponseMessage({
    super.key,
    required this.message,
  });

  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.teal.shade50,
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: GoogleFonts.poppins(color: Colors.teal.shade800),
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
