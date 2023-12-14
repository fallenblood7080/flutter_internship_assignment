part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

abstract class EmployeeActionState extends EmployeeState{}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeListFetchSuccessState extends EmployeeState{
  final List<Employee> employeeModels;

  EmployeeListFetchSuccessState({required this.employeeModels});
}
final class EmployeeListFetchFailedState extends EmployeeState{}

final class EmployeePostSuccessState extends EmployeeState{}
final class EmployeePostLoadingState extends EmployeeState{}
final class EmployeePostFailedState extends EmployeeState{
  final String errorCode;

  EmployeePostFailedState({required this.errorCode});
}
