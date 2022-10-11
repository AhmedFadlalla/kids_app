import 'package:equatable/equatable.dart';

class UserParameter extends Equatable{
  final int? id;
  final String email;
  final String password;
  final String? name;
  final String? role;

   UserParameter({
      this.id,
    required this.email,
    required this.password,
      this.name,
     this.role
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,password,name,role];

}

class CategoryParameter extends Equatable{
  final int id;


  CategoryParameter({
   required this.id,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class ProductParameter extends Equatable{
  final int id,price;
  final String title,description;
  final String category;
  final String  image;


  ProductParameter({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.image,
    required this.category
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,price,title,description,image,category
  ];

}