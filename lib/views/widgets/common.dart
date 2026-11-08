import 'package:flutter/material.dart';

const Color pageBackgroundColor = Color(0xFFF5F5F7);
const Color accentColor = Color(0xFF1E6FEB);
const Color mutedTextColor = Color(0xFF8A8A8E);
const Color warningColor = Color(0xFFE8890C);
const Color dangerColor = Color(0xFFD64545);

/// Formats a number as money, for example $25.50.
String formatMoney(double amount) => '\$${amount.toStringAsFixed(2)}';

/// Formats a date as day/month/year.
String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

/// Converts text to a decimal number (accepts a comma or a dot). Returns null if invalid.
double? parseDecimal(String text) {
  return double.tryParse(text.trim().replaceAll(',', '.'));
}

/// Shows a short message at the bottom of the screen.
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

/// Waits for an action result and shows its error message, if there is one.
Future<void> showResult(BuildContext context, Future<String?> pendingResult) async {
  final errorMessage = await pendingResult;
  if (errorMessage != null && context.mounted) {
    showMessage(context, errorMessage);
  }
}

/// Style shared by every text field: white, rounded and without border.
InputDecoration fieldDecoration(String label, {IconData? prefixIcon}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

/// Big title shown at the top of each main screen.
class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.title, {super.key});

  final String title;

  /// Builds the title text.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// Small title of a section, with an optional "add" button.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onAdd});

  final String title;
  final VoidCallback? onAdd;

  /// Builds the title and the add button (only if onAdd is given).
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          if (onAdd != null)
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: accentColor,
              onPressed: onAdd,
            ),
        ],
      ),
    );
  }
}

/// White rounded card, the basic building block of the app.
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderColor,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  final EdgeInsets padding;

  /// Builds the card, tappable when onTap is given.
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Gray centered text used when a list is empty.
class EmptyMessage extends StatelessWidget {
  const EmptyMessage(this.message, {super.key});

  final String message;

  /// Builds the message.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: mutedTextColor),
        ),
      ),
    );
  }
}
