import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app_info/package_info_provider.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/developer_info_section.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.aboutTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(
            Icons.sports_mma,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            loc.appTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            loc.appTagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: packageInfo.when(
              data: (info) => Text(
                loc.versionLabel(info.version),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                      .withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            loc.aboutDescription,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 32),
          DeveloperInfoSection(
            heading: loc.contactLabel,
            githubLabel: loc.developerGithub,
            websiteLabel: loc.developerWebsite,
            youtubeLabel: loc.developerYoutube,
            linkedinLabel: loc.developerLinkedin,
          ),
        ],
      ),
    );
  }
}
