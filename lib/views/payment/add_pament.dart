import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_furiniture_app_mvc/controllers/payment_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';
import 'package:provider/provider.dart';

class AddPayment extends StatelessWidget {
  const AddPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final paymentProvider = context.read<PaymentProvider>();
    final isLight = themeProvider.isLightMode;

    return Scaffold(
      backgroundColor: isLight ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isLight ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isLight ? Colors.black : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Add payment method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isLight ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.asset('assets/images/Paymentcard3.png'),
                  const SizedBox(height: 20),
                  _buildInputContainer(
                    label: 'CardHolder Name',
                    child: TextFormField(
                      controller: paymentProvider.cardHolderName,
                      style: TextStyle(
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      decoration: _inputDecoration('Ex: Danish Abrar', isLight),
                    ),
                    isLight: isLight,
                  ),
                  const SizedBox(height: 20),
                  _buildInputContainer(
                    label: 'Card Number',
                    isLight: isLight,
                    child: TextFormField(
                      controller: paymentProvider.cardNumber,
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberInputFormatter(),
                      ],
                      style: TextStyle(
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      decoration: _inputDecoration(
                        '**** **** **** 3456',
                        isLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputContainer(
                          label: 'CVV',
                          isLight: isLight,
                          child: TextFormField(
                            controller: paymentProvider.cvv,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            style: TextStyle(
                              color: isLight ? Colors.black : Colors.white,
                            ),
                            decoration: _inputDecoration('Ex: 123', isLight),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInputContainer(
                          label: 'Expiration Date',
                          isLight: isLight,
                          child: TextFormField(
                            controller: paymentProvider.expiryDate,
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CardExpiryInputFormatter(),
                            ],
                            style: TextStyle(
                              color: isLight ? Colors.black : Colors.white,
                            ),
                            decoration: _inputDecoration('MM/YY', isLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: isLight ? Colors.black : Colors.white,
                ),
                onPressed: () => _validateAndSave(context, paymentProvider),
                child: Text(
                  'ADD NEW CARD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isLight ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputContainer({
    required String label,
    required Widget child,
    required bool isLight,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isLight ? Colors.grey[100] : Colors.grey[900],
        border: Border.all(
          color: isLight ? Colors.transparent : Colors.grey[700]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 44, child: child),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, bool isLight) =>
      InputDecoration(
        counterText: '',
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Colors.black45 : Colors.grey[600],
        ),
      );

  void _validateAndSave(BuildContext context, PaymentProvider provider) {
    if (provider.cardHolderName.text.trim().isEmpty ||
        provider.cardNumber.text.replaceAll(' ', '').length != 16 ||
        provider.cvv.text.length != 3 ||
        provider.expiryDate.text.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check your card details.')),
      );
      return;
    }
    provider.savePaymentDetails();
    Navigator.pop(context);
  }
}

// --- فارمیٹ کرنے والی کلاسز ---
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    if (text.length > 16) return oldValue;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) buffer.write(' ');
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 4) return oldValue;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) buffer.write('/');
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
