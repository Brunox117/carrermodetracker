import 'package:flutter/material.dart';

class CustomMultiDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final List<T> selectedValues;
  final String? hintText;
  final String? labelText;
  final void Function(List<T>)? onChanged;
  final bool Function(T, T)? equals;

  const CustomMultiDropdownButton({
    super.key,
    required this.items,
    required this.selectedValues,
    this.hintText,
    this.labelText,
    required this.onChanged,
    this.equals,
  });

  bool _isValueSelected(T value) {
    if (equals != null) {
      return selectedValues.any((element) => equals!(element, value));
    }
    return selectedValues.contains(value);
  }

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
        InputDecorator(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                value: selectedValues.isNotEmpty ? selectedValues.first : null,
                hint: Text(selectedValues.isEmpty
                    ? (hintText ?? '')
                    : '${selectedValues.length} seleccionados'),
                items: items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item.value,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isValueSelected(item.value as T),
                          onChanged: (bool? value) {
                            if (value == true) {
                              onChanged?.call([...selectedValues, item.value as T]);
                            } else {
                              if (equals != null) {
                                onChanged?.call(
                                  selectedValues
                                      .where((v) => !equals!(v, item.value as T))
                                      .toList(),
                                );
                              } else {
                                onChanged?.call(
                                  selectedValues
                                      .where((v) => v != item.value)
                                      .toList(),
                                );
                              }
                            }
                          },
                        ),
                        Expanded(child: item.child),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (T? value) {
                  if (value != null) {
                    if (!_isValueSelected(value)) {
                      onChanged?.call([...selectedValues, value]);
                    } else {
                      if (equals != null) {
                        onChanged?.call(
                          selectedValues
                              .where((v) => !equals!(v, value))
                              .toList(),
                        );
                      } else {
                        onChanged?.call(
                          selectedValues.where((v) => v != value).toList(),
                        );
                      }
                    }
                  }
                },
                enableFeedback: true,
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(Icons.arrow_drop_down),
                selectedItemBuilder: (BuildContext context) {
                  return items.map((item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedValues.isEmpty
                            ? (hintText ?? '')
                            : '${selectedValues.length} seleccionados',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
