@Timeout(Duration(milliseconds: 500))
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../account/account_screen_controller_test.dart';


void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';

  group('submit', () { 
    test('''
Given fomtype is signIn
when signInWithEmailAndPassword succeeds
Then return true
And state is AsyncData


''', () async {
    final authRepository = MockAuthRepository();
    when(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword)).thenAnswer((invocation) => Future.value());

    final controller = EmailPasswordSignInController(
     formType: EmailPasswordSignInFormType.signIn,
     authRepository: authRepository);
     expectLater(controller.stream, emitsInOrder([
EmailPasswordSignInState(
  formType: EmailPasswordSignInFormType.signIn,
  value: const AsyncLoading<void>()
  ),
  EmailPasswordSignInState(
    formType: EmailPasswordSignInFormType.signIn,
    value: const AsyncData(null),
    ),

     ]));

     final result = await controller.submit(testEmail, testPassword);

     expect(result, true);
}, 
);

  });
  group('updateFormType', () {

    test('''
Given fomtype is signIn
when signInWithEmailAndPassword fails
Then return false
And state is AsyncError


''', () async {
    final authRepository = MockAuthRepository();
    final exception = Exception('Connection failed');
    when(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword
    )).thenThrow(exception);

    final controller = EmailPasswordSignInController(
     formType: EmailPasswordSignInFormType.signIn,
     authRepository: authRepository);
     expectLater(controller.stream, emitsInOrder([
EmailPasswordSignInState(
  formType: EmailPasswordSignInFormType.signIn,
  value: const AsyncLoading<void>()
  ),
  predicate<EmailPasswordSignInState>((p0) {
    expect(p0.formType, EmailPasswordSignInFormType.signIn);
    expect(p0.value.hasError, true);
    return true;
  })

     ]));

     final result = await controller.submit(testEmail, testPassword);

     expect(result, false);
}, 
);
test(
  '''
Given fomtype is register
when createUserWithEmailAnd Password succeeds
Then return true
And state is AsyncData


''', () async {
    final authRepository = MockAuthRepository();
    when(() => authRepository.createUserWithEmailAndPassword(
      testEmail, testPassword)).thenAnswer((invocation) => Future.value());

    final controller = EmailPasswordSignInController(
     formType: EmailPasswordSignInFormType.register,
     authRepository: authRepository);
     expectLater(controller.stream, emitsInOrder([
EmailPasswordSignInState(
  formType: EmailPasswordSignInFormType.register,
  value: const AsyncLoading<void>()
  ),
  EmailPasswordSignInState(
    formType: EmailPasswordSignInFormType.register,
    value: const AsyncData(null),
    ),

     ]));

     final result = await controller.submit(testEmail, testPassword);

     expect(result, true);
}, 
);

test('''
Given fomtype is register
when createUserWithEmailAndPassword fails
Then return false
And state is AsyncError


''', () async {
    final authRepository = MockAuthRepository();
    final exception = Exception('Connection failed');
    when(() => authRepository.createUserWithEmailAndPassword(testEmail, testPassword
    )).thenThrow(exception);

    final controller = EmailPasswordSignInController(
     formType: EmailPasswordSignInFormType.register,
     authRepository: authRepository);
     expectLater(controller.stream, emitsInOrder([
EmailPasswordSignInState(
  formType: EmailPasswordSignInFormType.register,
  value: const AsyncLoading<void>()
  ),
  predicate<EmailPasswordSignInState>((p0) {
    expect(p0.formType, EmailPasswordSignInFormType.register);
    expect(p0.value.hasError, true);
    return true;
  })

     ]));

     final result = await controller.submit(testEmail, testPassword);

     expect(result, false);
}, 
);

   });

   group('updateFormtype', () {

    test('''
   Given formType is signIn
   When Called with register
   then formtype is register   
''', () {
     final authRepository = MockAuthRepository();
     final controller = EmailPasswordSignInController(formType: EmailPasswordSignInFormType.signIn, authRepository: authRepository);

     controller.updateFormType(EmailPasswordSignInFormType.register);

     expect(controller.state, EmailPasswordSignInState(formType: EmailPasswordSignInFormType.register,
     value: AsyncData<void>(null)));

});
    test('''
   Given formType is register
   When Called with signIn
   then formtype is signIn   
''', () {
     final authRepository = MockAuthRepository();
     final controller = EmailPasswordSignInController(formType: EmailPasswordSignInFormType.register, authRepository: authRepository);

     controller.updateFormType(EmailPasswordSignInFormType.signIn);

     expect(controller.state, EmailPasswordSignInState(formType: EmailPasswordSignInFormType.signIn,
     value: AsyncData<void>(null)));

});

    });
   
   }