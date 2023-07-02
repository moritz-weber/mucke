import 'package:flutter/widgets.dart';

abstract class InitRepository {
  Future<bool> get isInitialized;
  Future<void> setInitialized();

  Future<void> initHomePage(BuildContext context);
}
