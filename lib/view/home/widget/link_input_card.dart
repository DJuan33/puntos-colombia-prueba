import 'package:flutter/material.dart';
import 'package:puntos_colombia_prueba/app/constants.dart';
import 'package:puntos_colombia_prueba/view/widget/button/elevated_button.dart';

class AppLinkInputCard extends StatelessWidget {
  const AppLinkInputCard({
    required this.checkLink,
    required this.sendLink,
    required this.linkInputController,
    required this.validUrl,
    required this.isMobile,
    super.key,
  });

  final void Function(String) checkLink;
  final void Function() sendLink;
  final TextEditingController linkInputController;
  final bool validUrl;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = isMobile ? textTheme.titleMedium : textTheme.titleLarge;

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
                      AppConstants.textUrlInputLabel,
                      style: bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: linkInputController,
                      scrollPadding: const EdgeInsets.only(bottom: 36),
                      onChanged: checkLink,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Ingresa una enlace o link',
                        errorText:
                            validUrl ? null : AppConstants.textUrlInputError,
                      ),
                    ),
                  ),
                  Center(
                    child: AppElevatedButton(
                      onPressed: (validUrl && linkInputController.text != '')
                          ? sendLink
                          : null,
                      child: const Text(
                        AppConstants.textSendLinkButton,
                      ),
                    ),
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
