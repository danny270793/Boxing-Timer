import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../application/modes_controller.dart';
import '../../domain/entities/timer_mode.dart';
import '../widgets/stepper_row.dart';

class ModeEditorPage extends ConsumerStatefulWidget {
  const ModeEditorPage({super.key, this.modeId, this.template});

  /// Id of an existing custom mode being edited. Null when creating a mode.
  final String? modeId;

  /// Prefilled values when duplicating another mode (preset or custom).
  final TimerMode? template;

  @override
  ConsumerState<ModeEditorPage> createState() => _ModeEditorPageState();
}

class _ModeEditorPageState extends ConsumerState<ModeEditorPage> {
  late final TextEditingController _nameController;
  late int _rounds;
  late int _roundMinutes;
  late int _roundSecondsPart;
  late int _restMinutes;
  late int _restSecondsPart;

  String? _pendingCopyName;
  bool _copyNameApplied = false;

  bool get _isEditing => widget.modeId != null;

  @override
  void initState() {
    super.initState();

    TimerMode base = const TimerMode(
      id: '',
      name: '',
      totalRounds: 3,
      roundSeconds: 180,
      restSeconds: 60,
    );
    String initialName = '';

    if (widget.modeId != null) {
      final existing = ref
          .read(modesControllerProvider)
          .allModes
          .where((mode) => mode.id == widget.modeId)
          .toList();
      if (existing.isNotEmpty) {
        base = existing.first;
        initialName = base.name;
      }
    } else if (widget.template != null) {
      base = widget.template!;
      _pendingCopyName = base.name;
    }

    _nameController = TextEditingController(text: initialName);
    _rounds = base.totalRounds;
    _roundMinutes = base.roundSeconds ~/ 60;
    _roundSecondsPart = base.roundSeconds % 60;
    _restMinutes = base.restSeconds ~/ 60;
    _restSecondsPart = base.restSeconds % 60;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_copyNameApplied && _pendingCopyName != null) {
      _nameController.text = AppLocalizations.of(context)!
          .copyOfMode(_pendingCopyName!);
      _copyNameApplied = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    final loc = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.nameRequiredError)));
      return;
    }
    final roundSeconds = _roundMinutes * 60 + _roundSecondsPart;
    if (roundSeconds <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.roundDurationRequiredError)));
      return;
    }

    final id =
        widget.modeId ?? DateTime.now().microsecondsSinceEpoch.toString();
    final mode = TimerMode(
      id: id,
      name: name,
      totalRounds: _rounds,
      roundSeconds: roundSeconds,
      restSeconds: _restMinutes * 60 + _restSecondsPart,
    );
    ref.read(modesControllerProvider.notifier).upsertMode(mode);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sectionStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
      letterSpacing: 1,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? loc.editModeTitle : loc.newModeTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: loc.nameFieldLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Text(loc.roundsSectionTitle, style: sectionStyle),
          StepperRow(
            label: loc.roundsLabel,
            valueLabel: '$_rounds',
            onDecrement: () =>
                setState(() => _rounds = (_rounds - 1).clamp(1, 50)),
            onIncrement: () =>
                setState(() => _rounds = (_rounds + 1).clamp(1, 50)),
          ),
          const SizedBox(height: 16),
          Text(loc.roundDurationSectionTitle, style: sectionStyle),
          StepperRow(
            label: loc.minutesLabel,
            valueLabel: '$_roundMinutes',
            onDecrement: () => setState(
              () => _roundMinutes = (_roundMinutes - 1).clamp(0, 30),
            ),
            onIncrement: () => setState(
              () => _roundMinutes = (_roundMinutes + 1).clamp(0, 30),
            ),
          ),
          StepperRow(
            label: loc.secondsLabel,
            valueLabel: '$_roundSecondsPart',
            onDecrement: () => setState(
              () => _roundSecondsPart = (_roundSecondsPart - 5).clamp(0, 55),
            ),
            onIncrement: () => setState(
              () => _roundSecondsPart = (_roundSecondsPart + 5).clamp(0, 55),
            ),
          ),
          const SizedBox(height: 16),
          Text(loc.restDurationSectionTitle, style: sectionStyle),
          StepperRow(
            label: loc.minutesLabel,
            valueLabel: '$_restMinutes',
            onDecrement: () =>
                setState(() => _restMinutes = (_restMinutes - 1).clamp(0, 30)),
            onIncrement: () =>
                setState(() => _restMinutes = (_restMinutes + 1).clamp(0, 30)),
          ),
          StepperRow(
            label: loc.secondsLabel,
            valueLabel: '$_restSecondsPart',
            onDecrement: () => setState(
              () => _restSecondsPart = (_restSecondsPart - 5).clamp(0, 55),
            ),
            onIncrement: () => setState(
              () => _restSecondsPart = (_restSecondsPart + 5).clamp(0, 55),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                loc.saveModeButton,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
