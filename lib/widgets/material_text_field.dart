import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

class MaterialTextField extends StatefulWidget {
  final label;
  final _key = GlobalKey<FormFieldState>();

  @override
  _MaterialTextFieldState createState() => _MaterialTextFieldState();

  MaterialTextField({this.label});
}

class _MaterialTextFieldState extends State<MaterialTextField> {
  final _focusNode = FocusNode();
  final _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _textFieldController.clear();
      } else {
        widget._key.currentState.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget._key,
      focusNode: _focusNode,
      controller: _textFieldController,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).fieldValidationErrorMessage(widget.label);
        }
        return null;
      },
    );
  }
}
