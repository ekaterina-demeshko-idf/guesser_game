import 'package:domain/usecase/check_state_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:get_it/get_it.dart';
import '../screen/main_my_bloc.dart';

void initPresentationInjector() {
  _initMainScreenModule();
}

void _initMainScreenModule() {
  GetIt.I.registerFactory(
    () => MainBloc(
      GetIt.I.get<CheckStateUseCase>(),
      GetIt.I.get<GenerateNumberUseCase>(),
    ),
  );
}
