import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '/pages/create_employee_page.dart';
import '/pages/employe_list_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Widget> navPages = [const EmployeeListPage(),const CreateEmployeePage()];
  
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navPages[currentPageIndex],
      bottomNavigationBar: GNav(
          gap: 8,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.teal.shade200,
          tabActiveBorder: Border.all(width: 2, color: Colors.teal.shade300),
          tabBackgroundColor: Colors.teal.shade300,
          color: Colors.teal,
          textStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
          padding: const EdgeInsets.all(8),
          iconSize: 24,
          onTabChange: (index) => {
            setState(() => currentPageIndex = index,)
          },
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              iconColor: Colors.teal.shade800,
              iconActiveColor: Colors.white,
              text: "Home",
              margin: const EdgeInsets.all(8),
            ),
            GButton(
              icon: Icons.add,
              text: "Create",
              iconColor: Colors.teal.shade800,
              iconActiveColor: Colors.white,
              margin: const EdgeInsets.all(8),
            ),
          ]),
    );
  }
}
