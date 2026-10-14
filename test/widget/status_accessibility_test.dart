import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/fuze_design.dart';

import '../support/android14_text_scaler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await (FontLoader(
      'Archivo',
    )..addFont(rootBundle.load('assets/fonts/Archivo-Variable.ttf'))).load();
    await (FontLoader(
      'Noto Sans Arabic',
    )..addFont(rootBundle.load('assets/fonts/NotoSansArabic.ttf'))).load();
    await (FontLoader(
      'Google Sans',
    )..addFont(rootBundle.load('assets/fonts/GoogleSans-Variable.ttf'))).load();
  });
  const scalers = <String, TextScaler>{
    '100': TextScaler.noScaling,
    'linear200': TextScaler.linear(2),
    'android14-200': Android14TextScaler(),
  };
  for (final language in AppLanguages.all) {
    for (final width in [320.0, 360.0]) {
      for (final entry in scalers.entries) {
        final name = '${language.tag}-${width.toInt()}-${entry.key}';
        testWidgets('whole localized status words $name', (tester) async {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = Size(width, 1000);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
          const capture = ValueKey('status-capture');
          late List<String> labels;
          await tester.pumpWidget(
            MaterialApp(
              locale: language.locale,
              supportedLocales: AppLanguages.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              theme: FuzeVpnTheme.light(),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: entry.value),
                child: child!,
              ),
              home: Builder(
                builder: (context) {
                  final copy = AppLocalizations.of(context);
                  labels = [
                    copy.status_idle,
                    copy.status_connected,
                    copy.status_authorizing,
                    copy.status_preparing,
                    copy.status_connecting,
                    copy.status_reconnecting,
                    copy.status_waitingNetwork,
                    copy.status_disconnecting,
                    copy.status_error,
                  ];
                  return Scaffold(
                    body: SingleChildScrollView(
                      child: RepaintBoundary(
                        key: capture,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width < 360 ? 16 : 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var i = 0; i < labels.length; i++)
                                Container(
                                  color: FuzeVpnTheme.surfaceDark,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 10,
                                  ),
                                  child: FuzeAdaptiveText(
                                    labels[i],
                                    key: ValueKey('status-$i'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: FuzeVpnTheme.paper,
                                          // Avoid missing Greek/Cyrillic glyphs in
                                          // the host fixture; Android chooses
                                          // its own system fallback at runtime.
                                          fontFamilyFallback: [
                                            if (const [
                                              'el',
                                              'ru',
                                              'uk',
                                            ].contains(language.tag))
                                              'Google Sans',
                                            ...FuzeVpnTheme.fontFallback,
                                          ],
                                        ),
                                    minimumFontSize: 14,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          for (var i = 0; i < labels.length; i++) {
            final finder = find.descendant(
              of: find.byKey(ValueKey('status-$i')),
              matching: find.byType(Text),
            );
            final text = tester.widget<Text>(finder);
            expect(text.textScaler, same(entry.value));
            expect(text.maxLines, isNull);
            expect(text.overflow, isNot(TextOverflow.ellipsis));
            expect(text.style!.fontSize, greaterThanOrEqualTo(14));
            final paragraph = tester.renderObject<RenderParagraph>(finder);
            final words = TextPainter(
              text: TextSpan(text: labels[i], style: text.style),
              textDirection: Directionality.of(tester.element(finder)),
              locale: language.locale,
              textScaler: entry.value,
            )..layout();
            for (var offset = 0; offset < labels[i].length;) {
              final range = words.getWordBoundary(TextPosition(offset: offset));
              final end = range.end > offset ? range.end : offset + 1;
              if (labels[i].substring(offset, end).trim().isNotEmpty) {
                final boxes = paragraph.getBoxesForSelection(
                  TextSelection(baseOffset: offset, extentOffset: end),
                );
                if (boxes.isNotEmpty) {
                  // Fallback fonts can have different ascents on the same
                  // line. A shared vertical band distinguishes those runs
                  // from a word actually split onto separate lines.
                  final top = boxes.map((box) => box.top).reduce(math.max);
                  final bottom = boxes
                      .map((box) => box.bottom)
                      .reduce(math.min);
                  expect(
                    top < bottom,
                    isTrue,
                    reason:
                        '${labels[i]} split within ${labels[i].substring(offset, end)}',
                  );
                }
              }
              offset = end;
            }
            words.dispose();
          }
          if (language.tag == 'fr' && entry.key != 'linear200') {
            final text = tester.widget<Text>(find.text(labels.first));
            expect(
              text.style!.fontSize,
              28,
              reason: 'Retain the existing size when the word fits',
            );
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
            final file = File('build/reports/74016-ui/status-$name.png');
            await file.parent.create(recursive: true);
            await file.writeAsBytes(bytes!.buffer.asUint8List());
          });
        });
      }
    }
  }
}
