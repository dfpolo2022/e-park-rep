class User {
  String? email;
  String? lastname;
  String? name;
  String? password;

  User({this.email, this.lastname, this.name, this.password});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    lastname = json['lastname'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['lastname'] = this.lastname;
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}