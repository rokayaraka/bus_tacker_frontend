class ReportModel {
  final int? reportID;
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String issueDescription;
  final String? attachment; // File path or URL (photo, doc, pdf, etc.)

  ReportModel({
    this.reportID,
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.issueDescription,
    this.attachment,
  });
  @override
  String toString() {
    return 'ReportModel(reportID: $reportID, userID: $userID, firstName: $firstName, lastName: $lastName, email: $email, department: $department, issueDescription: $issueDescription, attachment: $attachment)';
  }

  Map<String, dynamic> toJson() {
    return {
      'reportID': reportID,
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'department': department,
      'issueDescription': issueDescription,
      'attachment': attachment,
    };
  }
}