import '../../domain/entities/resale_item.dart';

class _AuthorDto {
  final String? firstName;
  final String? lastName;

  _AuthorDto({this.firstName, this.lastName});

  factory _AuthorDto.fromJson(Map<String, dynamic>? json) => _AuthorDto(
    firstName: json?['firstName'] as String?,
    lastName: json?['lastName'] as String?,
  );

  String toOwnerName() {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    return [f, l].where((e) => e.isNotEmpty).join(' ').trim();
  }
}

class _EquipmentTypeDto {
  final String? id;
  final String? name;
  _EquipmentTypeDto({this.id, this.name});
  factory _EquipmentTypeDto.fromJson(Map<String, dynamic>? json) =>
      _EquipmentTypeDto(
        id: json?['id'] as String?,
        name: json?['name'] as String?,
      );
}

class _StatusDto {
  final String? code;
  final String? name;
  _StatusDto({this.code, this.name});
  factory _StatusDto.fromJson(Map<String, dynamic>? json) => _StatusDto(
    code: json?['code']?.toString(),
    name: json?['name'] as String?,
  );
}

class ResaleListItemDto {
  final String id;
  final int price;
  final String shortName;
  final _EquipmentTypeDto equipmentType;
  final _AuthorDto author;
  final DateTime creationDate;
  final _StatusDto status;

  ResaleListItemDto({
    required this.id,
    required this.price,
    required this.shortName,
    required this.equipmentType,
    required this.author,
    required this.creationDate,
    required this.status,
  });

  factory ResaleListItemDto.fromJson(Map<String, dynamic> json) =>
      ResaleListItemDto(
        id: json['id'] as String,
        price: (json['price'] ?? 0) as int,
        shortName: (json['shortName'] ?? '') as String,
        equipmentType: _EquipmentTypeDto.fromJson(
          json['equipmentType'] as Map<String, dynamic>?,
        ),
        author: _AuthorDto.fromJson(json['author'] as Map<String, dynamic>?),
        creationDate:
            DateTime.tryParse((json['creationDate'] ?? '').toString()) ??
            DateTime.now(),
        status: _StatusDto.fromJson(json['status'] as Map<String, dynamic>?),
      );

  ResaleItem toEntityLite() {
    // Backend: 1 - for sale; 0 - booked per user instruction
    final isForSale = status.code?.toString() == '1';
    return ResaleItem(
      id: id,
      title: shortName,
      category: equipmentType.name ?? '',
      priceRub: price,
      ownerName: author.toOwnerName(),
      updatedAt: creationDate,
      location: '',
      description: '',
      imageUrls: const [
        'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
      ],
      status: isForSale ? ResaleItemStatus.forSale : ResaleItemStatus.booked,
    );
  }
}

class ResaleDetailDto {
  final String id;
  final String name;
  final int price;
  final bool lottery;
  final bool bookingFinish;
  final String? location;
  final String? description;
  final List<String> photos;
  final _EquipmentTypeDto equipmentType;
  final _AuthorDto author;
  final DateTime creationDate;
  final _StatusDto status;

  ResaleDetailDto({
    required this.id,
    required this.name,
    required this.price,
    required this.lottery,
    required this.bookingFinish,
    required this.location,
    required this.description,
    required this.photos,
    required this.equipmentType,
    required this.author,
    required this.creationDate,
    required this.status,
  });

  factory ResaleDetailDto.fromJson(Map<String, dynamic> json) =>
      ResaleDetailDto(
        id: json['id'] as String,
        name: (json['name'] ?? json['shortName'] ?? '') as String,
        price: (json['price'] ?? 0) as int,
        lottery: (json['lottery'] ?? false) as bool,
        bookingFinish: (json['bookingFinish'] ?? false) as bool,
        location: json['location'] as String?,
        description: json['description'] as String?,
        photos: (json['photo'] as List<dynamic>? ?? const [])
            .map((e) => e.toString())
            .toList(),
        equipmentType: _EquipmentTypeDto.fromJson(
          json['equipmentType'] as Map<String, dynamic>?,
        ),
        author: _AuthorDto.fromJson(json['author'] as Map<String, dynamic>?),
        creationDate:
            DateTime.tryParse((json['creationDate'] ?? '').toString()) ??
            DateTime.now(),
        status: _StatusDto.fromJson(json['status'] as Map<String, dynamic>?),
      );

  ResaleItem toEntity() {
    final isForSale = status.code?.toString() == '1';
    return ResaleItem(
      id: id,
      title: name,
      category: equipmentType.name ?? '',
      priceRub: price,
      ownerName: author.toOwnerName(),
      updatedAt: creationDate,
      location: location ?? '',
      description: description ?? '',
      imageUrls: const [
        'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
      ],
      status: isForSale ? ResaleItemStatus.forSale : ResaleItemStatus.booked,
    );
  }
}
