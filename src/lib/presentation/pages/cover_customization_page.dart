import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../gradients.dart';
import '../icons.dart';
import '../state/cover_customization_store.dart';
import '../theming.dart';
import '../widgets/playlist_cover.dart';

class CoverCustomizationPage extends StatefulWidget {
  const CoverCustomizationPage({Key? key, required this.store}) : super(key: key);

  final CoverCustomizationStore store;

  @override
  _CoverCustomizationPageState createState() => _CoverCustomizationPageState();
}

class _CoverCustomizationPageState extends State<CoverCustomizationPage> {
  @override
  Widget build(BuildContext context) {
    print('CoverCustomizationPage.build');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.customizeCover,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Observer(
        builder: (context) => Column(
          children: [
            Container(
              color: DARK1,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: PlaylistCover(
                    size: 120,
                    gradient: widget.store.gradient,
                    icon: CUSTOM_ICONS[widget.store.iconString]!,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: HORIZONTAL_PADDING,
                        vertical: HORIZONTAL_PADDING,
                      ),
                      sliver: SliverGrid.count(
                        crossAxisCount: 5,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        children: [
                          for (final gradient in CUSTOM_GRADIENTS.entries)
                            GestureDetector(
                              onTap: () => widget.store.setGradient(gradient.key),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: gradient.value,
                                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                    border: Border.all(
                                      color: gradient.key == widget.store.gradientString
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 3.0,
                                    )),
                              ),
                            )
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: HORIZONTAL_PADDING,
                        right: HORIZONTAL_PADDING,
                        bottom: HORIZONTAL_PADDING,
                      ),
                      sliver: SliverGrid.count(
                        crossAxisCount: 5,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        children: [
                          for (final icon in CUSTOM_ICONS.entries)
                            GestureDetector(
                              onTap: () => widget.store.setIconString(icon.key),
                              child: Container(
                                child: Center(
                                  child: Icon(icon.value),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                  border: Border.all(
                                    color: icon.key == widget.store.iconString
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
