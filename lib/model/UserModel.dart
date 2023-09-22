class UserModel {
  String id;
  String email;

  UserModel({
    this.id = '',
    required this.email,

  });

  UserModel.fromJson(Map<String , dynamic> json)
      :this(
    id: json["id"],
    email: json["email"],
  );

  Map<String , dynamic> toJson(){
    return {
      "id": id,
      "email": email,
    };
  }
}