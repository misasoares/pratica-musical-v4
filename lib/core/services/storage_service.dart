import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:fpdart/fpdart.dart';

class StorageService {
  final FirebaseStorage _storage;
  final _uuid = const Uuid();

  StorageService(this._storage);

  /// Uploads a file to Firebase Storage and returns the download URL.
  ///
  /// [file] The file to upload.
  /// [path] The base path in storage (e.g., 'programs', 'exercises').
  Future<Either<String, String>> uploadFile({
    required File file,
    required String path,
  }) async {
    try {
      final fileName = '${_uuid.v4()}_${file.path.split('/').last}';
      final ref = _storage.ref().child('$path/$fileName');

      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return Right(downloadUrl);
    } catch (e) {
      return Left('Erro ao fazer upload da imagem: $e');
    }
  }

  /// Deletes a file from Firebase Storage given its URL.
  Future<Either<String, Unit>> deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
      return const Right(unit);
    } catch (e) {
      return Left('Erro ao deletar arquivo: $e');
    }
  }
}
