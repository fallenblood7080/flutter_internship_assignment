import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '/model/employee_data_model.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeListFetchEvent>(onEmployeeListFetch);
    on<EmployeeDataPostEvent>(onEmployeeDataPost);
  }

  FutureOr<void> onEmployeeListFetch(EmployeeListFetchEvent event, Emitter<EmployeeState> emit) async {
    try {
      final response = await http.get(
        Uri.parse("https://dummy.restapiexample.com/api/v1/employees"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<Employee> employeeModels = List.empty(growable: true);
        Map<String, dynamic> jsonMap = json.decode(response.body);
        List<dynamic> data = jsonMap['data'];
        for (var i = 0; i < data.length; i++) {
          Employee employee = Employee.fromJson(data[i]);
          print(
              "Id:${employee.id}\nName:${employee.name}\nSalary:${employee.salary}\nAge:${employee.age}\nImg:${employee.imageUrl}\n --------------------------");
          employeeModels.add(employee);
        }

        emit(EmployeeListFetchSuccessState(employeeModels: employeeModels));
      }
    } catch (error) {
      emit(EmployeeListFetchFailedState());
      print(error);
    }
  }

  FutureOr<void> onEmployeeDataPost(EmployeeDataPostEvent event, Emitter<EmployeeState> emit) async {
    try {
      emit(EmployeePostLoadingState());
      var response = await http.post(
        Uri.parse("https://dummy.restapiexample.com/api/v1/create"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"name": event.model.name, "salary": event.model.salary, "age": event.model.age}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('User created successfully: $responseData');
        emit(EmployeePostSuccessState());
      }
      else{
        emit(EmployeePostFailedState(errorCode: response.statusCode.toString()));
      }
    } catch (error) {
      emit(EmployeePostFailedState(errorCode: error.toString()));
      print(error);
    }
  }
}
