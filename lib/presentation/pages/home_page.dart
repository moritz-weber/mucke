import 'package:flutter/material.dart';

import '../theming.dart';
import '../widgets/highlight.dart';
import '../widgets/highlight_artist.dart';
import '../widgets/shuffle_all_button.dart';
import '../widgets/smart_lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('HomePage.build');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            // style: TEXT_HEADER,
          ),
        ),
        body: Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 12.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                      child: Highlight(),
                    ),
                    const SizedBox(height: 12.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                      child: HighlightArtist(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: HORIZONTAL_PADDING,
                        right: HORIZONTAL_PADDING,
                        top: 20.0,
                        bottom: 14.0,
                      ),
                      child: ShuffleAllButton(
                        verticalPad: 0.0,
                        horizontalPad: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SmartLists(),
            ],
          ),
        ),
      ),
    );
  }
}
