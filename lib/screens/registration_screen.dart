import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Native, responsive registration form based on the supplied Register frame.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const routeName = '/register';
  static const usernameFieldKey = ValueKey('registration-username');
  static const businessFieldKey = ValueKey('registration-business');
  static const termsCheckboxKey = ValueKey('registration-terms-checkbox');
  static const termsLinkKey = ValueKey('registration-terms-link');
  static const startButtonKey = ValueKey('registration-start-button');

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const _background = Color(0xFFFBFAF6);
  static const _teal = Color(0xFF008081);
  static const _fieldFill = Color(0xFFE6F5F5);
  static const _fieldBorder = Color(0xFF99D6D6);
  static const _hintColor = Color(0xFFA8A499);
  static const _textColor = Color(0xFF1D1B20);
  static const _termsTextStyle = TextStyle(
    color: _textColor,
    fontFamily: 'Kalameh',
    fontSize: 11,
    fontWeight: FontWeight.w300,
  );

  static const _systemUiStyle = SystemUiOverlayStyle(
    statusBarColor: _background,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: _background,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: _background,
  );

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _businessController = TextEditingController();
  bool _acceptedTerms = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _businessController.dispose();
    super.dispose();
  }

  void _showTerms() {
    showDialog<void>(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('قوانین و مقررات'),
          content: const Text('متن قوانین و مقررات هنوز در برنامه موجود نیست.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('بستن'),
            ),
          ],
        ),
      ),
    );
  }

  void _startRegistration() {
    FocusScope.of(context).unfocus();
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _showTermsError = !_acceptedTerms);
    if (!valid || !_acceptedTerms) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'اطلاعات آماده است؛ سرویس ثبت‌نام هنوز وصل نشده است.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _systemUiStyle,
      child: Scaffold(
        backgroundColor: _background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(
                      horizontal: (constraints.maxWidth * 0.084).clamp(
                        20.0,
                        48.0,
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: constraints.maxHeight * 0.17),
                              _illustration(constraints.maxWidth),
                              SizedBox(height: constraints.maxHeight * 0.05),
                              const Text(
                                'خوش آمدید',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Kalameh',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'لطفا نام خودتان و نام دکان/کسب و کار تان را وارد کنید.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _textColor,
                                  fontFamily: 'Kalameh',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  height: 1.35,
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.05),
                              _textField(
                                controller: _usernameController,
                                key: RegistrationScreen.usernameFieldKey,
                                hint: 'نام کاربری',
                                autofillHints: const [AutofillHints.username],
                              ),
                              const SizedBox(height: 12),
                              _textField(
                                controller: _businessController,
                                key: RegistrationScreen.businessFieldKey,
                                hint: 'نام دکان/ کسب و کار',
                                textCapitalization: TextCapitalization.words,
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: FilledButton(
                                  key: RegistrationScreen.startButtonKey,
                                  onPressed: _startRegistration,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: _teal,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    textStyle: const TextStyle(
                                      fontFamily: 'Kalameh',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  child: const Text('شروع'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _termsRow(),
                              if (_showTermsError && !_acceptedTerms)
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    'برای ادامه، قوانین و مقررات را بپذیرید.',
                                    style: TextStyle(
                                      color: Color(0xFFB3261E),
                                      fontFamily: 'Kalameh',
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Semantics(
                      button: true,
                      label: 'Back to onboarding',
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).maybePop(),
                            borderRadius: BorderRadius.circular(24),
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

  Widget _illustration(double maxWidth) {
    final width = (maxWidth * 0.334).clamp(100.0, 131.0).toDouble();
    return SizedBox(
      width: width,
      height: width * 135 / 131,
      child: SvgPicture.asset(
        'assets/ScreenShots/illustrations/fo_onbrd_img.svg',
        fit: BoxFit.contain,
        excludeFromSemantics: true,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required Key key,
    required String hint,
    Iterable<String>? autofillHints,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      key: key,
      controller: controller,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      style: const TextStyle(
        color: _textColor,
        fontFamily: 'Kalameh',
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: _hintColor,
          fontFamily: 'Kalameh',
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: _fieldFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _teal, width: 1.5),
        ),
      ),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'این بخش را پر کنید.' : null,
    );
  }

  Widget _termsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            key: RegistrationScreen.termsCheckboxKey,
            value: _acceptedTerms,
            onChanged: (value) => setState(() {
              _acceptedTerms = value ?? false;
              if (_acceptedTerms) _showTermsError = false;
            }),
            activeColor: _teal,
            side: const BorderSide(color: _teal, width: 1),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              const Text('من ', style: _termsTextStyle),
              InkWell(
                key: RegistrationScreen.termsLinkKey,
                onTap: _showTerms,
                borderRadius: BorderRadius.circular(2),
                child: const Text(
                  'قوانین و مقررات',
                  style: TextStyle(
                    color: _teal,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Kalameh',
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Text(' گدام را می پذیرم.', style: _termsTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
