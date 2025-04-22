import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class CustomNumberFormField extends StatelessWidget {
  final bool isTopField;
  final bool isBottomField;
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final String? errorMessage;
  final bool allowDecimal; 
  final bool allowNegative; 
  final int maxLines;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Color? backgroundColor; 

  const CustomNumberFormField({
    super.key,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.errorMessage,
    this.allowDecimal = false, 
    this.allowNegative = false, 
    this.maxLines = 1, 
    this.initialValue = '',
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.hintStyle,
    this.backgroundColor =
        const Color.fromARGB(255, 238, 238, 255), 
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    
    final TextInputType keyboardType = TextInputType.numberWithOptions(
      signed: allowNegative,
      decimal: allowDecimal,
    );

    final List<TextInputFormatter> inputFormatters = [];
    String pattern = r'[0-9]'; 
    if (allowDecimal) {
      
      pattern += r'\.?';
    }
    if (allowNegative) {
      
      pattern = r'^-?' + pattern + r'*$'; 
      
      
      pattern = r'^-?(\d+\.?\d*|\.\d+)$';
      
      pattern = allowDecimal ? r'^-?\d*\.?\d*$' : r'^-?\d*$';
    } else {
      
      pattern = allowDecimal ? r'^\d*\.?\d*$' : r'^\d*$';
    }
    inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(pattern)));

    return Container(
      padding: const EdgeInsets.only(bottom: 8,),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: isTopField ? borderRadius : Radius.zero,
            topRight: isTopField ? borderRadius : Radius.zero,
            bottomLeft: isBottomField ? borderRadius : Radius.zero,
            bottomRight: isBottomField ? borderRadius : Radius.zero,
          ),
          boxShadow: [
            if (isBottomField)
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 5,
                  offset: const Offset(0, 3))
          ]),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(fontSize: 15, color: Colors.black54),
        maxLines: maxLines,
        initialValue: initialValue,
        decoration: InputDecoration(
          floatingLabelBehavior: maxLines > 1
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          hintStyle: hintStyle,
          errorText: errorMessage,
          focusColor: colors.primary,
        ),
      ),
    );
  }
}
