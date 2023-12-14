part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class EmployeeListFetchEvent extends EmployeeEvent{}

class EmployeeDataPostEvent extends EmployeeEvent{
  final Employee model;

  EmployeeDataPostEvent({required this.model});
}
