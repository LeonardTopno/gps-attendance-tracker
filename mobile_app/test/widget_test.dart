import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gps_attendance_mobile/main.dart';

void main() {
  testWidgets('shows teacher login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    expect(find.textContaining('Debora'), findsOneWidget);
    expect(find.text('GPS check-in'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('LMS'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('validates empty login form', (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.tap(find.text('Sign in'));
    await tester.pump();

    expect(find.text('Enter your email address.'), findsOneWidget);
    expect(find.text('Use at least 6 characters.'), findsOneWidget);
  });

  testWidgets('opens home page after valid login', (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Welcome, Rushil Koresh'), findsOneWidget);
    expect(
      find.text('Debora Computer Center, Doddaballapura, Karnataka, India'),
      findsOneWidget,
    );
    expect(find.text('Work Location'), findsOneWidget);
    expect(find.text('Field Visit'), findsOneWidget);
    expect(find.text('Apr 15, 2026'), findsOneWidget);
    expect(find.text('Check In'), findsWidgets);
    expect(find.text('Attendance for this Month'), findsOneWidget);
    expect(find.text('Request'), findsNothing);
  });

  testWidgets('updates home check in and check out times',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('09:50:32'), findsOneWidget);
    expect(find.text('_ _ : _ _'), findsWidgets);
    expect(find.widgetWithText(FilledButton, 'Check In'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Check In'));
    await tester.pump();

    expect(find.text('12:05:20 PM'), findsOneWidget);
    expect(find.text('09:50 AM'), findsOneWidget);
    expect(find.text('_ _ : _ _'), findsWidgets);
    expect(find.widgetWithText(FilledButton, 'Check Out'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Check Out'));
    await tester.pump();

    expect(find.text('12:05 PM'), findsOneWidget);
    expect(find.text('02:15'), findsOneWidget);
  });

  testWidgets('navigates from home to mark attendance',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();

    expect(find.text('Mark Attendance'), findsOneWidget);
    expect(find.text('Computer Class'), findsOneWidget);
    expect(find.text('Tailoring Class'), findsOneWidget);
    expect(find.text('Rushil Koresh'), findsWidgets);
  });

  testWidgets('opens student list from computer class and marks students',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Computer Class'));
    await tester.pumpAndSettle();

    expect(find.text('Date: '), findsOneWidget);
    expect(find.text('Apr 15, 2026'), findsOneWidget);
    expect(find.text('Subject: '), findsOneWidget);
    expect(find.text('Computer Basics'), findsOneWidget);
    expect(find.text('Instructor: '), findsOneWidget);
    expect(find.text('Rushil Koresh'), findsWidgets);
    expect(find.text('Save Draft'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Aarthi Gowda'), findsOneWidget);

    await tester.drag(find.byType(Scrollable), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('Surabhi Tumkur'), findsOneWidget);

    await tester.drag(find.byType(Scrollable), const Offset(0, 500));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.check).first);
    await tester.pump();
    await tester.tap(find.text('Save Draft'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.close).at(1));
    await tester.pump();
    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.byIcon(Icons.check), findsWidgets);
    expect(find.byIcon(Icons.close), findsWidgets);
    expect(find.text('Submitted'), findsOneWidget);
  });

  testWidgets('opens student list from tailoring class',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tailoring Class'));
    await tester.pumpAndSettle();

    expect(find.text('Mark Attendance'), findsOneWidget);
    expect(find.text('Subject: '), findsOneWidget);
    expect(find.text('Tailoring Class'), findsOneWidget);
    expect(find.text('Instructor: '), findsOneWidget);
    expect(find.text('Rushil Koresh'), findsWidgets);
    expect(find.text('Aarthi Gowda'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.check).first);
    await tester.pump();

    expect(find.byIcon(Icons.check), findsWidgets);
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('navigates from home to profile', (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Rushil Koresh'), findsOneWidget);
    expect(find.text('Employee Id'), findsOneWidget);
    expect(find.text('DFI326'), findsOneWidget);
    expect(find.text('Mobile No.'), findsOneWidget);
    expect(find.text('+91 88676 71697'), findsOneWidget);
    expect(
      find.text('Rushil.Koresh@deboraFoundationIndia.com'),
      findsOneWidget,
    );
    expect(find.text('Date of Joining'), findsOneWidget);
    expect(find.text('14th Feb 2024'), findsOneWidget);
    expect(find.text('Work Location'), findsOneWidget);
    expect(find.text('Doddaballapura'), findsOneWidget);
    expect(find.text('Notification'), findsOneWidget);
    expect(find.text('Apply Leave'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('logs out from profile page', (WidgetTester tester) async {
    await tester.pumpWidget(const GpsAttendanceApp());

    await tester.enterText(
        find.byType(EditableText).first, 'teacher@example.com');
    await tester.enterText(find.byType(EditableText).last, 'password');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Logout'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Rushil Koresh'), findsNothing);
  });
}
