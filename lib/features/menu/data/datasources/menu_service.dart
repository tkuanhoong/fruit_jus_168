import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/menu/data/datasources/menu_api_service.dart';
import 'package:fruit_jus_168/features/menu/data/models/category.dart';
import 'package:fruit_jus_168/features/menu/data/models/product.dart';

class MenuService implements MenuApiService {
  final FirebaseFirestore _firestore;

  MenuService(this._firestore);

  @override
  Future<List<ProductModel>> fetchCategoryProducts(String category) async {
    final querySnapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    final productModels = querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();

    return productModels;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final categoryCollections =
        await _firestore.collectionGroup('categories').get();
    List<CategoryModel> categories = [];
    for (var categoryDoc in categoryCollections.docs) {
      final categoryData = categoryDoc.data();
      final categoryId = categoryData['id'];
      final categoryName = categoryData['name'];
      final categoryImageUrl = categoryData['imageUrl'];
      final productDocs =
          await categoryDoc.reference.collection('products').get();
      List<ProductModel> products = productDocs.docs.map((productDoc) {
        final productData = productDoc.data();
        return ProductModel(
          id: productDoc.id,
          name: productData['name'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          description: productData['description'],
          category: categoryName,
          // Add other product fields here
        );
      }).toList();
      categories.add(CategoryModel(
          id: categoryId,
          name: categoryName,
          products: products,
          imageUrl: categoryImageUrl));
    }

    return categories;
  }
}
