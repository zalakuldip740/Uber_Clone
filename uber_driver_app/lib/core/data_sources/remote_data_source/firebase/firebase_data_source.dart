import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSource {
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });

  Stream<T> oneStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query Function(Query query)? queryBuilder,
  });

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.update(data);
  }
}
