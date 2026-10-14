
import 'package:flutter/material.dart';

void main() {
  runApp(const EcoVoltApp());
}

class EcoVoltApp extends StatelessWidget {
  const EcoVoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoVolt',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101713),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF40D98B),
          brightness: Brightness.dark,
        ),
      ),
      home: const EcoVoltHome(),
    );
  }
}

class EcoVoltHome extends StatefulWidget {
  const EcoVoltHome({super.key});

  @override
  State<EcoVoltHome> createState() => _EcoVoltHomeState();
}

class _EcoVoltHomeState extends State<EcoVoltHome> {
  // State untuk gesture Tap dan Long Press
  bool isEnergyOn = true;
  bool showDetails = false;

  // State untuk gesture Drag/Pan
  Offset iconPosition = const Offset(20, 25);

  String statusGesture = 'Belum ada gesture yang dicoba';
  int totalGesture = 0;

  final Color green = const Color(0xFF40D98B);
  final Color darkCard = const Color(0xFF1B251E);

  // Gesture 1: Tap
  void handleTap() {
    setState(() {
      isEnergyOn = !isEnergyOn;
      totalGesture++;
      statusGesture = isEnergyOn
          ? 'Tap berhasil: energi diaktifkan'
          : 'Tap berhasil: energi dinonaktifkan';
    });
  }

  // Gesture 2: Long Press
  void handleLongPress() {
    setState(() {
      showDetails = !showDetails;
      totalGesture++;
      statusGesture = showDetails
          ? 'Long Press berhasil: detail energi ditampilkan'
          : 'Long Press berhasil: detail energi disembunyikan';
    });
  }

  // Gesture 3: Drag/Pan
  void handlePanUpdate(DragUpdateDetails details, Size areaSize) {
    const double iconSize = 72;

    setState(() {
      final newX = (iconPosition.dx + details.delta.dx)
          .clamp(0.0, (areaSize.width - iconSize).clamp(0.0, double.infinity))
          .toDouble();

      final newY = (iconPosition.dy + details.delta.dy)
          .clamp(0.0, (areaSize.height - iconSize).clamp(0.0, double.infinity))
          .toDouble();

      iconPosition = Offset(newX, newY);
      statusGesture = 'Drag/Pan aktif: ikon sedang dipindahkan';
    });
  }

  void handlePanEnd(DragEndDetails details) {
    setState(() {
      totalGesture++;
      statusGesture = 'Drag/Pan berhasil: posisi ikon berubah';
    });
  }

