import 'package:vania/vania.dart';
import 'package:auth/app/models/sampah.dart';

class SampahRequestController extends Controller {
  Future<Response> index() async {
    try {
      // Retrieve all requests from the database
      final requests = await SampahRequest().query().get();

      // Map each request result to SampahRequest object
      final sampahRequests = requests.map((request) {
        // Ensure request is converted into SampahRequest object before calling toMap()
        return SampahRequest.fromMap(request);
      }).toList();

      // Return the response with mapped data
      return Response.json({
        'message': 'Data ditemukan',
        'data': sampahRequests.map((request) => request.toMap()).toList(),
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat mengambil data.',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> create(Request req) async {
    req.validate({
      'name': 'required|String',
      'tanggal_penjemputan': 'required|String',
      'alamat': 'required|String',
      'berat': 'required|numeric',
    }, {
      'name.required': 'Nama tidak boleh kosong',
      'tanggal_penjemputan.required': 'Tanggal penjemputan tidak boleh kosong',
      'alamat.required': 'Alamat tidak boleh kosong',
      'berat.required': 'Berat tidak boleh kosong',
      'berat.numeric': 'Berat harus berupa angka',
    });

    // Get data from request
    final dataRequest = req.input();
    final sampahRequest = SampahRequest(
      name: dataRequest['name'],
      tanggalPenjemputan: dataRequest['tanggal_penjemputan'],
      alamat: dataRequest['alamat'],
      catatan: dataRequest['catatan'],
      kategoriSampah: dataRequest['kategori_sampah'],
      lokasi: dataRequest['lokasi'],
      berat: dataRequest['berat'],
      createdAt: DateTime.now().toIso8601String(),
    );

    // Insert new record into the database
    await SampahRequest().query().insert(sampahRequest.toMap());

    return Response.json({
      'message': 'Permintaan jemput sampah berhasil dikirim!',
      'data': sampahRequest.toMap(),
    }, 200);
  }

  Future<Response> show(Request req, int id) async {
    final sampahRequest = await SampahRequest().query().where('id', '=', id).first();
    if (sampahRequest == null) {
      return Response.json({'message': 'Data tidak ditemukan'}, 404);
    }

    // Map data to SampahRequest before calling toMap()
    final sampahRequestObj = SampahRequest.fromMap(sampahRequest);
    return Response.json({
      'message': 'Data ditemukan',
      'data': sampahRequestObj.toMap(),
    }, 200);
  }

  Future<Response> update(Request req, int id) async {
    req.validate({
      'berat': 'numeric',
      'alamat': 'string',
    });

    final sampahRequest = await SampahRequest().query().where('id', '=', id).first();
    if (sampahRequest == null) {
      return Response.json({'message': 'Data tidak ditemukan'}, 404);
    }

    final updateData = req.input();
    updateData['updated_at'] = DateTime.now().toIso8601String();

    // Update data in the database
    await SampahRequest().query().where('id', '=', id).update(updateData);
    return Response.json({
      'message': 'Data berhasil diperbarui',
      'data': updateData,
    }, 200);
  }

  Future<Response> destroy(int id) async {
    final sampahRequest = await SampahRequest().query().where('id', '=', id).first();
    if (sampahRequest == null) {
      return Response.json({'message': 'Data tidak ditemukan'}, 404);
    }

    await SampahRequest().query().where('id', '=', id).delete();
    return Response.json({'message': 'Data berhasil dihapus'}, 200);
  }
}

final SampahRequestController sampahRequestController = SampahRequestController();
