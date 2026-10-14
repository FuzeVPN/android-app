import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/fuze_design.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader(
      'Noto Sans Arabic',
    )..addFont(rootBundle.load('assets/fonts/NotoSansArabic.ttf'))).load();
  });
  for (final width in [320.0, 360.0, 800.0]) {
    for (final scale in [1.0, 2.0]) {
      for (final language in ['fr', 'en', 'ar']) {
        for (final dark in [false, true]) {
          final name =
              '$language-${width.toInt()}-${(scale * 100).toInt()}-${dark ? 'dark' : 'light'}';
          testWidgets(
            'whole heading words and full accessibility scale $name',
            (tester) async {
              tester.view.physicalSize = Size(width, 900);
              tester.view.devicePixelRatio = 1;
              addTearDown(tester.view.resetPhysicalSize);
              addTearDown(tester.view.resetDevicePixelRatio);
              const capture = ValueKey('header-capture');
              await tester.pumpWidget(
                MaterialApp(
                  locale: Locale(language),
                  supportedLocales: AppLanguages.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  theme: dark ? FuzeVpnTheme.dark() : FuzeVpnTheme.light(),
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(scale)),
                    child: child!,
                  ),
                  home: Builder(
                    builder: (context) {
                      final copy = AppLocalizations.of(context);
                      return RepaintBoundary(
                        key: capture,
                        child: Scaffold(
                          body: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: width < 360 ? 16 : 24,
                              vertical: 24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FuzePageHeader(
                                  title: copy.connection_title,
                                  description: copy.connection_subtitle,
                                ),
                                FuzePageHeader(
                                  title: copy.nav_locations,
                                  description: copy.locations_available,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
              await tester.pumpAndSettle();
              final context = tester.element(find.byType(FuzePageHeader).first);
              final copy = AppLocalizations.of(context);
              for (final title in [copy.connection_title, copy.nav_locations]) {
                final text = tester.widget<Text>(find.text(title));
                expect(text.textScaler!.scale(16), 16 * scale);
                expect(text.style!.fontSize, greaterThanOrEqualTo(20));
                expect(text.maxLines, isNull);
                final paragraph = tester.renderObject<RenderParagraph>(
                  find.text(title),
                );
                if (language == 'fr') {
                  var offset = 0;
                  for (final word in title.split(' ')) {
                    final boxes = paragraph.getBoxesForSelection(
                      TextSelection(
                        baseOffset: offset,
                        extentOffset: offset + word.length,
                      ),
                    );
                    expect(
                      boxes,
                      hasLength(1),
                      reason: '$word must not break within a word',
                    );
                    offset += word.length + 1;
                  }
                }
              }
              expect(tester.takeException(), isNull);
              final boundary = tester.renderObject<RenderRepaintBoundary>(
                find.byKey(capture),
              );
              await tester.runAsync(() async {
                final image = await boundary.toImage();
                final bytes = await image.toByteData(
                  format: ui.ImageByteFormat.png,
                );
                image.dispose();
                final file = File('build/reports/74013-ui/headers-$name.png');
                await file.parent.create(recursive: true);
                await file.writeAsBytes(bytes!.buffer.asUint8List());
              });
            },
          );
        }
      }
    }
  }
}
