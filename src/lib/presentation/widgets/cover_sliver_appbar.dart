
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../state/navigation_store.dart';
import '../theming.dart';

class CoverSliverAppBar extends StatefulWidget {
  const CoverSliverAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.subtitle2,
    required this.actions,
    required this.cover,
    required this.backgroundColor,
    this.button,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? subtitle2;
  final List<Widget> actions;
  final Widget cover;
  final Color backgroundColor;
  final Widget? button;

  @override
  State<CoverSliverAppBar> createState() => _CoverSliverAppBarState();
}

class _CoverSliverAppBarState extends State<CoverSliverAppBar> {
  double get maxHeight => 220 + MediaQuery.of(context).padding.top;
  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  Widget build(BuildContext context) {
    final navStore = GetIt.I<NavigationStore>();

    return SliverAppBar(
      pinned: true,
      expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Header(
        minHeight: minHeight,
        maxHeight: maxHeight,
        backgroundColor: widget.backgroundColor,
        cover: widget.cover,
        title: widget.title,
        subtitle: widget.subtitle,
        subtitle2: widget.subtitle2,
        button: widget.button,
      ),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: () => navStore.pop(context),
      ),
      actions: widget.actions,
      snap: true,
      floating: true,
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.maxHeight,
    required this.minHeight,
    required this.title,
    this.subtitle,
    this.subtitle2,
    required this.cover,
    required this.backgroundColor,
    this.button,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? subtitle2;
  final Widget cover;
  final Color backgroundColor;
  final double maxHeight;
  final double minHeight;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final expandRatio2 = _calculateExpandRatio2(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);
        final animation2 = AlwaysStoppedAnimation(expandRatio2);

        return Stack(
          fit: StackFit.expand,
          children: [
            _buildGradient(animation, context),
            _buildImage(animation, context),
            if (button != null) _buildButton(animation, context),
            _buildTitle(
              animation,
              animation2,
              context,
              title: title,
              subtitle: subtitle,
              subtitle2: subtitle2,
            ),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio = (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  double _calculateExpandRatio2(BoxConstraints constraints) {
    var expandRatio = (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0)
      expandRatio = 1.0;
    else if (expandRatio < 0.8)
      expandRatio = 0.0;
    else
      expandRatio = (expandRatio - 0.8) * 5;
    return expandRatio;
  }

  Align _buildTitle(
    Animation<double> animation,
    Animation<double> animation2,
    BuildContext context, {
    required String title,
    String? subtitle,
    String? subtitle2,
  }) {
    // TODO: padding right for enabled multi select
    return Align(
      alignment: AlignmentTween(
        begin: Alignment.center,
        end: Alignment.topLeft,
      ).evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(
          top: Tween<double>(
            begin: MediaQuery.of(context).padding.top,
            end: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
          ).evaluate(animation),
          left: Tween<double>(begin: 56, end: 152).evaluate(animation),
          right: Tween<double>(begin: 56, end: 16).evaluate(animation),
          bottom: Tween<double>(begin: 0, end: 16).evaluate(animation),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Tween<double>(begin: 16, end: 24).evaluate(animation),
                color: Colors.white,
                fontWeight: FontWeight.lerp(
                  FontWeight.w400,
                  FontWeight.w600,
                  Tween<double>(begin: 0, end: 1).evaluate(animation),
                ),
                height: 1.1,
              ),
            ),
            Container(
              height: Tween<double>(begin: 0, end: 8).evaluate(animation),
              width: 10.0,
            ),
            if (subtitle != null)
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: Tween<double>(begin: 0, end: 16).evaluate(animation),
                  color: Colors.white
                      .withOpacity(Tween<double>(begin: 0, end: 1).evaluate(animation2)),
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (subtitle2 != null)
              Text(
                subtitle2,
                style: TextStyle(
                  fontSize: Tween<double>(begin: 0, end: 13).evaluate(animation),
                  color: Colors.white
                      .withOpacity(Tween<double>(begin: 0, end: 1).evaluate(animation2)),
                  fontWeight: FontWeight.w300,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(Animation<double> animation, BuildContext context) {
    return Positioned(
      width: 96,
      height: 56,
      right: HORIZONTAL_PADDING,
      top: Tween<double>(
        begin: kToolbarHeight + MediaQuery.of(context).padding.top + 120,
        end: kToolbarHeight + MediaQuery.of(context).padding.top + 72 + 24,
      ).evaluate(animation),
      child: Align(child: button!, alignment: Alignment.bottomRight),
    );
  }

  Widget _buildImage(Animation<double> animation, BuildContext context) {
    return Positioned(
      width: 120,
      height: 120,
      left: HORIZONTAL_PADDING,
      top: Tween<double>(
        begin: kToolbarHeight + MediaQuery.of(context).padding.top + 180,
        end: kToolbarHeight + MediaQuery.of(context).padding.top,
      ).evaluate(animation),
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: cover,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
      ),
    );
  }

  Container _buildGradient(Animation<double> animation, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor,
            ColorTween(
                  begin: backgroundColor,
                  end: Theme.of(context).scaffoldBackgroundColor,
                ).evaluate(animation) ??
                Colors.transparent,
          ],
          stops: const [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
