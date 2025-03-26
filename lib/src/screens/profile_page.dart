import 'package:flutter/material.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/widgets/language_change.dart';
import 'package:music_app/src/widgets/theme_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ThemeWidget(),
            const AppLanguages(),
            _buildRow(
              context,
              icon: Icons.warning_amber_outlined,
              text: AppLocalizations.of(context).about.toString(),
            ),
            _buildRow(
              context,
              icon: Icons.star,
              text: AppLocalizations.of(context).rateus.toString(),
            ),
            _buildRow(
              context,
              icon: Icons.privacy_tip_outlined,
              text: AppLocalizations.of(context).privacypolicy.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).iconTheme.color),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      ),
    );
  }
}
