import 'package:flutter/material.dart';
import 'translate_on_hover.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

extension hoverOver on Widget {

 static final appContainer = html.window.document.getElementById('app-container');

 Widget get showCursonOnHover {
   return MouseRegion(
     child: this,
     onHover: (event) => appContainer.style.cursor = 'pointer',
     onExit: (event) => appContainer.style.cursor = 'default',
   );
 }

 Widget get moveUpOnHover {
   return TranslateOnHover(child: this);
 }
}