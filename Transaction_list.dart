import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpense = 0;

    transactions.values.forEach((transactionList) {
      for (var item in transactionList) {
        if (item['type_transaction'] == 'IC') {
          totalIncome += item['amount_transaction'];
        } else {
          totalExpense += item['amount_transaction'];
        }
      }
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildTotalCard(
                title: 'Total Income',
                amount: totalIncome,
                color: Colors.green[50]!,
              ),
              SizedBox(height: 8.0),
              _buildTotalCard(
                title: 'Total Expense',
                amount: totalExpense,
                color: Colors.red[50]!,
                isNegative: true,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final entry = transactions.entries.elementAt(index);
                final date = entry.key;
                final transactionList = entry.value;

                return _buildTransactionCard(date, transactionList);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCard({required String title, required double amount, required Color color, bool isNegative = false}) {
    String formattedAmount = NumberFormat('#,##0.00').format(amount);

    return Card(
      elevation: 4,
      color: color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${isNegative ? '-' : ''}$formattedAmount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(String date, List<Map<String, dynamic>> transactionList) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                DateFormat('d MMM yyyy').format(DateTime.parse(date)),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              children: transactionList.map((item) {
                return _buildTransactionItem(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> item) {
    DateTime transactionDate = DateTime.parse(item['date_user']);
    String formattedDate = DateFormat('d MMM yyyy').format(transactionDate);

    String imagePath;
    switch (item['type_transaction']) {
      case 'IC':
        imagePath = 'assets/money.png';
        break;
      case 'Electricity bill':
        imagePath = 'assets/electricity_bill.png';
        break;
      case 'Internet cost':
        imagePath = 'assets/internet.png';
        break;
      case 'Food':
        imagePath = 'assets/food.png';
        break;
      case 'Travel expenses':
        imagePath = 'assets/travel_expenses.png';
        break;
      case 'Water bill':
        imagePath = 'assets/water_bill.png';
        break;
      case 'House cost':
        imagePath = 'assets/house.png';
        break;
      case 'Car fare':
        imagePath = 'assets/car.png';
        break;
      case 'Gasoline cost':
        imagePath = 'assets/gasoline_cost.png';
        break;
      case 'Medical expenses':
        imagePath = 'assets/medical.png';
        break;
      case 'Beauty expenses':
        imagePath = 'assets/beauty.png';
        break;
      default:
        imagePath = 'assets/other.png';
    }

    Color amountColor = item['type_transaction'] == 'IC' ? Colors.green : Colors.red;
    String formattedAmount = NumberFormat('#,##0.00').format(item['amount_transaction']);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Image.asset(
        imagePath,
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, size: 50, color: Colors.red);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item['type_transaction'] == 'IC' ? 'Income' : item['type_transaction']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    if (item['memo_transaction'] != null && item['memo_transaction'].isNotEmpty)
                      Icon(Icons.favorite, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${item['memo_transaction'] ?? 'No memo'}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Text(
            '\$${formattedAmount}', // ใช้ formattedAmount
            style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
