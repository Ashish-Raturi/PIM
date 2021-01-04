class PimUser {
  String uid;
  // String password;
  PimUser({this.uid});
}

class PimUserData {
  String name;
  String email;
  String password;
  String mobile;
  String location;
  PimUserData(
      {this.name, this.email, this.location, this.mobile, this.password});
}
