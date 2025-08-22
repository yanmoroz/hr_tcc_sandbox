import '../../domain/entities/resale_item.dart';

abstract class ResaleLocalDataSource {
  Future<List<ResaleItem>> getItems();
  Future<ResaleItem?> getItemById(String id);
  Future<void> toggleBooking(String id);
}

class ResaleLocalDataSourceImpl implements ResaleLocalDataSource {
  // In-memory mock storage
  final List<ResaleItem> _items = [
    ResaleItem(
      id: '1',
      title: 'Audi A6',
      category: 'Автомобиль',
      priceRub: 1900000,
      ownerName: 'Александров Дмитрий',
      updatedAt: DateTime.now().subtract(const Duration(hours: 24)),
      location: 'Авилон-Плаза, паркинг',
      description:
          '2018 г.в.\nМарка: AUDI\nМодель: A6\nVIN: WAUZZZ4G2JN098362\nОбъем двигателя: 2,0л\nТип двигателя: бензиновый\nМощность: 249 л.с.\n2-1 комплект колесной резины: есть',
      imageUrls: [
        // Placeholder network images; will be replaced later
        'https://images.unsplash.com/photo-1511919884226-fd3cad34687c',
      ],
      status: ResaleItemStatus.booked,
    ),
    ResaleItem(
      id: '2',
      title: 'Смартфон Apple iPhone 16 Pro Max 256 ГБ черный',
      category: 'Смартфон',
      priceRub: 50000,
      ownerName: 'Игнатьева Оксана',
      updatedAt: DateTime.now().subtract(const Duration(hours: 24)),
      location: 'Офис, 3 этаж',
      description: 'Практически новый, полный комплект.',
      imageUrls: [
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      ],
      status: ResaleItemStatus.forSale,
    ),
    ResaleItem(
      id: '3',
      title: 'Ford Mondeo',
      category: 'Автомобиль',
      priceRub: 2900000,
      ownerName: 'Александров Дмитрий',
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      location: 'Паркинг',
      description: 'В отличном состоянии.',
      imageUrls: [
        'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf',
      ],
      status: ResaleItemStatus.forSale,
    ),
  ];

  @override
  Future<List<ResaleItem>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<ResaleItem>.from(_items);
  }

  @override
  Future<ResaleItem?> getItemById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> toggleBooking(String id) async {
    final index = _items.indexWhere((e) => e.id == id);
    if (index == -1) return;
    final current = _items[index];
    final newStatus = current.status == ResaleItemStatus.booked
        ? ResaleItemStatus.forSale
        : ResaleItemStatus.booked;
    _items[index] = current.copyWith(status: newStatus);
  }
}
