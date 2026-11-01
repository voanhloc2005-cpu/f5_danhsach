
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class SanPham {
  final int id;
  final String ten;
  final String moTa;
  final int gia;
  final String anh;

  const SanPham({
    required this.id,
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.anh,
  });
}

String dinhDangGia(int gia) {
  return '${gia.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  )} đ';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F5 Danh sách',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabHienTai = 0;
  int idTiepTheo = 7;

  final List<SanPham> danhSach = [
    const SanPham(
      id: 1,
      ten: 'Áo thun VHU',
      moTa: 'Áo thun sinh viên',
      gia: 180000,
      anh: 'assets/images/p1.jpg',
    ),
    const SanPham(
      id: 2,
      ten: 'Bình giữ nhiệt',
      moTa: 'Bình giữ nhiệt tiện lợi',
      gia: 250000,
      anh: 'assets/images/p2.jpg',
    ),
    const SanPham(
      id: 3,
      ten: 'Sổ tay sinh viên',
      moTa: 'Sổ tay ghi chép',
      gia: 75000,
      anh: 'assets/images/p3.jpg',
    ),
    const SanPham(
      id: 4,
      ten: 'Balo laptop',
      moTa: 'Balo đựng laptop',
      gia: 420000,
      anh: 'assets/images/p4.jpg',
    ),
    const SanPham(
      id: 5,
      ten: 'Móc khóa gỗ',
      moTa: 'Móc khóa trang trí',
      gia: 35000,
      anh: 'assets/images/p5.jpg',
    ),
    const SanPham(
      id: 6,
      ten: 'Cốc sứ in hình',
      moTa: 'Cốc sứ sinh viên',
      gia: 95000,
      anh: 'assets/images/p6.jpg',
    ),
  ];

  void themSanPham() {
    setState(() {
      danhSach.add(
        SanPham(
          id: idTiepTheo++,
          ten: 'Sản phẩm mới',
          moTa: 'Sản phẩm vừa được thêm',
          gia: 100000,
          anh: 'assets/images/p1.jpg',
        ),
      );
    });
  }

  void xoaSanPham(SanPham sp) {
    setState(() {
      danhSach.removeWhere((item) => item.id == sp.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa ${sp.ten}')),
    );
  }

  Widget taoAnh(SanPham sp, {double height = 100}) {
    return Image.asset(
      sp.anh,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(Icons.image, size: 40),
        );
      },
    );
  }

  Widget giaoDienDanhSach() {
    if (danhSach.isEmpty) {
      return const Center(
        child: Text('Chưa có sản phẩm nào'),
      );
    }

    return ListView.builder(
      itemCount: danhSach.length,
      itemBuilder: (context, index) {
        final sp = danhSach[index];

        return Dismissible(
          key: ValueKey(sp.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            xoaSanPham(sp);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: SizedBox(
                width: 65,
                child: taoAnh(sp),
              ),
              title: Text(
                sp.ten,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sp.moTa),
                  Text(
                    dinhDangGia(sp.gia),
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget giaoDienLuoi() {
    if (danhSach.isEmpty) {
      return const Center(child: Text('Chưa có sản phẩm nào'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: danhSach.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final sp = danhSach[index];

        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: taoAnh(sp)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sp.ten,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      sp.moTa,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dinhDangGia(sp.gia),
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: tabHienTai == 0
          ? giaoDienDanhSach()
          : giaoDienLuoi(),
      floatingActionButton: tabHienTai == 0
          ? FloatingActionButton(
              onPressed: themSanPham,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabHienTai,
        onDestinationSelected: (index) {
          setState(() {
            tabHienTai = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Danh sách',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view),
            label: 'Lưới',
          ),
        ],
      ),
    );
  }
}
