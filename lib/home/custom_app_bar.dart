import 'package:flutter/material.dart';
import 'package:prompt_echo/util/constants.dart';
import 'package:prompt_echo/util/my_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < compactModeBreakWidth;

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 100,
      iconTheme: Theme.of(context).iconTheme,
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              width: isCompact ? 40 : 60,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prompt Echo",
                  style: isCompact
                      ? Theme.of(context).textTheme.titleSmall?.copyWith(letterSpacing: 2)
                      : Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 2),
                ),
                Text(
                  "All in one ai prompt bar",
                  style: isCompact
                      ? Theme.of(context).textTheme.bodySmall
                      : Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, currentMode, _) {
                return IconButton(
                  onPressed: () => themeNotifier.toggleTheme(),
                  icon: Icon(
                    currentMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
