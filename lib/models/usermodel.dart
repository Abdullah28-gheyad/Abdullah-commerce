class UserModel {
  String name;
  String email;
  String password;
  String phone;
  String uId;
  String image;

  UserModel({this.email, this.phone, this.name, this.password, this.uId,this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'uId': uId,
      'image': image,
    };
  }
}
