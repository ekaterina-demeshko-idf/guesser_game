import 'package:domain/usecase/check_state_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:get_it/get_it.dart';
import '../screen/main_my_bloc.dart';

void initPresentationInjector() {
  _initBlocModule();
}

void _initBlocModule() {
  GetIt.I.registerFactory<MainBloc>(
    () => MainBloc(
      GetIt.I.get<CheckStateUseCase>(),
      GetIt.I.get<GenerateNumberUseCase>(),
    ),
  );
}
