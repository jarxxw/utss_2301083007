import 'penumpang.dart';

class Taxi {
  String kodeTransaksi;
  String kodePenumpang;
  Penumpang penumpang; 
  String jenisPenumpang;
  String platNomor;
  String supir;
  double biayaAwal;
  double biayaPerKilometer;
  double jumlahKiloMeter;

  Taxi({
    required this.kodePenumpang,
    required this.kodeTransaksi,
    required this.penumpang,
    required this.jenisPenumpang,
    required this.platNomor,
    required this.supir,
    required this.biayaAwal,
    required this.biayaPerKilometer,
    required this.jumlahKiloMeter,
  });

  double get totalBayar {
    double discount = 0;
    if (jenisPenumpang == 'VIP') {
      discount = 5; 
    } else if (jenisPenumpang == 'GOLD') {
      discount = 2; 
    }

    double totalBiaya = biayaAwal + 
        (biayaPerKilometer * (jumlahKiloMeter > discount ? jumlahKiloMeter - discount : 0));
    return totalBiaya;
  }
}
