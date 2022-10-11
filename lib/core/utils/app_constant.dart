import 'package:equatable/equatable.dart';


class AppContances{
  static const baseUrl="https://api.escuelajs.co/api/v1";


  static const userRegister="$baseUrl/users/";
  static const userLogin="https://api.escuelajs.co/api/v1/auth/login";
  static const getProducts="$baseUrl/products";
  static String getProductData(int id)=>"$getProducts/$id";
  static const getCategories="$baseUrl/categories";
  static String getCategoriesProducts(int id)=>"$baseUrl/categories/$id/products";
}

class NoParameters extends Equatable{
  const NoParameters();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

