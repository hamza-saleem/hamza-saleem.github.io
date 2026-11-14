import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class ProjectFlowDiagram extends StatelessWidget {
  final String title;
  final List<String> steps;

  const ProjectFlowDiagram({
    super.key,
    required this.title,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: context.cardColor,
      border: Border.all(color: context.ruleColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('IMPLEMENTATION FLOW', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 20),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return Column(
                children: [
                  for (var index = 0; index < steps.length; index++) ...[
                    _StepNode(index: index + 1, label: steps[index]),
                    if (index < steps.length - 1) const _FlowArrow(),
                  ],
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var index = 0; index < steps.length; index++) ...[
                  Expanded(
                    child: _StepNode(index: index + 1, label: steps[index]),
                  ),
                  if (index < steps.length - 1)
                    const _FlowArrow(horizontal: true),
                ],
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _StepNode extends StatelessWidget {
  final int index;
  final String label;

  const _StepNode({required this.index, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 88),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: context.surfaceColor,
      border: Border.all(color: context.ruleColor),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          index.toString().padLeft(2, '0'),
          style: AppTextStyles.label(context.accent),
        ),
        const SizedBox(height: 6),
        Text(label, style: AppTextStyles.caption(context.textPrimary)),
      ],
    ),
  );
}

class _FlowArrow extends StatelessWidget {
  final bool horizontal;
  const _FlowArrow({this.horizontal = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: horizontal
        ? const EdgeInsets.symmetric(horizontal: 6)
        : const EdgeInsets.symmetric(vertical: 6),
    child: ExcludeSemantics(
      child: Icon(
        horizontal ? Icons.arrow_forward : Icons.arrow_downward,
        size: 18,
        color: context.accent,
      ),
    ),
  );
}
