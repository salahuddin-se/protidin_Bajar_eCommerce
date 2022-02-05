import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enum for [CustomSelectorButton] types.
///
/// Available type includes:
///   * [PhoneInputSelectorType.DROPDOWN]
///   * [PhoneInputSelectorType.BOTTOM_SHEET]
///   * [PhoneInputSelectorType.DIALOG]

/// A [TextFormField] for [CustomInternationalPhoneNumberInput].
///
/// [initialValue] accepts a [PhoneNumber] this is used to set initial values
/// for phone the input field and the selector button
///
/// [selectorButtonOnErrorPadding] is a double which is used to align the selector
/// button with the input field when an error occurs
///
/// [locale] accepts a country locale which will be used to translation, if the
/// translation exist
///
/// [countries] accepts list of string on Country isoCode, if specified filters
/// available countries to match the [countries] specified.
class CustomInternationalPhoneNumberInput extends StatefulWidget {
  //final SelectorConfig selectorConfig;

  //final ValueChanged<PhoneNumber> onInputChanged;
  final ValueChanged<bool> onInputValidated;

  final VoidCallback onSubmit;
  final ValueChanged<String> onFieldSubmitted;
  final String Function(String)? validator;
  //final ValueChanged<PhoneNumber> onSaved;

  final TextEditingController textFieldController;
  final TextInputType keyboardType;
  final TextInputAction? keyboardAction;

  //final PhoneNumber initialValue;
  final String hintText;
  final String errorMessage;

  final double selectorButtonOnErrorPadding;
  final double spaceBetweenSelectorAndTextField;
  final int maxLength;

  final bool isEnabled;
  final bool formatInput;
  final bool autoFocus;
  final bool autoFocusSearch;
  final AutovalidateMode autoValidateMode;
  final bool ignoreBlank;
  final bool countrySelectorScrollControlled;

  final String locale;

  final TextStyle textStyle;
  final TextStyle selectorTextStyle;
  final InputBorder inputBorder;
  final InputDecoration inputDecoration;
  final InputDecoration searchBoxDecoration;
  final Color cursorColor;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final EdgeInsets scrollPadding;

  final FocusNode focusNode;
  final Iterable<String> autofillHints;

  final List<String> countries;

  var selectorConfig;

  var onInputChanged;

  var initialValue;

  var onSaved;

  CustomInternationalPhoneNumberInput({
    required Key? key,
    //this.selectorConfig = const SelectorConfig(),
    @required this.onInputChanged,
    required this.onInputValidated,
    required this.onSubmit,
    required this.onFieldSubmitted,
    required this.validator,
    required this.onSaved,
    required this.textFieldController,
    required this.keyboardAction,
    this.keyboardType = TextInputType.phone,
    this.initialValue,
    this.hintText = 'Phone number',
    this.errorMessage = 'Invalid phone number',
    this.selectorButtonOnErrorPadding = 24,
    this.spaceBetweenSelectorAndTextField = 12,
    this.maxLength = 15,
    this.isEnabled = true,
    this.formatInput = true,
    this.autoFocus = false,
    this.autoFocusSearch = false,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.ignoreBlank = false,
    this.countrySelectorScrollControlled = true,
    required this.locale,
    required this.textStyle,
    required this.selectorTextStyle,
    required this.inputBorder,
    required this.inputDecoration,
    required this.searchBoxDecoration,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    required this.focusNode,
    required this.autofillHints,
    required this.countries,
    required this.cursorColor,
    required this.scrollPadding,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class Country {}

class WidgetView {}

/// [CustomSelectorButton]
