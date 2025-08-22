import 'package:equatable/equatable.dart';

enum ResaleItemStatus { forSale, booked }

class ResaleItem extends Equatable {
  final String id;
  final String title;
  final String category; // e.g., Автомобиль, Смартфон
  final int priceRub;
  final String ownerName;
  final DateTime updatedAt;
  final String location;
  final String description;
  final List<String> imageUrls;
  final ResaleItemStatus status;

  const ResaleItem({
    required this.id,
    required this.title,
    required this.category,
    required this.priceRub,
    required this.ownerName,
    required this.updatedAt,
    required this.location,
    required this.description,
    required this.imageUrls,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    priceRub,
    ownerName,
    updatedAt,
    location,
    description,
    imageUrls,
    status,
  ];

  ResaleItem copyWith({
    String? id,
    String? title,
    String? category,
    int? priceRub,
    String? ownerName,
    DateTime? updatedAt,
    String? location,
    String? description,
    List<String>? imageUrls,
    ResaleItemStatus? status,
  }) {
    return ResaleItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      priceRub: priceRub ?? this.priceRub,
      ownerName: ownerName ?? this.ownerName,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
    );
  }
}
