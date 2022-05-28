import 'package:flutter/material.dart';

class ActionIntent extends Intent {
  final ActionType type;
  const ActionIntent({required this.type});
  const ActionIntent.copy() : type = ActionType.copy;
  const ActionIntent.paste() : type = ActionType.paste;
}

enum ActionType { copy, paste }
