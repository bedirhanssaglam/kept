import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:cupertino_native/cupertino_native.dart';

import '../../../client.dart';
import '../../../core/layout/kept_breakpoints.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_native.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../data/vow_repository.dart';
import '../../auth/presentation/sign_in_sheet.dart';

class CreateVowScreen extends StatefulWidget {
  const CreateVowScreen({
    super.key,
    this.asTab = false,
    this.onCreated,
  });

  /// When true, renders as a bottom-nav tab (no back AppBar).
  final bool asTab;

  /// Called after a successful create when [asTab] is true.
  final ValueChanged<VowRoom>? onCreated;

  @override
  State<CreateVowScreen> createState() => _CreateVowScreenState();
}

class _CreateVowScreenState extends State<CreateVowScreen> {
  final _repo = VowRepository();
  final _title = TextEditingController();
  final _rule = TextEditingController();
  String _category = 'health';
  String _joinPolicy = 'open';
  bool _saving = false;
  String? _error;

  static const _categories = [
    ('health', 'Health'),
    ('quit', 'Quit'),
    ('move', 'Move'),
    ('focus', 'Focus'),
    ('custom', 'Custom'),
  ];

  static const _policies = [
    ('open', 'Open', 'Anyone can join'),
    ('approval', 'Approval', 'Admin must approve'),
    ('invite', 'Invite', 'Code required'),
    ('closed', 'Closed', 'No new members'),
  ];

  @override
  void dispose() {
    _title.dispose();
    _rule.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!client.auth.isAuthenticated) {
      final ok = await showSignInSheet(context);
      if (!ok || !mounted) return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final room = await _repo.createRoom(
        title: _title.text,
        rule: _rule.text,
        category: _category,
        joinPolicy: _joinPolicy,
      );
      if (!mounted) return;
      _title.clear();
      _rule.clear();
      if (widget.asTab) {
        widget.onCreated?.call(room);
      } else {
        Navigator.of(context).pop(room);
      }
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = LayoutBuilder(
      builder: (context, constraints) {
        final sidePad = constraints.maxWidth > KeptBreakpoints.contentMax
            ? (constraints.maxWidth - KeptBreakpoints.contentMax) / 2
            : 0.0;
        return ListView(
          padding: EdgeInsets.fromLTRB(
            22 + sidePad,
            widget.asTab ? 18 : 8,
            22 + sidePad,
            40,
          ),
          children: [
            if (widget.asTab) ...[
              Text(
                'KEPT',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.5,
                  color: KeptTheme.accent,
                ),
              ),
              const SizedBox(height: 10),
            ],
            Text(
              'Make a new vow',
              style: GoogleFonts.sora(
                fontSize: widget.asTab ? 30 : 28,
                fontWeight: FontWeight.w700,
                height: 1.15,
                color: KeptTheme.paper,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'If it isn’t here yet, invent it. Clear title. Clear daily rule. People join what they can measure.',
              style: GoogleFonts.manrope(color: KeptTheme.mist, height: 1.45),
            ),
            const SizedBox(height: 28),
            Text('Title', style: GoogleFonts.manrope(color: KeptTheme.mist)),
            const SizedBox(height: 8),
            TextField(
              controller: _title,
              style: const TextStyle(color: KeptTheme.paper),
              decoration: _inputDecoration('e.g. Drink 1 liter of water'),
            ),
            const SizedBox(height: 18),
            Text(
              'Today’s rule',
              style: GoogleFonts.manrope(color: KeptTheme.mist),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rule,
              maxLines: 3,
              style: const TextStyle(color: KeptTheme.paper),
              decoration: _inputDecoration(
                'What must someone do to count as kept?',
              ),
            ),
            const SizedBox(height: 18),
            Text('Category', style: GoogleFonts.manrope(color: KeptTheme.mist)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories)
                  ChoiceChip(
                    label: Text(c.$2),
                    selected: _category == c.$1,
                    onSelected: (_) => setState(() => _category = c.$1),
                    selectedColor: KeptTheme.accent.withValues(alpha: 0.25),
                    backgroundColor: KeptTheme.panel,
                    labelStyle: GoogleFonts.manrope(
                      color: _category == c.$1
                          ? KeptTheme.accent
                          : KeptTheme.mist,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide(
                      color: _category == c.$1
                          ? KeptTheme.accent.withValues(alpha: 0.5)
                          : KeptTheme.line,
                    ),
                  ),
              ],
            ),
            Text(
              'Who can join?',
              style: GoogleFonts.manrope(color: KeptTheme.mist),
            ),
            const SizedBox(height: 10),
            if (keptUsesNativeCupertino) ...[
              SizedBox(
                height: 36,
                width: double.infinity,
                child: CNSegmentedControl(
                  labels: _policies.map((p) => p.$2).toList(),
                  selectedIndex: () {
                    final i = _policies.indexWhere((p) => p.$1 == _joinPolicy);
                    return i < 0 ? 0 : i;
                  }(),
                  height: 36,
                  color: KeptTheme.accent,
                  onValueChanged: (i) {
                    if (i < 0 || i >= _policies.length) return;
                    setState(() => _joinPolicy = _policies[i].$1);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _policies.firstWhere((p) => p.$1 == _joinPolicy).$3,
                style: GoogleFonts.manrope(fontSize: 12, color: KeptTheme.mist),
              ),
              const SizedBox(height: 12),
            ] else
              ..._policies.map((p) {
                final selected = _joinPolicy == p.$1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _joinPolicy = p.$1),
                      borderRadius: BorderRadius.circular(14),
                      child: Ink(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: KeptTheme.panel,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? KeptTheme.accent.withValues(alpha: 0.55)
                                : KeptTheme.line,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              selected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selected
                                  ? KeptTheme.accent
                                  : KeptTheme.mist,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.$2,
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w700,
                                      color: KeptTheme.paper,
                                    ),
                                  ),
                                  Text(
                                    p.$3,
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      color: KeptTheme.mist,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: KeptTheme.broke)),
            ],
            const SizedBox(height: 28),
            KeptPrimaryButton(
              label: _saving ? 'Creating…' : 'Create vow',
              onPressed: _saving ? null : _submit,
            ),
          ],
        );
      },
    );

    if (widget.asTab) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF141C18), KeptTheme.void_],
          ),
        ),
        child: SafeArea(bottom: false, child: body),
      );
    }

    return Scaffold(
      backgroundColor: KeptTheme.void_,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Create a vow',
          style: GoogleFonts.sora(fontWeight: FontWeight.w600),
        ),
      ),
      body: body,
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: KeptTheme.mist),
      filled: true,
      fillColor: KeptTheme.panel,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: KeptTheme.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: KeptTheme.accent),
      ),
    );
  }
}
