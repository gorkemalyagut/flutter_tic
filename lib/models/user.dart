class User{
  late final String? mail;
  late final String? password;
  late final String? name;

  User({
  required this.mail,
  required this.password,
  required this.name,

  }
);
Map<String, dynamic> toMap() {
    return {
      'mail': mail,
      'password': password,
      'name': name,
    };
}
User.fromMap(Map<String,  dynamic> map){
    mail = map['mail'];
    password = map['password'];
    name = map['name'];

}
@override
String toString() {
    return 'User{mail: $mail, password: $password, name: $name}';
  }
}

