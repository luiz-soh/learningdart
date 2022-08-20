import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/auth_provider.dart';
import 'package:learningdart/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider._user, null);
    });

    test(
      'should be able to initialize in less than 2 secondes',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('create should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: 'souza_luiz@live.com',
        password: 'sadada',
      );

      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        email: 'stersste@trses.com',
        password: 'teste12345',
      );

      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        email: 'stersste@trses.com',
        password: 'asdasdas',
      );

      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('LogIn user should be able to get verified', () async {
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to log out and log in again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();

    await Future.delayed(const Duration(seconds: 1));

    return await logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'souza_luiz@live.com') throw UserNotFoundAuthException();
    if (password == 'teste12345') throw WrongPasswordAuthException();

    final user = AuthUser(id: 'myid', isEmailVerified: false, email: email,);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();

    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;

    if (user == null) throw UserNotFoundAuthException();

    final newUser = AuthUser(id: 'myid', isEmailVerified: true, email: user.email);
    _user = newUser;
  }
  
  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();
  }
}
