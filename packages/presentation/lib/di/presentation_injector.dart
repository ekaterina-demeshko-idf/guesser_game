import 'package:get_it/get_it.dart';
import 'presentation_injector.config.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
void configurePresentationDependencies(GetIt getIt) => $initGetIt(getIt);
