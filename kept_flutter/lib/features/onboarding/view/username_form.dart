import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../product/theme/kept_theme.dart';
import '../../../product/components/kept_widgets.dart';
import '../data/auth_flow.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

/// Shared @username field used during registration and fallback setup.
class UsernameForm extends StatefulWidget {
  const UsernameForm({
    super.key,
    required this.onSubmit,
    this.busy = false,
    this.initialUsername,
    this.title,
    this.subtitle,
    this.buttonLabel,
  });

  final Future<void> Function(String username) onSubmit;
  final bool busy;
  final String? initialUsername;
  final String? title;
  final String? subtitle;
  final String? buttonLabel;

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  late final TextEditingController _controller;
  final _focus = FocusNode();
  String? _error;
  bool _localBusy = false;

  bool get _busy => widget.busy || _localBusy;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialUsername ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!const AuthFlow().isUsernameValid(_controller.text)) {
      setState(() => _error = LocaleKeys.usernameRules.tr());
      return;
    }

    setState(() {
      _localBusy = true;
      _error = null;
    });
    try {
      await widget.onSubmit(_controller.text.trim().toLowerCase());
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _localBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title ?? LocaleKeys.chooseUsername.tr(),
          style: GoogleFonts.sora(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.15,
            letterSpacing: -0.7,
            color: context.kept.paper,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.subtitle ?? LocaleKeys.usernameSubtitle.tr(),
          style: GoogleFonts.manrope(
            fontSize: 14,
            height: 1.45,
            color: context.kept.mist,
          ),
        ),
        const SizedBox(height: 28),
        TextField(
          controller: _controller,
          focusNode: _focus,
          enabled: !_busy,
          autofocus: true,
          style: GoogleFonts.manrope(
            color: context.kept.paper,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          cursorColor: KeptTheme.accent,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
            LengthLimitingTextInputFormatter(30),
            TextInputFormatter.withFunction((oldValue, newValue) {
              return newValue.copyWith(text: newValue.text.toLowerCase());
            }),
          ],
          decoration: InputDecoration(
            prefixText: '@',
            prefixStyle: GoogleFonts.manrope(
              color: context.kept.mist,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            hintText: LocaleKeys.usernameHint.tr(),
            hintStyle: GoogleFonts.manrope(color: context.kept.mist),
            filled: true,
            fillColor: context.kept.ink,
            errorText: _error,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.kept.line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.kept.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: KeptTheme.accent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: KeptTheme.broke),
            ),
          ),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 24),
        if (_busy)
          const Center(child: CircularProgressIndicator.adaptive())
        else
          KeptPrimaryButton(
            label: widget.buttonLabel ?? LocaleKeys.continueAction.tr(),
            onPressed: _submit,
          ),
      ],
    );
  }
}
