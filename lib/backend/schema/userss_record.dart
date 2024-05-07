import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class UserssRecord extends FirestoreRecord {
  UserssRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "fullname" field.
  String? _fullname;
  String get fullname => _fullname ?? '';
  bool hasFullname() => _fullname != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "Date_Of_Birth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _fullname = snapshotData['fullname'] as String?;
    _password = snapshotData['password'] as String?;
    _gender = snapshotData['gender'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _dateOfBirth = snapshotData['Date_Of_Birth'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userss');

  static Stream<UserssRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserssRecord.fromSnapshot(s));

  static Future<UserssRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserssRecord.fromSnapshot(s));

  static UserssRecord fromSnapshot(DocumentSnapshot snapshot) => UserssRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserssRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserssRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserssRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserssRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserssRecordData({
  String? email,
  String? fullname,
  String? password,
  String? gender,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  DateTime? createdTime,
  DateTime? dateOfBirth,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'fullname': fullname,
      'password': password,
      'gender': gender,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'created_time': createdTime,
      'Date_Of_Birth': dateOfBirth,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserssRecordDocumentEquality implements Equality<UserssRecord> {
  const UserssRecordDocumentEquality();

  @override
  bool equals(UserssRecord? e1, UserssRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.fullname == e2?.fullname &&
        e1?.password == e2?.password &&
        e1?.gender == e2?.gender &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.createdTime == e2?.createdTime &&
        e1?.dateOfBirth == e2?.dateOfBirth;
  }

  @override
  int hash(UserssRecord? e) => const ListEquality().hash([
        e?.email,
        e?.fullname,
        e?.password,
        e?.gender,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber,
        e?.createdTime,
        e?.dateOfBirth
      ]);

  @override
  bool isValidKey(Object? o) => o is UserssRecord;
}
