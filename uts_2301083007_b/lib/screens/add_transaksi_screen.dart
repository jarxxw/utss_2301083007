import 'package:flutter/material.dart';
import '../models/penumpang.dart';
import '../models/taxi.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _kodeTransaksiController = TextEditingController();
  final _kodePenumpangController = TextEditingController();
  final _namaPenumpangController = TextEditingController();
  final _platNomorController = TextEditingController();
  final _supirController = TextEditingController();
  final _biayaAwalController = TextEditingController();
  final _biayaPerKilometerController = TextEditingController();
  final _jumlahKiloMeterController = TextEditingController();
  String _jenisPenumpang = 'VIP';

  void _tambahTransaksi() {
    final kodeTransaksi = _kodeTransaksiController.text;
    final kodePenumpang = _kodePenumpangController.text;
    final namaPenumpang = _namaPenumpangController.text;
    final platNomor = _platNomorController.text;
    final supir = _supirController.text;
    final biayaAwal = double.tryParse(_biayaAwalController.text) ?? 0;
    final biayaPerKilometer = double.tryParse(_biayaPerKilometerController.text) ?? 0;
    final jumlahKiloMeter = double.tryParse(_jumlahKiloMeterController.text) ?? 0;

    // Validasi Input
    if (kodeTransaksi.isEmpty || kodePenumpang.isEmpty || namaPenumpang.isEmpty || platNomor.isEmpty || supir.isEmpty || biayaAwal <= 0 || biayaPerKilometer <= 0 || jumlahKiloMeter < 0) {
      _showErrorDialog("Semua field harus diisi dan biaya harus lebih dari 0.");
      return;
    }

    final penumpang = Penumpang(kode: kodePenumpang, nama: namaPenumpang);

    final transaksi = Taxi(
      kodePenumpang: kodePenumpang,
      kodeTransaksi: kodeTransaksi,
      penumpang: penumpang,
      jenisPenumpang: _jenisPenumpang,
      platNomor: platNomor,
      supir: supir,
      biayaAwal: biayaAwal,
      biayaPerKilometer: biayaPerKilometer,
      jumlahKiloMeter: jumlahKiloMeter,
    );

    double totalBayar = transaksi.totalBayar;

    Navigator.of(context).pop(transaksi);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Transaksi')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _kodeTransaksiController,
              decoration: InputDecoration(labelText: 'Kode Transaksi'),
            ),
            TextField(
              controller: _kodePenumpangController,
              decoration: InputDecoration(labelText: 'Kode Penumpang'),
            ),
            TextField(
              controller: _namaPenumpangController,
              decoration: InputDecoration(labelText: 'Nama Penumpang'),
            ),
            TextField(
              controller: _platNomorController,
              decoration: InputDecoration(labelText: 'Plat Nomor'),
            ),
            TextField(
              controller: _supirController,
              decoration: InputDecoration(labelText: 'Supir'),
            ),
            DropdownButtonFormField(
              value: _jenisPenumpang,
              items: ['VIP', 'GOLD']
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (val) => setState(() => _jenisPenumpang = val!),
              decoration: InputDecoration(labelText: 'Jenis Penumpang'),
            ),
            TextField(
              controller: _biayaAwalController,
              decoration: InputDecoration(labelText: 'Biaya Awal'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _biayaPerKilometerController,
              decoration: InputDecoration(labelText: 'Biaya Per Kilometer'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jumlahKiloMeterController,
              decoration: InputDecoration(labelText: 'Jumlah Kilometer'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Tambah Transaksi'),
              onPressed: _tambahTransaksi,
            ),
          ],
        ),
      ),
    );
  }
}
