import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/widgets/whole_words.dart';

Widget _box(double width, Widget child) => MaterialApp(
  home: Scaffold(
    body: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(width: width, child: child),
    ),
  ),
);

RenderParagraph _paragraph(WidgetTester tester, String text) =>
    tester.renderObject<RenderParagraph>(find.text(text));

void main() {
  testWidgets('text that fits is laid out exactly as a plain Text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _box(400, const WholeWords(child: Text('Déconnecter le compte'))),
    );
    final RenderWholeWords box = tester.renderObject(find.byType(WholeWords));
    expect(box.scale, 1);
    expect(tester.getSize(find.byType(WholeWords)).width, 400);
    expect(_paragraph(tester, 'Déconnecter le compte').size.width, 400);
  });

  testWidgets('a word wider than the space shrinks instead of being cut', (
    tester,
  ) async {
    const String text = 'Déconnecter le compte';
    await tester.pumpWidget(
      _box(
        100,
        const WholeWords(child: Text(text, style: TextStyle(fontSize: 20))),
      ),
    );
    final RenderWholeWords box = tester.renderObject(find.byType(WholeWords));
    final RenderParagraph paragraph = _paragraph(tester, text);
    final double widest = paragraph.getMinIntrinsicWidth(double.infinity);
    expect(widest, greaterThan(100));
    expect(box.scale, closeTo(100 / widest, 0.0001));
    expect(
      paragraph.size.width,
      greaterThanOrEqualTo(
        paragraph.getMinIntrinsicWidth(double.infinity) - 0.01,
      ),
    );
    final Rect drawn = tester.getRect(find.text(text));
    expect(drawn.width, lessThanOrEqualTo(100.01));
    expect(
      tester.getSize(find.byType(WholeWords)).width,
      lessThanOrEqualTo(100.01),
    );
    // Still wraps between words: "Déconnecter" / "le compte".
    final double line = paragraph.getMaxIntrinsicHeight(double.infinity);
    expect(paragraph.size.height, closeTo(2 * line, 0.01));
  });

  testWidgets('a shrunk button label stays tappable and readable', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _box(
        120,
        FilledButton(
          onPressed: () => taps++,
          child: const WholeWords(
            child: Text('Déconnecter', style: TextStyle(fontSize: 28)),
          ),
        ),
      ),
    );
    final RenderParagraph paragraph = _paragraph(tester, 'Déconnecter');
    expect(
      paragraph.size.width,
      greaterThanOrEqualTo(
        paragraph.getMinIntrinsicWidth(double.infinity) - 0.01,
      ),
    );
    await tester.tap(find.text('Déconnecter'));
    expect(taps, 1);
    // The button's own detector takes the tap whatever its child answers: check that the
    // scaled hit test itself reaches the paragraph, near the right end of the drawn word.
    final RenderWholeWords box = tester.renderObject(find.byType(WholeWords));
    expect(box.scale, lessThan(1));
    final Rect drawn = tester.getRect(find.text('Déconnecter'));
    final Offset probe = Offset(drawn.left + drawn.width * 0.95, drawn.center.dy);
    final HitTestResult hit = HitTestResult();
    tester.binding.hitTestInView(hit, probe, tester.view.viewId);
    expect(hit.path.any((entry) => entry.target == paragraph), isTrue);
    final SemanticsHandle semantics = tester.ensureSemantics();
    expect(find.bySemanticsLabel('Déconnecter'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('works inside an AlertDialog, which sizes by intrinsic width', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Center(
            child: TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => AlertDialog(
                  scrollable: true,
                  title: const WholeWords(
                    child: Text('Déconnecter le compte ?'),
                  ),
                  actions: <Widget>[
                    FilledButton(
                      onPressed: () {},
                      child: const WholeWords(child: Text('Déconnecter')),
                    ),
                  ],
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // The AlertDialog fills the screen; its card is the first Material below it.
    final Rect dialog = tester.getRect(
      find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.byType(Material),
          )
          .first,
    );
    for (final String text in <String>[
      'Déconnecter le compte ?',
      'Déconnecter',
    ]) {
      final RenderParagraph paragraph = _paragraph(tester, text);
      expect(
        paragraph.size.width,
        greaterThanOrEqualTo(
          paragraph.getMinIntrinsicWidth(double.infinity) - 0.01,
        ),
        reason: text,
      );
      final Rect drawn = tester.getRect(find.text(text));
      expect(
        drawn.left,
        greaterThanOrEqualTo(dialog.left - 0.01),
        reason: text,
      );
      expect(drawn.right, lessThanOrEqualTo(dialog.right + 0.01), reason: text);
    }
  });
}