  // Tombol untuk memudahkan uji coba di laptop
  void resetDemo() {
    setState(() {
      isEnergyOn = true;
      showDetails = false;
      iconPosition = const Offset(20, 25);
      statusGesture = 'Pengujian di-reset. Silakan coba lagi';
      totalGesture = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  const SizedBox(height: 28),
                  buildWelcome(),
                  const SizedBox(height: 22),
                  buildMainEnergyCard(),
                  const SizedBox(height: 24),
                  buildSectionTitle(
                    'Ringkasan Energi',
                    'Informasi penggunaan listrik simulasi',
                  ),
                  const SizedBox(height: 12),
                  buildSummaryCards(),
                  const SizedBox(height: 24),
                  buildSectionTitle(
                    'Kanvas Energi Interaktif',
                    'Pindahkan ikon petir dengan drag atau pan',
                  ),
                  const SizedBox(height: 12),
                  buildDragArea(),
                  const SizedBox(height: 24),
                  buildGestureTestPanel(),
                  const SizedBox(height: 24),
                  buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: green.withOpacity(0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.bolt, color: green, size: 30),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EcoVolt',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'SMART ENERGY EXPERIENCE',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: darkCard,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.eco_outlined),
        ),
      ],
    );
  }

  Widget buildWelcome() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat datang!',
          style: TextStyle(color: Colors.white60),
        ),
        SizedBox(height: 6),
        Text(
          'Energi dalam Kendali.',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Coba sentuh, tahan, dan geser elemen di aplikasi.',
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
      ],
    );
  }

  // Stack digunakan untuk menumpuk ikon dekoratif di kartu.
  // Tap dan Long Press memberikan perubahan visual pada kartu.
  Widget buildMainEnergyCard() {
    return GestureDetector(
      onTap: handleTap,
      onLongPress: handleLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnergyOn
                ? [
                    const Color(0xFF20573A),
                    const Color(0xFF153324),
                  ]
                : [
                    const Color(0xFF414943),
                    const Color(0xFF252C27),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isEnergyOn ? green : Colors.white24,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                Icons.bolt,
                size: 85,
                color: Colors.white.withOpacity(0.09),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isEnergyOn
                          ? Icons.check_circle
                          : Icons.power_settings_new,
                      color: isEnergyOn ? green : Colors.orangeAccent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isEnergyOn ? 'ENERGI AKTIF' : 'ENERGI NONAKTIF',
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  'Daya Listrik Rumah',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 5),
                Text(
                  isEnergyOn ? '718 Watt' : '0 Watt',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isEnergyOn
                      ? 'Sistem pemantauan berjalan'
                      : 'Sistem dalam keadaan nonaktif',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                if (showDetails) ...[
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, size: 19),
                      SizedBox(width: 8),
                      Text('Lampu LED: 18 Watt'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.ac_unit, size: 19),
                      SizedBox(width: 8),
                      Text('AC: 450 Watt'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.water_drop_outlined, size: 19),
                      SizedBox(width: 8),
                      Text('Pompa air: 250 Watt'),
                    ],
                  ),
                ],
                const SizedBox(height: 18),
                Text(
                  showDetails
                      ? 'Tekan dan tahan lagi untuk menyembunyikan detail'
                      : 'Tap untuk mengubah status • Tahan untuk detail',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget buildSummaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 520;

        final consumptionCard = buildSummaryCard(
          icon: Icons.bolt,
          title: 'Konsumsi Hari Ini',
          value: isEnergyOn ? '8.4 kWh' : '0 kWh',
          caption: 'Data simulasi',
          color: green,
        );

        final costCard = buildSummaryCard(
          icon: Icons.payments_outlined,
          title: 'Estimasi Biaya',
          value: isEnergyOn ? 'Rp12.600' : 'Rp0',
          caption: 'Perkiraan penggunaan',
          color: Colors.orangeAccent,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: consumptionCard),
              const SizedBox(width: 12),
              Expanded(child: costCard),
            ],
          );
        }

        return Column(
          children: [
            consumptionCard,
            const SizedBox(height: 12),
            costCard,
          ],
        );
      },
    );
  }

  Widget buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required String caption,
    required Color color,
  }) {
    return Card(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFF303B33)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    caption,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drag/Pan: ikon petir dapat dipindahkan dengan mouse atau sentuhan.
  Widget buildDragArea() {
    return Card(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF303B33)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.open_with, size: 19, color: Colors.white70),
                  SizedBox(width: 8),
                  Text(
                    'AREA DRAG / PAN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final areaSize = Size(constraints.maxWidth, 220);

                return Container(
                  height: areaSize.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111914),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFF35473A)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: GridPainter(),
                          ),
                        ),
                        Positioned(
                          left: iconPosition.dx,
                          top: iconPosition.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              handlePanUpdate(details, areaSize);
                            },
                            onPanEnd: handlePanEnd,
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: green.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: green, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: green.withOpacity(0.15),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.bolt,
                                size: 42,
                                color: green,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          right: 12,
                          child: Text(
                            'GESER IKON PETIR',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white38,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Klik dan tahan ikon petir, lalu gerakkan mouse untuk memindahkannya.',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // Panel uji coba diletakkan di bawah aplikasi.
  Widget buildGestureTestPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: const Color(0xFF202A23),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: green.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.touch_app, color: green, size: 25),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'UJI COBA GESTURE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: green.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$totalGesture aksi',
                  style: TextStyle(color: green, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Lakukan ketiga gesture di atas, lalu lihat hasil perubahannya.',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 18),

          buildGestureRow(
            number: '01',
            title: 'Tap',
            description: 'Klik kartu energi untuk mengubah status.',
            icon: Icons.touch_app,
          ),
          const SizedBox(height: 14),
          buildGestureRow(
            number: '02',
            title: 'Long Press',
            description: 'Tekan dan tahan kartu untuk melihat detail.',
            icon: Icons.pan_tool_alt,
          ),
          const SizedBox(height: 14),
          buildGestureRow(
            number: '03',
            title: 'Drag / Pan',
            description: 'Geser ikon petir ke posisi yang berbeda.',
            icon: Icons.open_with,
          ),

          const SizedBox(height: 18),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          const Text(
            'STATUS PENGUJIAN',
            style: TextStyle(
              color: Color(0xFF40D98B),
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 9),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF101713),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusGesture,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: resetDemo,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Pengujian'),
              style: OutlinedButton.styleFrom(
                foregroundColor: green,
                side: BorderSide(color: green.withOpacity(0.6)),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGestureRow({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: green.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: green, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number. $title',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFooter() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.eco_outlined, color: green, size: 28),
          const SizedBox(height: 8),
          const Text(
            'EcoVolt — Smart Energy Monitor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'SDG 7 • Energi Bersih dan Terjangkau',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
          const SizedBox(height: 5),
          const Text(
            'Ketua: MUH. FADIL IMAMSYAH',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
          const Text(
            'Anggota: YUSRIL',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// Grid dekoratif untuk area drag.
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF26352B)
      ..strokeWidth = 0.7;

    const spacing = 25.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => false;
}
