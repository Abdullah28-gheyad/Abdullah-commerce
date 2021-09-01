class ProductModel
{
  String image;
  String name;
  String price;
  String description;
  String sale;
  String stock;
  String id;
  ProductModel({this.description,this.image,this.name,this.price,this.sale,this.stock,this.id}) ;
  ProductModel.FromJson(Map<String,dynamic>json)
  {
    image=json['image'];
    name=json['name'];
    price=json['price'];
    description=json['description'];
    sale=json['sale'];
    stock=json['stock'];
    id=json['id'];
  }

  Map <String,dynamic> toMap()
  {
    return {
      'image':image,
      'name':name,
      'price':price,
      'description':description,
      'sale':sale,
      'stock':stock,
      'id':id,
    };
  }
}