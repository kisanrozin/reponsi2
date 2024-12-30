import 'package:vania/vania.dart';

class SampahRequest extends Model {
  // Define the table name with a different name
  String tableName = 'jemputsampahrequests';

  // Define the columns in the table
  int? id;
  String? name;
  String? tanggalPenjemputan;
  String? alamat;
  String? catatan;
  String? kategoriSampah;
  String? lokasi;
  int? berat;
  String? createdAt;

  // Constructor to create an object from data
  SampahRequest({
    this.id,
    this.name,
    this.tanggalPenjemputan,
    this.alamat,
    this.catatan,
    this.kategoriSampah,
    this.lokasi,
    this.berat,
    this.createdAt,
  });

  // Method to convert the object into a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tanggal_penjemputan': tanggalPenjemputan,
      'alamat': alamat,
      'catatan': catatan,
      'kategori_sampah': kategoriSampah,
      'lokasi': lokasi,
      'berat': berat,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  // Method to create an object from database data
  SampahRequest.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    tanggalPenjemputan = map['tanggal_penjemputan'];
    alamat = map['alamat'];
    catatan = map['catatan'];
    kategoriSampah = map['kategori_sampah'];
    lokasi = map['lokasi'];
    berat = map['berat'];
    createdAt = map['created_at'];
  }
}
