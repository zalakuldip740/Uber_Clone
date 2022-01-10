import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_data_source.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  @override
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  @override
  Stream<T> oneStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query Function(Query query)? queryBuilder,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>))
          .where((value) => value != null)
          .toList()
          .first;

      return result;
    });
  }

  @override
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.update(data);
  }
}
