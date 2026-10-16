
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = '';
  String _jenisKelamin = 'Laki-laki';
  bool _sudahDihitung = false;

  void _hitungBMI() {
    final double? bb = double.tryParse(
      _bbController.text.replaceAll(',', '.'),
    );
    final double? tbCm = double.tryParse(
      _tbController.text.replaceAll(',', '.'),
    );

    if (bb == null ||
        tbCm == null ||
        bb <= 0 ||
        tbCm <= 0) {
      setState(() {
        _hasilBMI = null;
        _keterangan = 'Masukkan berat dan tinggi badan yang valid!';
        _sudahDihitung = true;
      });
      return;
    }

    final double tbM = tbCm / 100;
    final double hasil = bb / (tbM * tbM);

    String keterangan;

    // Kategori BMI umum untuk orang dewasa.
    if (hasil < 18.5) {
      keterangan = 'Berat badan kurang';
    } else if (hasil < 25) {
      keterangan = 'Berat badan normal';
    } else if (hasil < 30) {
      keterangan = 'Berat badan berlebih';
    } else {
      keterangan = 'Obesitas';
    }

    setState(() {
      _hasilBMI = hasil;
      _keterangan = keterangan;
      _sudahDihitung = true;
    });
  }

  void _reset() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = '';
      _sudahDihitung = false;
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const warnaUtama = Color(0xFF6C4AB6);
    const warnaLatar = Color(0xFFF5F1FF);

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 183, 162, 227),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                size: 75,
                color:  Color.fromARGB(255, 183, 162, 227),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cek Indeks Massa Tubuhmu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color:  Color.fromARGB(255, 183, 162, 227),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masukkan data diri untuk menghitung BMI.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 25),

              // Pilihan jenis kelamin
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _pilihanGender(
                              'Laki-laki',
                              Icons.male,
                               Color.fromARGB(255, 183, 162, 227),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _pilihanGender(
                              'Perempuan',
                              Icons.female,
                               Color.fromARGB(255, 183, 162, 227),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Input berat badan
              TextField(
                controller: _bbController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  hintText: 'Contoh: 55',
                  prefixIcon: const Icon(
                    Icons.monitor_weight_outlined,
                    color:  Color.fromARGB(255, 183, 162, 227),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Input tinggi badan
              TextField(
                controller: _tbController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  hintText: 'Contoh: 165',
                  prefixIcon: const Icon(
                    Icons.height,
                    color:  Color.fromARGB(255, 183, 162, 227),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Tombol hitung
              ElevatedButton.icon(
                onPressed: _hitungBMI,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('Hitung BMI'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(255, 183, 162, 227),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tombol reset
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor:  Color.fromARGB(255, 183, 162, 227),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color:  Color.fromARGB(255, 183, 162, 227)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Kartu hasil
              if (_sudahDihitung)
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          'HASIL PERHITUNGAN BMI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:  Color.fromARGB(255, 183, 162, 227),
                          ),
                        ),
                        const SizedBox(height: 18),
                        if (_hasilBMI != null) ...[
                          Text(
                            _hasilBMI!.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 183, 162, 227),
                            ),
                          ),
                          const Text(
                            'kg/m²',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _keterangan,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Kategori BMI $_jenisKelamin',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 183, 162, 227),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ] else
                          Text(
                            _keterangan,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pilihanGender(
    String gender,
    IconData ikon,
    Color warnaUtama,
  ) {
    final bool terpilih = _jenisKelamin == gender;

    return InkWell(
      onTap: () {
        setState(() {
          _jenisKelamin = gender;
          _hasilBMI = null;
          _keterangan = '';
          _sudahDihitung = false;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: terpilih
              ? warnaUtama.withValues(alpha: 0.12)
              : Colors.white,
          border: Border.all(
            color: terpilih ? warnaUtama : Colors.grey.shade300,
            width: terpilih ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              size: 32,
              color: terpilih ? warnaUtama : Colors.grey,
            ),
            const SizedBox(height: 5),
            Text(
              gender,
              style: TextStyle(
                color: terpilih ? warnaUtama : Colors.black87,
                fontWeight:
                    terpilih ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
