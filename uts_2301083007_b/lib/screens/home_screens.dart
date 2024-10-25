import 'package:flutter/material.dart';
import 'add_transaksi_screen.dart';
import '../models/taxi.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Taxi> _transaksiList = [];

  void _navigateToAddTransaction() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddTransactionScreen()),
    );

    if (result != null && result is Taxi) {
      setState(() {
        _transaksiList.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aplikasi Taxi')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Pesan Taxi'),
              onTap: _navigateToAddTransaction,
            ),
          ],
        ),
      ),
      body: _transaksiList.isEmpty
          ? Center(child: Text('ayoo pesan klik tombol pada pojok kiri atas '))
          : ListView.builder(
              itemCount: _transaksiList.length,
              itemBuilder: (context, index) {
                final transaksi = _transaksiList[index];
                return ListTile(
                  title: Text('Kode Transaksi: ${transaksi.kodeTransaksi}'),
                  subtitle: Text(
                    'Kode Penumpang: ${transaksi.kodePenumpang}\n'
                    'Nama Penumpang: ${transaksi.penumpang.nama}\n'
                    'Jenis: ${transaksi.jenisPenumpang}\n'
                    'Plat Nomor: ${transaksi.platNomor}\n'
                    'Supir: ${transaksi.supir}\n'
                    'Biaya Awal: ${transaksi.biayaAwal}\n'
                    'Biaya Per Kilometer: ${transaksi.biayaPerKilometer}\n'
                    'Jumlah Kilometer: ${transaksi.jumlahKiloMeter}\n'
                    'Total Bayar: ${transaksi.totalBayar}',
                  ),
                );
              },
            ),
    );
  }
}
