import 'package:flutter/material.dart';
import 'package:flutter_app/validators/default_validator.dart';
import 'package:flutter_app/validators/validator.dart';

class MaterialTextField extends StatefulWidget {
  final label;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String initialValue;
  final Validator validator;
  final FocusNode nodeFocus;
  final VoidCallback onFieldSubmitted;

  @override
  _MaterialTextFieldState createState() => _MaterialTextFieldState();

  MaterialTextField({
    Key key,
    this.label,
    this.obscureText = false,
    this.textInputType,
    this.initialValue,
    this.validator,
    this.textInputAction,
    this.nodeFocus,
    this.onFieldSubmitted,
  }) : super(key: key);
}

class _MaterialTextFieldState extends State<MaterialTextField> {
  var _key = GlobalKey<FormFieldState>();
  final Validator _validator = DefaultValidator();
  TextEditingController _textEditController;
  FocusNode _nodeFocus;

  _MaterialTextFieldState();

  @override
  void dispose() {
    _textEditController.dispose();
    if (widget.nodeFocus == null) _nodeFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nodeFocus = widget.nodeFocus ?? FocusNode();
    _textEditController = TextEditingController(text: widget.initialValue);
    _nodeFocus.addListener(() {
      if (_nodeFocus.hasFocus) {
        _key.currentState.reset();
      } else {
        _key.currentState.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      controller: _textEditController,
      style: buildTextStyle(),
      onFieldSubmitted: (value) =>
          {if (widget.onFieldSubmitted != null) widget.onFieldSubmitted()},
      obscureText: widget.obscureText,
      key: _key,
      focusNode: _nodeFocus,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      validator: (widget.validator ?? _validator).validate,
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
        fontFamily: "PTSans",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: Colors.blueGrey,
        decorationColor: Colors.blueGrey);
  }
}
