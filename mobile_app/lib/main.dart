import 'package:flutter/material.dart';

void main() {
  runApp(const GpsAttendanceApp());
}

class GpsAttendanceApp extends StatelessWidget {
  const GpsAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF7A1F35);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deborah Foundation India Attendance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F3F4),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE1CDD2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE1CDD2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: seedColor, width: 1.4),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() => _submitting = false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final narrow = size.width < 720;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 20 : 48,
            vertical: narrow ? 20 : 36,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _BrandPanel(compact: true),
                        const SizedBox(height: 20),
                        _LoginPanel(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          obscurePassword: _obscurePassword,
                          rememberMe: _rememberMe,
                          submitting: _submitting,
                          onTogglePassword: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          onRememberChanged: (value) {
                            setState(() => _rememberMe = value);
                          },
                          onSubmit: _submit,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: _BrandPanel()),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _LoginPanel(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            rememberMe: _rememberMe,
                            submitting: _submitting,
                            onTogglePassword: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            onRememberChanged: (value) {
                              setState(() => _rememberMe = value);
                            },
                            onSubmit: _submit,
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

class _BrandPanel extends StatelessWidget {
  const _BrandPanel({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: compact ? 250 : 560),
      padding: EdgeInsets.all(compact ? 22 : 34),
      decoration: BoxDecoration(
        color: const Color(0xFF67172C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const _FoundationLogo(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: compact ? 22 : 34),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Geo Attendance App',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
          ),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _FeaturePill(
                icon: Icons.my_location_outlined,
                label: 'GPS check-in',
              ),
              _FeaturePill(
                icon: Icons.groups_2_outlined,
                label: 'Students',
              ),
              _FeaturePill(
                icon: Icons.calendar_today_outlined,
                label: 'Analytics',
              ),
              _FeaturePill(
                icon: Icons.event_available_outlined,
                label: 'LMS',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FoundationLogo extends StatelessWidget {
  const _FoundationLogo({
    this.textColor = const Color(0xFF26343A),
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 76,
          height: 60,
          child: CustomPaint(
            painter: _FoundationMarkPainter(),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Debora\nFoundation\nIndia',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.08,
          ),
        ),
      ],
    );
  }
}

class _FoundationMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()..color = const Color(0xFF6E96CC);
    final pinkPaint = Paint()..color = const Color(0xFFE53D8C);
    final orangePaint = Paint()..color = const Color(0xFFFF7B5F);
    final magentaPaint = Paint()..color = const Color(0xFFD72786);
    final purplePaint = Paint()..color = const Color(0xFF9B4AA0);

    canvas.drawCircle(
        Offset(size.width * 0.52, size.height * 0.13), 9, bluePaint);

    final leftWing = Path()
      ..moveTo(size.width * 0.47, size.height * 0.48)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.20,
        size.width * 0.01,
        size.height * 0.33,
        size.width * 0.08,
        size.height * 0.43,
      )
      ..cubicTo(
        size.width * 0.23,
        size.height * 0.64,
        size.width * 0.34,
        size.height * 0.67,
        size.width * 0.47,
        size.height * 0.48,
      )
      ..close();
    canvas.drawPath(leftWing, pinkPaint);

    final rightWing = Path()
      ..moveTo(size.width * 0.52, size.height * 0.48)
      ..cubicTo(
        size.width * 0.78,
        size.height * 0.20,
        size.width * 0.98,
        size.height * 0.33,
        size.width * 0.91,
        size.height * 0.43,
      )
      ..cubicTo(
        size.width * 0.74,
        size.height * 0.64,
        size.width * 0.61,
        size.height * 0.67,
        size.width * 0.52,
        size.height * 0.48,
      )
      ..close();
    canvas.drawPath(rightWing, orangePaint);

    final lowerPetal = Path()
      ..moveTo(size.width * 0.50, size.height * 0.45)
      ..cubicTo(
        size.width * 0.27,
        size.height * 0.58,
        size.width * 0.37,
        size.height * 0.86,
        size.width * 0.50,
        size.height * 0.96,
      )
      ..cubicTo(
        size.width * 0.64,
        size.height * 0.85,
        size.width * 0.72,
        size.height * 0.58,
        size.width * 0.50,
        size.height * 0.45,
      )
      ..close();
    canvas.drawPath(lowerPetal, magentaPaint);

    final centerFold = Path()
      ..moveTo(size.width * 0.50, size.height * 0.45)
      ..cubicTo(
        size.width * 0.40,
        size.height * 0.59,
        size.width * 0.43,
        size.height * 0.77,
        size.width * 0.50,
        size.height * 0.96,
      )
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.78,
        size.width * 0.61,
        size.height * 0.60,
        size.width * 0.50,
        size.height * 0.45,
      )
      ..close();
    canvas.drawPath(centerFold, purplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF8D2A42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFF1C453), size: 17),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.submitting,
    required this.onTogglePassword,
    required this.onRememberChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final bool submitting;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool> onRememberChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 560),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE7D4D9)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.mail_outline),
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'Enter your email address.';
                }
                if (!email.contains('@') || !email.contains('.')) {
                  return 'Enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  tooltip: obscurePassword ? 'Show password' : 'Hide password',
                  onPressed: onTogglePassword,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              validator: (value) {
                if ((value ?? '').trim().length < 6) {
                  return 'Use at least 6 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    onRememberChanged(value ?? false);
                  },
                ),
                const Expanded(
                  child: Text(
                    'Keep me signed in on this device',
                    style: TextStyle(
                      color: Color(0xFF45534E),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: submitting ? null : onSubmit,
              icon: submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.login),
              label: Text(submitting ? 'Signing in...' : 'Sign in'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _maroon = Color(0xFF7A1F35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: const Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _HomeHeader(),
                        _ShiftCard(),
                        _MonthAttendanceCard(),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                _AppBottomNav(selected: _NavTab.home),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 74),
      decoration: const BoxDecoration(
        color: HomeScreen._maroon,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        color: Color(0xFFEFDCE2),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Debora Computer Center, Doddaballapura, Karnataka, India',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(28),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const Text(
            'Welcome, Rushil Koresh',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShiftCard extends StatefulWidget {
  const _ShiftCard();

  @override
  State<_ShiftCard> createState() => _ShiftCardState();
}

class _ShiftCardState extends State<_ShiftCard> {
  bool _checkedIn = false;
  bool _checkedOut = false;

  String get _currentTime => _checkedIn ? '12:05:20 PM' : '09:50:32';
  String get _checkInTime => _checkedIn ? '09:50 AM' : '_ _ : _ _';
  String get _checkOutTime => _checkedOut ? '12:05 PM' : '_ _ : _ _';
  String get _workingHours => _checkedOut ? '02:15' : '00:00';
  String get _buttonText => _checkedIn ? 'Check Out' : 'Check In';

  void _handleAttendanceAction() {
    setState(() {
      if (!_checkedIn) {
        _checkedIn = true;
        return;
      }

      if (!_checkedOut) {
        _checkedOut = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -44),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: _SoftCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const _HomeOfficeToggle(),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8EA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Apr 15, 2026',
                    style: TextStyle(
                      color: Color(0xFF3E8F43),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentTime,
                        style: const TextStyle(
                          color: Color(0xFF241B1E),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: _checkedOut ? null : _handleAttendanceAction,
                      style: FilledButton.styleFrom(
                        backgroundColor: HomeScreen._maroon,
                        minimumSize: const Size(112, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(_buttonText),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _TimeMetric(
                        icon: Icons.alarm_on,
                        time: _checkInTime,
                        label: 'Check In',
                      ),
                    ),
                    Expanded(
                      child: _TimeMetric(
                        icon: Icons.alarm,
                        time: _checkOutTime,
                        label: 'Check Out',
                      ),
                    ),
                    Expanded(
                      child: _TimeMetric(
                        icon: Icons.timer_outlined,
                        time: _workingHours,
                        label: 'Working HRS',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeOfficeToggle extends StatelessWidget {
  const _HomeOfficeToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2E7EA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: HomeScreen._maroon,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Work Location',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.route, color: HomeScreen._maroon, size: 16),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Field Visit',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: HomeScreen._maroon,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeMetric extends StatelessWidget {
  const _TimeMetric({
    required this.icon,
    required this.time,
    required this.label,
  });

  final IconData icon;
  final String time;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: HomeScreen._maroon, size: 19),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF241B1E),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF73676A),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MonthAttendanceCard extends StatelessWidget {
  const _MonthAttendanceCard();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -28),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Attendance for this Month',
                    style: TextStyle(
                      color: Color(0xFF241B1E),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: HomeScreen._maroon),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'APR',
                        style: TextStyle(
                          color: HomeScreen._maroon,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.calendar_today,
                        color: HomeScreen._maroon,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 10.0;
                final cardWidth = (constraints.maxWidth - gap) / 2;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: const [
                    _AttendanceStatCard(
                      label: 'Working Days',
                      value: '11',
                      color: Color(0xFF2F6F8F),
                      background: Color(0xFFEAF5FA),
                    ),
                    _AttendanceStatCard(
                      label: 'Present',
                      value: '08',
                      color: Color(0xFF3F8A3C),
                      background: Color(0xFFEFF8EE),
                    ),
                    _AttendanceStatCard(
                      label: 'Leaves',
                      value: '03',
                      color: Color(0xFFC47A00),
                      background: Color(0xFFFFF3D9),
                    ),
                    _AttendanceStatCard(
                      label: 'Late in',
                      value: '04',
                      color: Color(0xFF7A1F35),
                      background: Color(0xFFF7E9EE),
                    ),
                  ]
                      .map((card) => SizedBox(width: cardWidth, child: card))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceStatCard extends StatelessWidget {
  const _AttendanceStatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.background,
  });

  final String label;
  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border(top: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF241B1E),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkAttendanceScreen extends StatelessWidget {
  const MarkAttendanceScreen({super.key});

  static const _maroon = Color(0xFF7A1F35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _MarkAttendanceHeader(),
                        const SizedBox(height: 24),
                        _ClassAttendanceCard(
                          title: 'Computer Class',
                          teacher: 'Rushil Koresh',
                          icon: Icons.computer,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const StudentAttendanceScreen(
                                  subject: 'Computer Basics',
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _ClassAttendanceCard(
                          title: 'Tailoring Class',
                          teacher: 'Rushil Koresh',
                          icon: Icons.design_services,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const StudentAttendanceScreen(
                                  subject: 'Tailoring Class',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const _AppBottomNav(selected: _NavTab.attendance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkAttendanceHeader extends StatelessWidget {
  const _MarkAttendanceHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Mark Attendance',
            style: TextStyle(
              color: Color(0xFF241B1E),
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF2E7EA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.account_circle,
            color: MarkAttendanceScreen._maroon,
            size: 26,
          ),
        ),
      ],
    );
  }
}

class _ClassAttendanceCard extends StatelessWidget {
  const _ClassAttendanceCard({
    required this.title,
    required this.teacher,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String teacher;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          height: 188,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: MarkAttendanceScreen._maroon,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: MarkAttendanceScreen._maroon.withAlpha(36),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                top: -8,
                child: Icon(
                  icon,
                  size: 104,
                  color: Colors.white.withAlpha(24),
                ),
              ),
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      teacher,
                      style: const TextStyle(
                        color: Color(0xFFEFDCE2),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AttendanceMark { present, absent }

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({
    required this.subject,
    super.key,
  });

  final String subject;

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  final Map<String, AttendanceMark> _marks = {};
  bool _submitted = false;

  static const _students = [
    'Aarthi Gowda',
    'Gayathri',
    'Mallikarjun',
    'Nagma Khatun',
    'Ramesh Mallegowda',
    'Sandeep Poojari',
    'Surabhi Tumkur',
  ];

  void _markStudent(String student, AttendanceMark mark) {
    if (_submitted) {
      return;
    }

    setState(() => _marks[student] = mark);
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved. You can still edit this attendance.'),
      ),
    );
  }

  void _submitAttendance() {
    setState(() => _submitted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance submitted. Changes are locked for today.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Back',
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const Expanded(
                            child: Text(
                              'Mark Attendance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF241B1E),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _AttendanceInfoCard(
                        subject: widget.subject,
                        submitted: _submitted,
                        onSaveDraft: _submitted ? null : _saveDraft,
                        onSubmit: _submitted ? null : _submitAttendance,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _StudentMarkTile(
                          index: index + 1,
                          name: student,
                          mark: _marks[student],
                          locked: _submitted,
                          onPresent: () => _markStudent(
                            student,
                            AttendanceMark.present,
                          ),
                          onAbsent: () => _markStudent(
                            student,
                            AttendanceMark.absent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const _AppBottomNav(selected: _NavTab.attendance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AttendanceInfoCard extends StatelessWidget {
  const _AttendanceInfoCard({
    required this.subject,
    required this.submitted,
    required this.onSaveDraft,
    required this.onSubmit,
  });

  final String subject;
  final bool submitted;
  final VoidCallback? onSaveDraft;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _InfoLine(label: 'Date', value: 'Apr 15, 2026'),
            const SizedBox(height: 10),
            _InfoLine(label: 'Subject', value: subject),
            const SizedBox(height: 10),
            const _InfoLine(label: 'Instructor', value: 'Rushil Koresh'),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onSaveDraft,
                    icon: const Icon(Icons.save_outlined, size: 18),
                    label: const Text('Save Draft'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: StudentAttendanceScreenColors.maroon,
                      side: const BorderSide(
                        color: StudentAttendanceScreenColors.maroon,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onSubmit,
                    icon: Icon(
                      submitted ? Icons.lock_outline : Icons.check_circle,
                      size: 18,
                    ),
                    label: Text(submitted ? 'Submitted' : 'Submit'),
                    style: FilledButton.styleFrom(
                      backgroundColor: StudentAttendanceScreenColors.maroon,
                      disabledBackgroundColor: const Color(0xFFB89AA4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudentAttendanceScreenColors {
  const StudentAttendanceScreenColors._();

  static const maroon = Color(0xFF7A1F35);
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            color: Color(0xFF83777A),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241B1E),
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _StudentMarkTile extends StatelessWidget {
  const _StudentMarkTile({
    required this.index,
    required this.name,
    required this.mark,
    required this.locked,
    required this.onPresent,
    required this.onAbsent,
  });

  final int index;
  final String name;
  final AttendanceMark? mark;
  final bool locked;
  final VoidCallback onPresent;
  final VoidCallback onAbsent;

  @override
  Widget build(BuildContext context) {
    final present = mark == AttendanceMark.present;
    final absent = mark == AttendanceMark.absent;

    return _SoftCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '$index.',
                style: const TextStyle(
                  color: Color(0xFF83777A),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF241B1E),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _MarkButton(
              icon: Icons.check,
              selected: present,
              selectedColor: const Color(0xFF2E7D32),
              tooltip: 'Present',
              onTap: locked ? null : onPresent,
            ),
            const SizedBox(width: 8),
            _MarkButton(
              icon: Icons.close,
              selected: absent,
              selectedColor: const Color(0xFFB3261E),
              tooltip: 'Absent',
              onTap: locked ? null : onAbsent,
            ),
          ],
        ),
      ),
    );
  }
}

class _MarkButton extends StatelessWidget {
  const _MarkButton({
    required this.icon,
    required this.selected,
    required this.selectedColor,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: selected
                ? selectedColor
                : onTap == null
                    ? const Color(0xFFE9E0E3)
                    : const Color(0xFFF7EEF1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? selectedColor
                  : onTap == null
                      ? const Color(0xFFD9C9CE)
                      : const Color(0xFFE5D0D6),
            ),
          ),
          child: Icon(
            icon,
            color: selected
                ? Colors.white
                : onTap == null
                    ? const Color(0xFF9D8D92)
                    : selectedColor,
            size: 21,
          ),
        ),
      ),
    );
  }
}

enum _ReportRange { daily, weekly, monthly }

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  _ReportRange _selectedRange = _ReportRange.daily;

  static const _rangeStats = <_ReportRange, _ReportSnapshot>{
    _ReportRange.daily: _ReportSnapshot(
      title: 'Daily',
      period: 'Apr 15, 2026',
      presentRate: 91,
      present: 41,
      absent: 4,
      late: 2,
      coverage: 45,
      trend: [
        _TrendPoint('8 AM', 62),
        _TrendPoint('10 AM', 88),
        _TrendPoint('12 PM', 91),
        _TrendPoint('2 PM', 84),
      ],
    ),
    _ReportRange.weekly: _ReportSnapshot(
      title: 'Weekly',
      period: 'Apr 13 - Apr 19, 2026',
      presentRate: 87,
      present: 214,
      absent: 22,
      late: 11,
      coverage: 247,
      trend: [
        _TrendPoint('Mon', 84),
        _TrendPoint('Tue', 91),
        _TrendPoint('Wed', 87),
        _TrendPoint('Thu', 89),
        _TrendPoint('Fri', 83),
      ],
    ),
    _ReportRange.monthly: _ReportSnapshot(
      title: 'Monthly',
      period: 'April 2026',
      presentRate: 89,
      present: 892,
      absent: 74,
      late: 39,
      coverage: 1005,
      trend: [
        _TrendPoint('W1', 86),
        _TrendPoint('W2', 90),
        _TrendPoint('W3', 88),
        _TrendPoint('W4', 92),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final snapshot = _rangeStats[_selectedRange]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _ReportsHeader(),
                        const SizedBox(height: 18),
                        _ReportRangeSelector(
                          selectedRange: _selectedRange,
                          onSelected: (range) {
                            setState(() => _selectedRange = range);
                          },
                        ),
                        const SizedBox(height: 14),
                        _ReportOverviewCard(snapshot: snapshot),
                        const SizedBox(height: 14),
                        _ReportTrendCard(snapshot: snapshot),
                        const SizedBox(height: 14),
                        const _SubjectWiseReportCard(),
                      ],
                    ),
                  ),
                ),
                const _AppBottomNav(selected: _NavTab.reports),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReportsHeader extends StatelessWidget {
  const _ReportsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF7A1F35),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Student attendance analytics',
                  style: TextStyle(
                    color: Color(0xFFF0DCE2),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.query_stats,
            color: Color(0xFFF1C453),
            size: 34,
          ),
        ],
      ),
    );
  }
}

class _ReportRangeSelector extends StatelessWidget {
  const _ReportRangeSelector({
    required this.selectedRange,
    required this.onSelected,
  });

  final _ReportRange selectedRange;
  final ValueChanged<_ReportRange> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFE3E7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: _ReportRange.values.map((range) {
          final selected = selectedRange == range;
          final label = switch (range) {
            _ReportRange.daily => 'Daily',
            _ReportRange.weekly => 'Weekly',
            _ReportRange.monthly => 'Monthly',
          };

          return Expanded(
            child: InkWell(
              onTap: () => onSelected(range),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      selected ? const Color(0xFF7A1F35) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : const Color(0xFF7A1F35),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ReportOverviewCard extends StatelessWidget {
  const _ReportOverviewCard({required this.snapshot});

  final _ReportSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.title} Overview',
                        style: const TextStyle(
                          color: Color(0xFF241B1E),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        snapshot.period,
                        style: const TextStyle(
                          color: Color(0xFF83777A),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8EA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${snapshot.presentRate}%',
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: snapshot.presentRate / 100,
                minHeight: 10,
                backgroundColor: const Color(0xFFF3E7EA),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF3E8F43),
                ),
              ),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 10.0;
                final width = (constraints.maxWidth - gap) / 2;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    _ReportMetricTile(
                      label: 'Present',
                      value: '${snapshot.present}',
                      color: const Color(0xFF2E7D32),
                      background: const Color(0xFFEAF8EA),
                    ),
                    _ReportMetricTile(
                      label: 'Absent',
                      value: '${snapshot.absent}',
                      color: const Color(0xFFB3261E),
                      background: const Color(0xFFFDECEC),
                    ),
                    _ReportMetricTile(
                      label: 'Late Arrivals',
                      value: '${snapshot.late}',
                      color: const Color(0xFFB36B00),
                      background: const Color(0xFFFFF3DB),
                    ),
                    _ReportMetricTile(
                      label: 'Marked Students',
                      value: '${snapshot.coverage}',
                      color: const Color(0xFF2F6F8F),
                      background: const Color(0xFFEAF5FA),
                    ),
                  ].map((tile) => SizedBox(width: width, child: tile)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportMetricTile extends StatelessWidget {
  const _ReportMetricTile({
    required this.label,
    required this.value,
    required this.color,
    required this.background,
  });

  final String label;
  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF554A4D),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportTrendCard extends StatelessWidget {
  const _ReportTrendCard({required this.snapshot});

  final _ReportSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Attendance Trend',
              style: TextStyle(
                color: Color(0xFF241B1E),
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 154,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: snapshot.trend.map((point) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${point.value}%',
                            style: const TextStyle(
                              color: Color(0xFF7A1F35),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: point.value / 100,
                                widthFactor: 0.78,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7A1F35),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            point.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF6D6064),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectWiseReportCard extends StatelessWidget {
  const _SubjectWiseReportCard();

  static const _subjects = [
    _SubjectAnalytics('Computer Basics', 94, 32, 2),
    _SubjectAnalytics('Tailoring Class', 88, 29, 4),
    _SubjectAnalytics('Digital Literacy', 91, 24, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Subject Wise',
                    style: TextStyle(
                      color: Color(0xFF241B1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Icon(Icons.menu_book_outlined, color: Color(0xFF7A1F35)),
              ],
            ),
            const SizedBox(height: 14),
            ..._subjects.map(
              (subject) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SubjectAnalyticsRow(subject: subject),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectAnalyticsRow extends StatelessWidget {
  const _SubjectAnalyticsRow({required this.subject});

  final _SubjectAnalytics subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEAD9DE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  subject.name,
                  style: const TextStyle(
                    color: Color(0xFF241B1E),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${subject.rate}%',
                style: const TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: subject.rate / 100,
              minHeight: 8,
              backgroundColor: const Color(0xFFF1E5E8),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2F6F8F),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${subject.present} present',
                  style: const TextStyle(
                    color: Color(0xFF5F5457),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${subject.absent} absent',
                style: const TextStyle(
                  color: Color(0xFFB3261E),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportSnapshot {
  const _ReportSnapshot({
    required this.title,
    required this.period,
    required this.presentRate,
    required this.present,
    required this.absent,
    required this.late,
    required this.coverage,
    required this.trend,
  });

  final String title;
  final String period;
  final int presentRate;
  final int present;
  final int absent;
  final int late;
  final int coverage;
  final List<_TrendPoint> trend;
}

class _TrendPoint {
  const _TrendPoint(this.label, this.value);

  final String label;
  final int value;
}

class _SubjectAnalytics {
  const _SubjectAnalytics(this.name, this.rate, this.present, this.absent);

  final String name;
  final int rate;
  final int present;
  final int absent;
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _maroon = Color(0xFF7A1F35);
  static const _deepMaroon = Color(0xFF67172C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: const Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _ProfileHeader(),
                        SizedBox(height: 18),
                        _ProfileDetailsCard(),
                        SizedBox(height: 12),
                        _ProfileActionCard(),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                _AppBottomNav(selected: _NavTab.profile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            color: ProfileScreen._maroon,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _FoundationLogo(textColor: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -86,
          child: Column(
            children: [
              Container(
                width: 104,
                height: 104,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/rushil_profile.png',
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        backgroundColor: Color(0xFFEED9DF),
                        child: Icon(
                          Icons.person,
                          color: ProfileScreen._deepMaroon,
                          size: 56,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rushil Koresh',
                style: TextStyle(
                  color: Color(0xFF241B1E),
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MiniProfileText('Full Time'),
                  _ProfileDot(),
                  _MiniProfileText('Computer Teacher'),
                  _ProfileDot(),
                  _MiniProfileText('Joined 14th Feb 2024'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 240),
      ],
    );
  }
}

class _MiniProfileText extends StatelessWidget {
  const _MiniProfileText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6D6064),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ProfileDot extends StatelessWidget {
  const _ProfileDot();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        '.',
        style: TextStyle(
          color: Color(0xFF9B8D91),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProfileDetailsCard extends StatelessWidget {
  const _ProfileDetailsCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: _SoftCard(
        child: Column(
          children: [
            _DetailRow(label: 'Employee Id', value: 'DFI326'),
            _DividerLine(),
            _DetailRow(label: 'Designation', value: 'Computer Trainer'),
            _DividerLine(),
            _DetailRow(label: 'Mobile No.', value: '+91 88676 71697'),
            _DividerLine(),
            _DetailRow(
              label: 'Email ID',
              value: 'Rushil.Koresh@deboraFoundationIndia.com',
            ),
            _DividerLine(),
            _DetailRow(label: 'Date of Joining', value: '14th Feb 2024'),
            _DividerLine(),
            _DetailRow(label: 'Work Location', value: 'Doddaballapura'),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF83777A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF241B1E),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xFFF0E4E7),
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}

class _ProfileActionCard extends StatefulWidget {
  const _ProfileActionCard();

  @override
  State<_ProfileActionCard> createState() => _ProfileActionCardState();
}

class _ProfileActionCardState extends State<_ProfileActionCard> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _SoftCard(
            child: SwitchListTile(
              value: _notifications,
              activeThumbColor: ProfileScreen._maroon,
              onChanged: (value) {
                setState(() => _notifications = value);
              },
              secondary: const Icon(
                Icons.notifications,
                color: ProfileScreen._maroon,
              ),
              title: const Text(
                'Notification',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _MenuTile(
            icon: Icons.event_available,
            label: 'Apply Leave',
          ),
          const SizedBox(height: 12),
          const _MenuTile(
            icon: Icons.settings,
            label: 'Settings',
          ),
          const SizedBox(height: 12),
          _MenuTile(
            icon: Icons.logout,
            label: 'Logout',
            showChevron: false,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (_) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: ProfileScreen._maroon),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        trailing: showChevron
            ? const Icon(Icons.chevron_right, color: Color(0xFFB5A8AC))
            : null,
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  const _SoftCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

enum _NavTab { home, attendance, reports, profile }

class _AppBottomNav extends StatelessWidget {
  const _AppBottomNav({required this.selected});

  final _NavTab selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 18,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: selected == _NavTab.home,
            onTap: selected == _NavTab.home
                ? null
                : () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
          ),
          _BottomNavItem(
            icon: Icons.calendar_month_outlined,
            label: 'Attendance',
            selected: selected == _NavTab.attendance,
            onTap: selected == _NavTab.attendance
                ? null
                : () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const MarkAttendanceScreen(),
                      ),
                    );
                  },
          ),
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: 'Reports',
            selected: selected == _NavTab.reports,
            onTap: selected == _NavTab.reports
                ? null
                : () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const ReportsScreen(),
                      ),
                    );
                  },
          ),
          _BottomNavItem(
            icon: Icons.account_circle,
            label: 'Profile',
            selected: selected == _NavTab.profile,
            onTap: selected == _NavTab.profile
                ? null
                : () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? ProfileScreen._maroon : const Color(0xFF6F6266);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 82,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
