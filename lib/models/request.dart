class RequestsDB{
int? id;
DateTime? date;
final String? priority;
String? fullname;
String? phone;
String? type;
String? description;
int? status;

  RequestsDB({
   this.description,
   this.priority,
   this.phone,
   this.type,
   this.fullname,
   this.status,
   this.date,
  }
);
  RequestsDB.withId({
   this.id,
   this.description,
   this.priority,
   this.phone,
   this.type,
   this.fullname,
   this.status,
   this.date,
  }
);

Map<String, dynamic> toMap() {
  final map = Map<String,dynamic>();
  
  if(id != null){
    map['id'] = id;
  }
  map['date']= date!.toIso8601String();
  map['priority']= priority;
  map['fullname']= fullname;
  map['phone']= phone;
  map['type']= type;
  map['description']= description;
  map['status']= status;
  return map;
  }
factory RequestsDB.fromMap(Map<String, dynamic> map){
  return RequestsDB.withId(
  id: map['id'],
  date: (map['date'] != null) ? DateTime.parse(map['date']) : null,
  priority: map['priority'],
  fullname: map['fullname'],
  phone: map['phone'],
  type: map['type'],
  description: map['description'],
  status: map['status'],
  );
}

}