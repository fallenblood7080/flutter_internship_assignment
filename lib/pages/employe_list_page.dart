import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/bloc/employee_bloc.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final EmployeeBloc employeeFetchBloc = EmployeeBloc();

  @override
  void initState() {
    super.initState();
    employeeFetchBloc.add(EmployeeListFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.w500),
          shadowColor: Colors.teal.shade50,
          elevation: 4,
          backgroundColor: Colors.teal.shade100,
        ),
        body: BlocConsumer<EmployeeBloc, EmployeeState>(
          bloc: employeeFetchBloc,
          listenWhen: (previous, current) => current is EmployeeActionState,
          buildWhen: (previous, current) => current is! EmployeeActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (EmployeeListFetchSuccessState):
                final successStateData = state as EmployeeListFetchSuccessState;
                return ListView.builder(
                    itemCount: successStateData.employeeModels.length,
                    itemBuilder: (context, index) {
                      return EmployeeTile(successStateData: successStateData,index: index,);
                    });

              case const (EmployeeListFetchFailedState):
                return Center(
                  child: HomeFetchErrorWidget(employeeFetchBloc: employeeFetchBloc),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
            }
          },
        ));
  }
}

class HomeFetchErrorWidget extends StatelessWidget {
  const HomeFetchErrorWidget({
    super.key,
    required this.employeeFetchBloc,
  });

  final EmployeeBloc employeeFetchBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty.png',
          width: 300,
          height: 300,
        ),
        Text(
          "Something Went Wrong!!!",
          style: GoogleFonts.poppins(
            color: Colors.teal,
            fontSize: 18,
          ),
        ),
        ElevatedButton.icon(
            onPressed: () => employeeFetchBloc.add(EmployeeListFetchEvent()),
            icon: const Icon(
              Icons.restart_alt_outlined,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
              foregroundColor: Colors.white,
            ),
            label: Text(
              "Retry",
              style: GoogleFonts.poppins(color: Colors.white),
            ))
      ],
    );
  }
}

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    super.key,
    required this.successStateData, required this.index,
  });

  final EmployeeListFetchSuccessState successStateData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade300,
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(
                4,
                5,
              ),
            )
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.all(8),
          onTap: () {
            showEmployeeDetails(context);
          },
          tileColor: Colors.teal.shade300,
          leading: CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(successStateData.employeeModels[index].imageUrl),
            backgroundImage: const AssetImage("assets/images/profile.png"),
            radius: 32,
          ),
          title: Text(successStateData.employeeModels[index].name),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> showEmployeeDetails(BuildContext context) {
    return showBottomSheet(
              context: context,
              builder: (context) {
                TextStyle textStyle = GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                );
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      color: Colors.teal.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade600,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(
                            0,
                            -10,
                          ),
                        )
                      ],
                    ),
                    height: 150,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(successStateData.employeeModels[index].imageUrl),
                          backgroundImage: const AssetImage("assets/images/profile.png"),
                          backgroundColor: Colors.teal.shade200,
                          radius: 64,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ID:${successStateData.employeeModels[index].id}", style: textStyle),
                            Text("Name:${successStateData.employeeModels[index].name}", style: textStyle),
                            Text("Salary:${successStateData.employeeModels[index].salary}", style: textStyle),
                            Text("Age:${successStateData.employeeModels[index].age}", style: textStyle),
                          ],
                        )
                      ],
                    ));
              });
  }
}
