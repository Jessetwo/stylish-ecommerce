class Product {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['image'] != null ? map['image']['url'] ?? '' : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
