class Notification_v2{
  final int NotificationID;
  final int EmployeeID;
  final int TATestDateID;
  final String Title;
  final String Body;


  Notification_v2({this.NotificationID, this.EmployeeID,this.TATestDateID, this.Title, this.Body});

  factory Notification_v2.fromJson(Map<String, dynamic> json) {
    return Notification_v2(
      NotificationID: json['NotificationID'],
      EmployeeID: json['EmployeeID'],
      TATestDateID:  json['TATestDateID'],
      Title: json['Title'],
      Body: json['Body'],
    );

  }

}