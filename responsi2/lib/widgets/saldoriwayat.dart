import 'package:flutter/material.dart';

class SaldoRiwayatPage extends StatefulWidget {
  const SaldoRiwayatPage({super.key});

  @override
  State<SaldoRiwayatPage> createState() => _SaldoRiwayatPageState();
}

class _SaldoRiwayatPageState extends State<SaldoRiwayatPage> {
  final List<String> _riwayatTransaksi = []; // Placeholder untuk riwayat transaksi
  int _saldo = 0; // Placeholder saldo awal

  void _addTransaction(String transaksi) {
    setState(() {
      _riwayatTransaksi.add(transaksi);
      _saldo += 1000; // Contoh penambahan saldo
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _riwayatTransaksi.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saldo & Riwayat Anda",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addTransaction("Transaksi baru pada ${DateTime.now()}");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSaldoSection(),
          const Divider(thickness: 2),
          _buildRiwayatSection(),
        ],
      ),
    );
  }

  // Bagian Saldo
  Widget _buildSaldoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: const Icon(Icons.account_balance_wallet, size: 40, color: Colors.green),
          title: const Text(
            "Saldo Anda :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            "Rp. $_saldo", // Menampilkan saldo
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
          trailing: const Icon(Icons.account_circle, size: 40, color: Colors.orangeAccent),
        ),
      ),
    );
  }

  // Bagian Riwayat Transaksi
  Widget _buildRiwayatSection() {
    return Expanded(
      child: _riwayatTransaksi.isEmpty
          ? const Center(
              child: Text(
                "Riwayat transaksi kosong.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: _riwayatTransaksi.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_riwayatTransaksi[index]),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteTransaction(index);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.history, color: Colors.blueAccent),
                    title: Text(_riwayatTransaksi[index]),
                  ),
                );
              },
            ),
    );
  }
}
