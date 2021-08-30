class RequestsDB{
  late final int level;
  late final String fullname;
  late final String phone;
  late final String type;
  late final String description;

  RequestsDB({
  required this.description,
  required this.level,
  required this.phone,
  required this.type,
  required this.fullname,
  }
);

RequestsDB.fromMap(Map<String,  dynamic> map){
    level = 1;
    fullname = map['fullname'];
    phone = map['phone'];
    type = map['type'];
    description = map['description'];
}

  Map<String, Object> toMap() {
    return {
      'fullname': fullname,
      'description': description,
      'phone': phone,
      'level':level,
      'type': type,
    };
  }
}
