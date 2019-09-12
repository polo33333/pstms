class TATestCompany {



  final String CompanyName;
  final String DepartmentName;
  final int ParentID;

  TATestCompany({this.CompanyName, this.DepartmentName, this.ParentID});


  factory TATestCompany.fromJson(Map<String, dynamic> json) {
    return TATestCompany(
      CompanyName: json['CompanyName'],
      DepartmentName: json['DepartmentName'],
      ParentID: json['ParentID'],
    );

  }
}
