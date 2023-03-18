import 'package:flutter/material.dart';
import 'package:puntos_colombia_prueba/app/constants.dart';
import 'package:puntos_colombia_prueba/view/widget/button/elevated_button.dart';
import 'package:puntos_colombia_prueba/view/widget/button/text_button.dart';

class AppLinkResultCard extends StatelessWidget {
  const AppLinkResultCard({
    required this.isMobile,
    required this.copyToClipboard,
    required this.resetScreen,
    this.shortLink,
    super.key,
  });

  final bool isMobile;
  final void Function(String?) copyToClipboard;
  final void Function() resetScreen;
  final String? shortLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final linkStyle =
        isMobile ? textTheme.headlineSmall : textTheme.headlineMedium;
    final bodyStyle = isMobile ? textTheme.titleMedium : textTheme.titleLarge;
    final linkTextColor = Theme.of(context).colorScheme.secondary;

    final actionButtons = [
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: AppTextButton(
          onPressed: resetScreen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  right: 9,
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 18,
                ),
              ),
              Text(
                AppConstants.textTryAgainButton,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: AppElevatedButton(
          onPressed: () => copyToClipboard(shortLink),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  right: 9,
                ),
                child: Icon(
                  Icons.copy,
                  size: 18,
                ),
              ),
              Text(
                AppConstants.textCopyToClipboardButton,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ];

    return Center(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 6 : 30),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 48,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 750,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 36,
                    ),
                    child: Text(
                      AppConstants.textUrlResultLabel,
                      style: bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 48,
                    ),
                    child: SelectableText(
                      shortLink ?? '',
                      style: linkStyle!.copyWith(
                        color: linkTextColor,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: isMobile
                        ? actionButtons.reversed.toList()
                        : actionButtons,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
