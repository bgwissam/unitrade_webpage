
class User {
 final String uid;
 User({this.uid});
}


class Users {
  String uid;
  String fullName;
  String password;
  String emailAddress;
  List<String> roles;

  Users({
    this.uid,
    this.fullName,
    this.password,
    this.emailAddress,
    this.roles
  });
}