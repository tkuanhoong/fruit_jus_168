part of 'search_api_service.dart';

class _SearchService implements SearchApiService {
  final FirebaseFirestore _db;

  _SearchService(this._db);

  @override
  Stream<List<SearchItemModel>> searchProduct(String query) {
    try {
      return _db.collection('products').orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => SearchItemModel.fromMap(doc.data()))
              .where((element) =>
                  element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
