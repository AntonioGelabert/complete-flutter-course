
@Timeout(Duration(milliseconds: 500))
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


 class MockAuthRepository extends Mock implements FakeAuthRepository {
  
 }
void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });
group('AccountScreenController', () {
  test('initial state Asyncvalue.data', () {
    //final authRepository = MockAuthRepository();
    verifyNever(authRepository.signOut);
    //final controller = AccountScreenController(authRepository: authRepository);
    
    expect(controller.state, const AsyncData<void>(null));

  });

  test('signOut success', ()async {
    //final authRepository = MockAuthRepository();
    when(authRepository.signOut).thenAnswer((_) => Future.value());
    //final controller = AccountScreenController(authRepository: authRepository);
    expectLater(controller.stream, 
    emitsInOrder(const[
      AsyncLoading<void>(),
      AsyncData<void>(null),

    ]));
    await controller.signOut();
    verify(authRepository.signOut).called(1);
   

  },
    
  
  );
  test('signOut falliure', ()async {
    //final authRepository = MockAuthRepository();
    final exception = Exception('Connection failed');
    when(authRepository.signOut).thenThrow(exception);
    //final controller = AccountScreenController(authRepository: authRepository);
    
    expectLater(controller.stream, 
    emitsInOrder([
      const AsyncLoading<void>(),
      
      predicate<AsyncValue<void>>((p0) {expect(p0.hasError, true); return true;})

    ]));
    await controller.signOut();
   
    verify(authRepository.signOut).called(1);

  },
   
  );
  
 });
}