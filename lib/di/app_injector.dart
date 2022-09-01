import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit()
void configureDependencies() {
  configureDomainDependencies(getIt);
  configurePresentationDependencies(getIt);
}
