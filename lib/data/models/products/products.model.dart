import 'package:json_annotation/json_annotation.dart';
import 'package:mock_store/data/models/products/rating.model.dart';

part 'products.model.g.dart';

@JsonSerializable()
class ProductsModel {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel? rating;
  final bool isWishListed;

  ProductsModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
    this.isWishListed = false,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);

  ProductsModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    RatingModel? rating,
    bool? isWishListed,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      isWishListed: isWishListed ?? this.isWishListed,
    );
  }
}
