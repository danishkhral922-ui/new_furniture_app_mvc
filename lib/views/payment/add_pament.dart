import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/controllers/payment_controller.dart';

class AddPayment extends StatelessWidget {
  const AddPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final paymentProvider = context.read<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Add payment method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/Paymentcard3.png'),
                  const SizedBox(height: 20),
                  Container(
                    width: 335,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: Text(
                            'CardHolder Name',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 44,
                          width: 300,
                          child: TextFormField(
                            controller: paymentProvider.cardHolderName,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Ex: Danish Abrar',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 335,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isDarkMode ? Colors.transparent : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: Text(
                            'Card Number',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 44,
                          width: 300,
                          child: TextFormField(
                            controller: paymentProvider.cardNumber,
                            keyboardType: TextInputType.number,
                            maxLength: 19,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CardNumberInputFormatter(),
                            ],
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: '**** **** **** 3456',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.grey[600]
                                    : Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode
                                ? Colors.grey[900]
                                : Colors.grey[100],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'CVV',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 44,
                                width: 120,
                                child: TextFormField(
                                  controller: paymentProvider.cvv,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Ex: 123',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode
                                ? Colors.transparent
                                : Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'Expiration Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 44,
                                width: 120,
                                child: TextFormField(
                                  controller: paymentProvider.expiryDate,
                                  keyboardType: TextInputType.number,
                                  maxLength: 5,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CardExpiryInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: '03/22',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: isDarkMode
                                          ? Colors.grey[600]
                                          : Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 60,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  if (paymentProvider.cardHolderName.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter card holder name'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final rawCardNumber = paymentProvider.cardNumber.text
                      .replaceAll(' ', '');
                  if (rawCardNumber.length != 16) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Card Number must be 16 digits'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (paymentProvider.cvv.text.length != 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('CVV must be 3 digits'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (paymentProvider.expiryDate.text.length != 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Expiry Date format should be MM/YY'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  paymentProvider.savePaymentDetails();
                  Navigator.pop(context);
                },
                child: Text(
                  'ADD NEW CARD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String cleanText = newValue.text.replaceAll('/', '');

    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    String formattedText = '';

    if (cleanText.length >= 1) {
      formattedText += cleanText.substring(
        0,
        cleanText.length >= 2 ? 2 : cleanText.length,
      );
    }

    if (cleanText.length > 2) {
      formattedText += '/' + cleanText.substring(2);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
