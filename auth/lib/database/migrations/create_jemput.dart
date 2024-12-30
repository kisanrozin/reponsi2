import 'package:vania/vania.dart';

class CreateJemputTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('jemput', () {
      id(); 
      string('name'); 
      date('tanggal_penjemputan');
      text('alamat');
      text('catatan', nullable: true); 
      string('kategori_sampah', nullable: true); 
      string('lokasi', nullable: true); 
      float('berat'); 
      dateTime('created_at', nullable: true); // Menggunakan dateTime jika timestamp tidak tersedia
      dateTime('updated_at', nullable: true); // Menggunakan dateTime jika timestamp tidak tersedia
      dateTime('deleted_at', nullable: true); // Menggunakan dateTime jika timestamp tidak tersedia
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('jemput'); 
  }
}
