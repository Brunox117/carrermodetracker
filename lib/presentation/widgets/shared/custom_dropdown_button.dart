import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final String? labelText;
  final void Function(T?)? onChanged;
  final bool searchEnabled;

  const CustomDropdownButtonFormField({
    super.key,
    required this.items,
    required this.value,
    this.hintText,
    this.labelText,
    required this.onChanged,
    this.searchEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        const SizedBox(height: 8),
        if (searchEnabled)
          _buildSearchDropdown(context)
        else
          _buildRegularDropdown(context),
      ],
    );
  }

  Widget _buildSearchDropdown(BuildContext context) {
    // Convert items to a list of T values and their display strings, filtering out nulls
    final itemValues = items.map((item) => item.value).whereType<T>().toList();
    final itemLabels = items.where((item) => item.value != null).map((item) {
      if (item.child is Text) {
        return (item.child as Text).data ?? '';
      }
      return item.value.toString();
    }).toList();

    return DropdownSearch<T>(
      selectedItem: value,
      items: itemValues,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Buscar...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        constraints: const BoxConstraints(maxHeight: 300),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
      onChanged: onChanged,
      itemAsString: (T item) {
        final index = itemValues.indexOf(item);
        return index >= 0 && index < itemLabels.length
            ? itemLabels[index]
            : item.toString();
      },
    );
  }

  Widget _buildRegularDropdown(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hintText ?? ''),
          items: items,
          onChanged: onChanged,
          enableFeedback: true,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
