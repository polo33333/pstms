class TestAssignment {
  final int TestAssignmentID;
  final String TestAssignmentDate;
  final String DecisionNo;
  final String isPeriod;
  final String Title;
  final String Note;

  TestAssignment({this.TestAssignmentID,this.TestAssignmentDate,this.DecisionNo, this.isPeriod, this.Title, this.Note});

  factory TestAssignment.fromJson(Map<String, dynamic> json) {
    return TestAssignment(
      TestAssignmentID: json['TestAssignmentID'],
      TestAssignmentDate: json['TestAssignmentDate'],
      DecisionNo: json['DecisionNo'],
      Title: json['Title'],
      Note: json['Note'],
      isPeriod: json['isPeriod'],
    );
  }
}
