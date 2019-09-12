class Employee{
  final String EmployeeName;
  final String Email;
  final String Phone;
  final String Mobile;
  final String Address;
  final bool IsSuccess;
  final String DeparmentName;

  Employee({this.EmployeeName, this.DeparmentName, this.Email, this.Phone, this.Mobile, this.Address, this.IsSuccess});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      EmployeeName: json['EmployeeName'],
      DeparmentName: json['DeparmentName'],
      Email: json['Email'],
      Phone: json['Phone'],
      Mobile: json['Mobile'],
      Address: json['Address'],
      IsSuccess: json['IsSuccess'],
    );

  }

}