import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:puntos_colombia_prueba/app/constants.dart';
import 'package:puntos_colombia_prueba/app/dependency_injector.dart';
import 'package:puntos_colombia_prueba/app/utils.dart';
import 'package:puntos_colombia_prueba/domain/enum/screen_size_enum.dart';
import 'package:puntos_colombia_prueba/view/home/home_controller.dart';
import 'package:puntos_colombia_prueba/view/home/home_state.dart';
import 'package:puntos_colombia_prueba/view/home/widget/link_input_card.dart';
import 'package:puntos_colombia_prueba/view/home/widget/link_result_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final HomeScreenController _screenController =
      AppInjector.dependencyInjector.resolve();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _linkInputController = TextEditingController();
  final _pageController = PageController();
  late bool isMobile;
  final _appTitle = 'Acortador de enlaces';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = AppUtils.getScreenSize(screenWidth);
    isMobile = screenSize == AppScreenSize.mobile;

    final textTheme = Theme.of(context).textTheme;
    final titleStyle =
        isMobile ? textTheme.headlineMedium : textTheme.displaySmall;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight +
                    MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                children: [
                  Flexible(
                    child: _PuntosColombiaLogo(
                      isMobile: isMobile,
                    ),
                  ),
                  Expanded(
                    flex: isMobile ? 5 : 3,
                    child: BlocConsumer<HomeScreenController, HomeScreenState>(
                      listener: (context, state) {
                        if (state.isError) {
                          _resetScreen();
                          _errorDialog(context);
                        }
                      },
                      bloc: widget._screenController,
                      builder: (_, state) => Center(
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 24 : 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: Text(
                                    _appTitle,
                                    style: titleStyle!.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: PageView(
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    AppLinkInputCard(
                                      checkLink:
                                          widget._screenController.checkLink,
                                      linkInputController: _linkInputController,
                                      validUrl: state.validUrl,
                                      sendLink: _sendLink,
                                      isMobile: isMobile,
                                    ),
                                    if (state.isLoading)
                                      Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      )
                                    else
                                      AppLinkResultCard(
                                        shortLink: state.shortenedLink?.url,
                                        isMobile: isMobile,
                                        copyToClipboard: _copyLinkToClipboard,
                                        resetScreen: _resetScreen,
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
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

  @override
  void dispose() {
    _linkInputController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _copyLinkToClipboard(String? shortLink) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Clipboard.setData(
      ClipboardData(text: shortLink),
    ).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.only(
              bottom: screenHeight - 100,
              right: 30,
              left: isMobile ? 30 : screenWidth - 300,
            ),
            content: const Text(
              AppConstants.textUrlCopiedDialog,
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
      },
    );
  }

  void _resetScreen() {
    _pageController
        .previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        )
        .then(
          (_) => widget._screenController.resetController(),
        );
  }

  void _sendLink() {
    widget._screenController.sendLink(_linkInputController.text);

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> _errorDialog(
    BuildContext context,
  ) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error :('),
          content: const Text('Ocurrió un error, inténtalo de nuevo.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}

class _PuntosColombiaLogo extends StatelessWidget {
  const _PuntosColombiaLogo({
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AppConstants.assetsPuntosColombiaLogo,
          ),
        ),
      );
}
