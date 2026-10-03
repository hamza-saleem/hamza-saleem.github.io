import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

/// Conceptual responsibilities and intended startup ordering supplied by Hamza.
class AuthLifecycleDiagram extends StatelessWidget {
  const AuthLifecycleDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    final responsibilities = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Responsibility boundaries',
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 20),
        ),
        const SizedBox(height: 16),
        const _FlowNode('AuthService'),
        const _Arrow(),
        const _FlowNode(
          'AuthController',
          detail: 'Authenticated identity / authentication state',
        ),
        const _Arrow(),
        const _FlowNode(
          'UserController',
          detail: 'Application user / profile state',
        ),
        const _Arrow(),
        const _FlowNode('Authenticated-only modules'),
      ],
    );
    final lifecycle = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Intended startup lifecycle',
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 20),
        ),
        const SizedBox(height: 16),
        const _FlowNode('App starts'),
        const _Arrow(),
        const _FlowNode('Initialize global dependencies'),
        const _Arrow(),
        const _FlowNode('Resolve authentication state'),
        const _Arrow(),
        LayoutBuilder(
          builder: (context, constraints) {
            final loggedOut = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Logged out',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(context.accent),
                ),
                const SizedBox(height: 8),
                const _FlowNode(
                  'Unauthenticated flow',
                  detail: 'Skip authenticated-only initialization',
                ),
              ],
            );
            final loggedIn = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Logged in',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(context.accent),
                ),
                const SizedBox(height: 8),
                const _FlowNode('Load authenticated user'),
                const _Arrow(),
                const _FlowNode('User state ready'),
                const _Arrow(),
                const _FlowNode('Initialize user-dependent modules'),
              ],
            );
            if (constraints.maxWidth < 360) {
              return Column(
                children: [loggedOut, const SizedBox(height: 24), loggedIn],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: loggedOut),
                const SizedBox(width: 12),
                Expanded(child: loggedIn),
              ],
            );
          },
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        border: Border.all(color: context.ruleColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conceptual architecture & lifecycle',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 12),
          Text(
            'Responsibility boundaries and intended startup ordering; this is not an exact dependency map of the production code.',
            style: AppTextStyles.caption(context.textSecondary),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 650) {
                return Column(
                  children: [
                    responsibilities,
                    const SizedBox(height: 32),
                    lifecycle,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: responsibilities),
                  const SizedBox(width: 32),
                  Expanded(child: lifecycle),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FlowNode extends StatelessWidget {
  final String label;
  final String? detail;
  const _FlowNode(this.label, {this.detail});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: context.surfaceColor,
      border: Border.all(color: context.ruleColor),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.body(context.textPrimary),
        ),
        if (detail != null) ...[
          const SizedBox(height: 4),
          Text(
            detail!,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption(context.textSecondary),
          ),
        ],
      ],
    ),
  );
}

class _Arrow extends StatelessWidget {
  const _Arrow();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ExcludeSemantics(
      child: Icon(Icons.arrow_downward, size: 18, color: context.accent),
    ),
  );
}
