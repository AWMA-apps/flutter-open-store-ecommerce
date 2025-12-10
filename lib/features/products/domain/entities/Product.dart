import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    price,
    description,
    category,
    image,
    rating,
  ];
}

class Rating extends Equatable {
  final num rate;
  final int count;

  const Rating({required this.rate, required this.count});

  @override
  // TODO: implement props
  List<Object?> get props => [rate, count];
}
