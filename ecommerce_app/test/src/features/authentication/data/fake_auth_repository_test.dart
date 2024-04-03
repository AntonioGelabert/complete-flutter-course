import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';
  final testUser =
      AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);
  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group('FakeAthRepository', () {
    test('current user is null', () {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('currentUser is not null after sign in', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });
    test('currentUser is not null after resgistration', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await authRepository.createUserWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });

    test('current user is null after sign our', ()async {
        final authrepository = makeAuthRepository();
        addTearDown(authrepository.dispose);
        await authrepository.signInWithEmailAndPassword(testEmail, testPassword);

        expect(authrepository.currentUser, testUser);
        expect(authrepository.authStateChanges(), emits(testUser));
       
        await authrepository.signOut();
        expect(authrepository.currentUser, null);
        expect(authrepository.authStateChanges(), emits(null));
    });

      test('sign in after dispose throws exception', () {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        authRepository.dispose();
        expect(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword), throwsStateError);

      });
  });
}
