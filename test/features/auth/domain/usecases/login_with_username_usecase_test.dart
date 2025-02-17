import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ur_store/app/features/auth/domain/entities/login_entity.dart';
import 'package:ur_store/app/features/auth/domain/params/login_by_username_params.dart';
import 'package:ur_store/app/features/auth/domain/usecases/login_with_username_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late LoginWithUsernameUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginWithUsernameUseCase(mockRepository);
  });

  test('should get LoginEntity from repository', () async {
    const params = LoginByUsernameParams(
      username: 'username',
      password: '123456',
    );
    const loginEntity = LoginEntity(token: 'token');
    when(mockRepository.loginByUsername(any)).thenAnswer(
      (_) async => const Right(loginEntity),
    );

    final result = await usecase(params);

    expect(result, const Right(loginEntity));
    verify(mockRepository.loginByUsername(params));
    verifyNoMoreInteractions(mockRepository);
  });
}
