class Employee{
  final int id;
  final String name;
  final int salary;
  final int age;
  final String imageUrl;

  Employee({required this.id, required this.name, required this.salary, required this.age, required this.imageUrl});

  Employee.fromJson(Map<String, dynamic> json):
    id = json['id'] as int,
    name = json["employee_name"] as String,
    salary = json["employee_salary"] as int,
    age = json["employee_age"] as int,
    imageUrl = json["profile_image"] as String;
}