import 'package:flutter/material.dart';

import 'common.dart';

/// Kind of value a form field accepts.
/// text: any text. integer: whole number without signs. money: amount with up to 2 decimals.
/// phone: phone number. plate: vehicle plate. code: part code (letters, digits, - and _).
enum FieldKind { text, integer, money, phone, plate, code }

/// Description of one field of a form dialog, including its validation rules.
class FormFieldSpec {
  const FormFieldSpec({
    required this.label,
    this.kind = FieldKind.text,
    this.isRequired = true,
    this.initialValue = '',
    this.minLength = 1,
    this.maxLength = 60,
    this.minValue,
    this.maxValue,
  });

  final String label;
  final FieldKind kind;
  final bool isRequired;
  final String initialValue;
  final int minLength;
  final int maxLength;
  final double? minValue;
  final double? maxValue;
}

/// Biggest number accepted when a numeric field has no maximum of its own.
const double defaultMaxNumber = 1000000000;

/// Shows a dialog with the given fields. Returns the typed values in order,
/// or null if the user cancelled. Every value returned is already validated.
Future<List<String>?> showFormDialog(
  BuildContext context, {
  required String title,
  required List<FormFieldSpec> fields,
  String confirmLabel = 'Guardar',
}) {
  return showDialog<List<String>>(
    context: context,
    builder: (context) {
      return _FormDialog(
        title: title,
        fields: fields,
        confirmLabel: confirmLabel,
      );
    },
  );
}

class _FormDialog extends StatefulWidget {
  const _FormDialog({
    required this.title,
    required this.fields,
    required this.confirmLabel,
  });

  final String title;
  final List<FormFieldSpec> fields;
  final String confirmLabel;

  @override
  State<_FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<_FormDialog> {
  final formKey = GlobalKey<FormState>();
  late final List<TextEditingController> controllers = widget.fields
      .map((field) => TextEditingController(text: field.initialValue))
      .toList();

  /// Frees the text controllers.
  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Writes a limit without useless decimals (5 instead of 5.0).
  String formatLimit(double limit) {
    if (limit == limit.roundToDouble()) {
      return limit.toInt().toString();
    }
    return limit.toStringAsFixed(2);
  }

  /// Checks a phone number: only digits, spaces, dashes and an optional + at the start.
  String? validatePhone(String value) {
    final digitCount = value.replaceAll(RegExp(r'[^0-9]'), '').length;
    final hasValidCharacters = RegExp(r'^\+?[0-9 \-]+$').hasMatch(value);
    if (!hasValidCharacters || digitCount < 7 || digitCount > 15) {
      return 'Teléfono no válido (de 7 a 15 dígitos)';
    }
    return null;
  }

  /// Checks a number (whole or money) and that it is inside the allowed range.
  String? validateNumber(FormFieldSpec field, String value) {
    final double number;
    if (field.kind == FieldKind.integer) {
      if (!RegExp(r'^\d+$').hasMatch(value)) {
        return 'Escribe un número entero, sin signos ni decimales';
      }
      number = double.parse(value);
    } else {
      if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(value)) {
        return 'Escribe un monto válido (máximo 2 decimales)';
      }
      number = parseDecimal(value)!;
    }

    final lowerLimit = field.minValue;
    final upperLimit = field.maxValue ?? defaultMaxNumber;
    if (lowerLimit != null && number < lowerLimit) {
      return 'Debe ser al menos ${formatLimit(lowerLimit)}';
    }
    if (number > upperLimit) {
      return 'No puede ser mayor que ${formatLimit(upperLimit)}';
    }
    return null;
  }

  /// Returns an error message for a field, or null if its value is valid.
  String? validateField(FormFieldSpec field, String? text) {
    final value = (text ?? '').trim();
    if (value.isEmpty) {
      return field.isRequired ? 'Campo obligatorio' : null;
    }
    if (value.length < field.minLength) {
      return 'Mínimo ${field.minLength} caracteres';
    }
    if (value.length > field.maxLength) {
      return 'Máximo ${field.maxLength} caracteres';
    }

    switch (field.kind) {
      case FieldKind.text:
        return null;
      case FieldKind.phone:
        return validatePhone(value);
      case FieldKind.plate:
        final isValidPlate = RegExp(r'^[A-Za-z0-9][A-Za-z0-9 \-]*$').hasMatch(value);
        return isValidPlate ? null : 'Solo letras, números, espacios y guiones';
      case FieldKind.code:
        final isValidCode = RegExp(r'^[A-Za-z0-9\-_]+$').hasMatch(value);
        return isValidCode ? null : 'Solo letras, números, guiones y _ (sin espacios)';
      case FieldKind.integer:
      case FieldKind.money:
        return validateNumber(field, value);
    }
  }

  /// Closes the dialog returning the values, only if every field is valid.
  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final values = controllers.map((controller) => controller.text.trim()).toList();
    Navigator.of(context).pop(values);
  }

  /// Chooses the keyboard that fits each kind of field.
  TextInputType keyboardFor(FieldKind kind) {
    switch (kind) {
      case FieldKind.integer:
        return TextInputType.number;
      case FieldKind.money:
        return const TextInputType.numberWithOptions(decimal: true);
      case FieldKind.phone:
        return TextInputType.phone;
      case FieldKind.text:
      case FieldKind.plate:
      case FieldKind.code:
        return TextInputType.text;
    }
  }

  /// Chooses how letters are capitalized for each kind of field.
  TextCapitalization capitalizationFor(FieldKind kind) {
    switch (kind) {
      case FieldKind.text:
        return TextCapitalization.sentences;
      case FieldKind.plate:
      case FieldKind.code:
        return TextCapitalization.characters;
      case FieldKind.integer:
      case FieldKind.money:
      case FieldKind.phone:
        return TextCapitalization.none;
    }
  }

  /// Builds the dialog with one text field per FormFieldSpec.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int index = 0; index < widget.fields.length; index++)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextFormField(
                    controller: controllers[index],
                    autofocus: index == 0,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: keyboardFor(widget.fields[index].kind),
                    textCapitalization: capitalizationFor(widget.fields[index].kind),
                    decoration: fieldDecoration(
                      widget.fields[index].isRequired
                          ? widget.fields[index].label
                          : '${widget.fields[index].label} (opcional)',
                    ),
                    validator: (text) => validateField(widget.fields[index], text),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: submit, child: Text(widget.confirmLabel)),
      ],
    );
  }
}
