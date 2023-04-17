import 'package:flutter/material.dart';

const CUSTOM_GRADIENTS = <String, Gradient>{
  'sanguine': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFBB03B),
        Color(0xFFD4145A),
      ],
    ),
  'oceanblue': 
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1BFFFF),
        Color(0xFF2E3192),
      ],
  ),
  'lime': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFCEE21),
        Color(0xFF2E9200),
      ],
  ),
  'purplelake': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFED1E79),
        Color(0xFF662D8C),
      ],
  ),
  'piglet': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFFDDE1),
        Color(0xFFEE9CA7),
      ],
  ),
  'kashmir': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF516395),
        Color(0xFF614385),
      ],
  ),
  'quepal': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF38EF7D),
        Color(0xFF11998E),
      ],
  ),
  'cactus': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFC6EA8D),
        Color(0xFFFE90AF),
      ],
  ),
  'antarctica': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFD8B5FF),
        Color(0xFF1EAE98),
      ],
    ),
  'toxic': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFBFF098),
        Color(0xFF6FD6FF),
      ],
  ),
};

extension StringGradientExtension on String {
  Gradient? toIcon() {
    return CUSTOM_GRADIENTS[this];
  }
}