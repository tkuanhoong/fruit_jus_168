import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/search/data/models/search_item_model.dart';

part 'search_service.dart';

abstract class SearchApiService {
  factory SearchApiService(FirebaseFirestore db) = _SearchService;
  Stream<List<SearchItemModel>> searchProduct(String query);
}
