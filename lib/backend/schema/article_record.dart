import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ArticleRecord extends FirestoreRecord {
  ArticleRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Link" field.
  String? _link;
  String get link => _link ?? '';
  bool hasLink() => _link != null;

  // "TitleOfArticle" field.
  String? _titleOfArticle;
  String get titleOfArticle => _titleOfArticle ?? '';
  bool hasTitleOfArticle() => _titleOfArticle != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _link = snapshotData['Link'] as String?;
    _titleOfArticle = snapshotData['TitleOfArticle'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Article');

  static Stream<ArticleRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ArticleRecord.fromSnapshot(s));

  static Future<ArticleRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ArticleRecord.fromSnapshot(s));

  static ArticleRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ArticleRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ArticleRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ArticleRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ArticleRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ArticleRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createArticleRecordData({
  String? link,
  String? titleOfArticle,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Link': link,
      'TitleOfArticle': titleOfArticle,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class ArticleRecordDocumentEquality implements Equality<ArticleRecord> {
  const ArticleRecordDocumentEquality();

  @override
  bool equals(ArticleRecord? e1, ArticleRecord? e2) {
    return e1?.link == e2?.link &&
        e1?.titleOfArticle == e2?.titleOfArticle &&
        e1?.image == e2?.image;
  }

  @override
  int hash(ArticleRecord? e) =>
      const ListEquality().hash([e?.link, e?.titleOfArticle, e?.image]);

  @override
  bool isValidKey(Object? o) => o is ArticleRecord;
}
