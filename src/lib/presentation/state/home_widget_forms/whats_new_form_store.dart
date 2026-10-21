import 'package:mobx/mobx.dart';

import '../../../domain/entities/home_widgets/whats_new.dart';
import '../../../domain/repositories/home_widget_repository.dart';

part 'whats_new_form_store.g.dart';

class WhatsNewFormStore extends _WhatsNewFormStore with _$WhatsNewFormStore {
  WhatsNewFormStore({
    required HomeWidgetRepository homeWidgetRepository,
    required HomeWhatsNew homeWhatsNew,
  }) : super(homeWidgetRepository, homeWhatsNew);
}

abstract class _WhatsNewFormStore with Store {
  _WhatsNewFormStore(
    this._homeWidgetRepository,
    this._whatsNew,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  final HomeWhatsNew _whatsNew;

  @observable
  late bool autoDismiss = _whatsNew.autoDismiss;

  Future<void> save() async {
    await _homeWidgetRepository.updateHomeWidget(
      HomeWhatsNew(
        position: _whatsNew.position,
        dismissed: _whatsNew.dismissed,
        autoDismiss: autoDismiss,
      ),
    );
  }
}
