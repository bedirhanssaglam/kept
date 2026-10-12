part of 'create_vow_view.dart';

class _LabeledValue<T> {
  const _LabeledValue(this.value, this.label, [this.help]);

  final T value;
  final String label;
  final String? help;
}

mixin CreateVowForm on ConsumerState<CreateVowView> {
  VowRepository get _repo => ref.read(VowRepository.provider);

  final _title = TextEditingController();
  final _rule = TextEditingController();
  String _category = VowCategory.health;
  String _joinPolicy = VowPolicy.open;
  int _length = VowLength.threeWeeks;
  bool _startsTomorrow = true;
  int? _example;
  bool _filling = false;
  bool _saving = false;
  String? _error;

  static const lengths = _VowLengths.values;

  @override
  void initState() {
    super.initState();
    _title.addListener(_onDraftChanged);
    _rule.addListener(_onDraftChanged);
  }

  @override
  void dispose() {
    _title.dispose();
    _rule.dispose();
    super.dispose();
  }

  void _onDraftChanged() {
    if (_filling || !mounted || _example == null) return;
    setState(() => _example = null);
  }

  void _useDraft(int index) {
    final draft = _drafts()[index];
    _filling = true;
    _title.text = draft.title;
    _rule.text = draft.rule;
    _filling = false;
    setState(() {
      _example = index;
      _category = draft.category;
    });
  }

  String get _startsOn {
    final now = DateTime.now();
    return _startsTomorrow
        ? KeptDay.key(now.add(const Duration(days: 1)))
        : KeptDay.key(now);
  }

  List<_LabeledValue<String>> get _categories => [
    _LabeledValue(VowCategory.health, LocaleKeys.categoryHealth.tr()),
    _LabeledValue(VowCategory.quit, LocaleKeys.categoryQuit.tr()),
    _LabeledValue(VowCategory.move, LocaleKeys.categoryMove.tr()),
    _LabeledValue(VowCategory.focus, LocaleKeys.categoryFocus.tr()),
    _LabeledValue(VowCategory.custom, LocaleKeys.categoryCustom.tr()),
  ];

  List<_LabeledValue<String>> get _policies => [
    _LabeledValue(
      VowPolicy.open,
      LocaleKeys.policyOpenLabel.tr(),
      LocaleKeys.policyOpenHelp.tr(),
    ),
    _LabeledValue(
      VowPolicy.approval,
      LocaleKeys.policyApprovalLabel.tr(),
      LocaleKeys.policyApprovalHelp.tr(),
    ),
    _LabeledValue(
      VowPolicy.invite,
      LocaleKeys.policyInviteLabel.tr(),
      LocaleKeys.policyInviteHelp.tr(),
    ),
    _LabeledValue(
      VowPolicy.closed,
      LocaleKeys.policyClosedLabel.tr(),
      LocaleKeys.policyClosedHelp.tr(),
    ),
  ];

  Future<void> _submit() async {
    if (!client.auth.isAuthenticated) {
      final ok = await const SignInSheet().show(context);
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
        durationDays: _length,
        startsOn: _startsOn,
      );
      if (!mounted) return;
      _title.clear();
      _rule.clear();
      setState(() {
        _category = VowCategory.health;
        _joinPolicy = VowPolicy.open;
        _length = VowLength.threeWeeks;
        _startsTomorrow = true;
        _example = null;
      });
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
}

abstract final class _VowLengths {
  static const values = [
    VowLength.week,
    VowLength.threeWeeks,
    VowLength.open,
  ];
}
