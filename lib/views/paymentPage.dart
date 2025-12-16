import 'package:bookshop/appBar2.dart';
import 'package:bookshop/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final double totalPayment;

  const PaymentPage({Key? key, required this.totalPayment}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cardNumber = TextEditingController();
  final expiry = TextEditingController();
  final cvv = TextEditingController();

  bool isLoading = false;

  void processPayment() async {
    if (cardNumber.text.isEmpty ||
        expiry.text.isEmpty ||
        cvv.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text( AppLocalizations.of(context)!.payError)),
      );
      return;
    }

    setState(() => isLoading = true);

    await Future.delayed(Duration(seconds: 2)); // fake processing delay

    setState(() => isLoading = false);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PaymentSuccessScreen(totalPayment: widget.totalPayment)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, 4),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cardNumber,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.paymentCard,
                hintText: "4242 4242 4242 4242",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiry,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.paymentCardExpiry,
                      hintText: "12/30",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: cvv,
                    decoration: InputDecoration(
                      labelText: "CVV",
                      hintText: "123",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(

                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 40),
              ),
              onPressed: processPayment,
              child: Text(
                AppLocalizations.of(context)!.pay + " \$${widget.totalPayment.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  final double totalPayment;
  const PaymentSuccessScreen({Key? key, required this.totalPayment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,
                color: Colors.green, size: 80),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.paymentSuccess,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),


            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/account');
              },
              child: Text(AppLocalizations.of(context)!.paymentEnd),
            )
          ],
        ),
      ),
    );
  }
}