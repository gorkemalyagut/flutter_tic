class User{
int? id;
String? mail;
String? name;
String? username;
String? password;

User({
    this.id,
    this.mail,
    this.name,
    this.username,
    this.password,
  }
);
Map<String, dynamic> toMap() {
  final map = Map<String,dynamic>();
  if(id != null){
    map['id'] = id;
  }
  map['mail']= mail;
  map['name']= name;
  map['username']= username;
  map['password']= password;
  return map;
  }
factory User.fromMap(Map<String, dynamic> map){
  return User(
  id: map['id'],
  mail: map['mail'],
  name: map['name'],
  username: map['username'],
  password: map['password'],
  );
}
}