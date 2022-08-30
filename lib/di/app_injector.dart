import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';

Future<void> initAppInjector() async {
  initDomainInjector();
  initPresentationInjector();
}