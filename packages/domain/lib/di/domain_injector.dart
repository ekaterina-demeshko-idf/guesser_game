import 'package:get_it/get_it.dart';
import '../usecase/check_state_usecase.dart';
import '../usecase/generate_number_usecase.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<CheckStateUseCase>(
    () => CheckStateUseCase(),
  );

  GetIt.I.registerFactory<GenerateNumberUseCase>(
    () => GenerateNumberUseCase(),
  );
}
