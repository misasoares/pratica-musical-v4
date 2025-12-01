import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDataSource _dataSource;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._dataSource, this._firestore);

  @override
  Stream<AuthUser?> get authStateChanges =>
      _dataSource.authStateChanges.map(_mapFirebaseUser);

  @override
  Future<AuthUser?> get currentUser async =>
      _mapFirebaseUser(_dataSource.currentUser);

  AuthUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  Future<void> _saveUserToFirestore(User user, String provider) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'authProvider': provider,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'termsAccepted': false, // To be handled in UI if needed
      });
    } else {
      await userDoc.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<Either<String, AuthUser>> loginWithGoogle() async {
    try {
      final credential = await _dataSource.signInWithGoogle();
      if (credential.user != null) {
        await _saveUserToFirestore(credential.user!, 'google');
        return Right(_mapFirebaseUser(credential.user!)!);
      }
      return const Left('Falha ao obter usuário do Google');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthUser>> loginWithEmail(
      String email, String password) async {
    try {
      final credential = await _dataSource.signInWithEmail(email, password);
      if (credential.user != null) {
        await _saveUserToFirestore(credential.user!, 'password');
        return Right(_mapFirebaseUser(credential.user!)!);
      }
      return const Left('Falha ao fazer login');
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthUser>> registerWithEmail(
      String email, String password) async {
    try {
      final credential = await _dataSource.registerWithEmail(email, password);
      if (credential.user != null) {
        await _saveUserToFirestore(credential.user!, 'password');
        return Right(_mapFirebaseUser(credential.user!)!);
      }
      return const Left('Falha ao registrar usuário');
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> recoverPassword(String email) async {
    try {
      await _dataSource.recoverPassword(email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> logout() async {
    try {
      await _dataSource.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'email-already-in-use':
        return 'Este email já está em uso.';
      case 'invalid-email':
        return 'Email inválido.';
      case 'weak-password':
        return 'A senha é muito fraca.';
      default:
        return e.message ?? 'Erro desconhecido na autenticação.';
    }
  }
}
