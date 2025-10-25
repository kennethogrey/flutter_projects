import 'package:flutter/material.dart';
import 'package:flutterwalletapp/utils/my_button.dart';
import 'package:flutterwalletapp/utils/my_card.dart';
import 'package:flutterwalletapp/utils/my_list_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: Icon(Icons.monetization_on, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, size: 32, color: Colors.pink[100]),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, size: 32, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "My",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(" Cards", style: TextStyle(fontSize: 26)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),
            //cards
            Container(
              height: 200,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: [
                  MyCard(
                    balance: 5200.25,
                    cardNumber: 12345678,
                    expiryMonth: 10,
                    expiryYear: 25,
                    color: Colors.deepPurple[400],
                  ),
                  MyCard(
                    balance: 324.99,
                    cardNumber: 392389,
                    expiryMonth: 12,
                    expiryYear: 27,
                    color: Colors.blue[400],
                  ),
                  MyCard(
                    balance: 420.42,
                    cardNumber: 12345678,
                    expiryMonth: 8,
                    expiryYear: 28,
                    color: Colors.green[400],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(activeDotColor: Colors.grey.shade700),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    iconImagePath: 'lib/icons/send-money.png',
                    buttonText: 'Send',
                  ),
                  MyButton(
                    iconImagePath: 'lib/icons/credit-card.png',
                    buttonText: 'Pay',
                  ),
                  MyButton(
                    iconImagePath: 'lib/icons/bill.png',
                    buttonText: 'Bills',
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  MyListTile(
                    iconImagePath: 'lib/icons/statistics.png',
                    tileTitle: 'Statictics',
                    tileSubTitle: 'Payments and Incomes',
                  ),

                  MyListTile(
                    iconImagePath: 'lib/icons/transaction.png',
                    tileTitle: 'Transactions',
                    tileSubTitle: 'Transaction History',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
