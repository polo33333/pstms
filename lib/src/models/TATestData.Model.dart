class TATestDates {
  final int TATestDateID;
  final int TestAssignmentID;
  final String TATestDate;
  final String DecisionNo;
  final String Note;

  TATestDates({this.TATestDateID,this.TestAssignmentID,this.DecisionNo, this.TATestDate, this.Note});

  factory TATestDates.fromJson(Map<String, dynamic> json) {
    return new TATestDates(
      TATestDateID: json['TATestDateID'],
      TestAssignmentID: json['TestAssignmentID'],
      TATestDate: json['TATestDate'],
      DecisionNo: json['DecisionNo'],
      Note: json['Note'],
    );
  }
}
