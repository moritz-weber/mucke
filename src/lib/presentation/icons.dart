import 'package:flutter/material.dart';

const CUSTOM_ICONS = <String, IconData>{
  'favorite_rounded': Icons.favorite_rounded,
  'lightbulb_rounded': Icons.lightbulb_rounded,
  'thumb_up_rounded': Icons.thumb_up_rounded,
  'thumb_down_rounded': Icons.thumb_down_rounded,
  'star_rounded': Icons.star_rounded,
  'work_rounded': Icons.work_rounded,
  'code_rounded': Icons.code_rounded,
  'explore_rounded': Icons.explore_rounded,
  'alarm_rounded': Icons.alarm_rounded,
  'offline_bolt_rounded': Icons.offline_bolt_rounded,
  'rocket_launch_rounded': Icons.rocket_launch_rounded,
  'commute_rounded': Icons.commute_rounded,
  'anchor_rounded': Icons.anchor_rounded,
  'auto_awesome_rounded': Icons.auto_awesome_rounded,
  'sentiment_satisfied_rounded': Icons.sentiment_satisfied_rounded,
  'sentiment_very_satisfied_rounded': Icons.sentiment_very_satisfied_rounded,
  'sentiment_dissatisfied_rounded': Icons.sentiment_dissatisfied_rounded,
  'sports_esports_rounded': Icons.sports_esports_rounded,
  'travel_explore_rounded': Icons.travel_explore_rounded,
  'self_improvement_rounded': Icons.self_improvement_rounded,
  'nights_stay_rounded': Icons.nights_stay_rounded,
  'heart_broken_rounded': Icons.heart_broken_rounded,
  'weekend_rounded': Icons.weekend_rounded,
  'queue_music_rounded': Icons.queue_music_rounded,
  'light_mode_rounded': Icons.light_mode_rounded,
  'sports_bar_rounded': Icons.sports_bar_rounded,
  'fitness_center_rounded': Icons.fitness_center_rounded,
};

extension StringIconExtension on String {
  IconData? toIcon() {
    return CUSTOM_ICONS[this];
  }
}