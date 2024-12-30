import 'package:flutter/material.dart';

class JemputSampahPage extends StatefulWidget {
  const JemputSampahPage({super.key});

  @override
  State<JemputSampahPage> createState() => _JemputSampahPageState();
}

class _JemputSampahPageState extends State<JemputSampahPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();

  String _selectedItem = 'Item 1'; // Dropdown default value
  String _selectedLokasi = 'Lokasi 1'; // Default lokasi
  final List<String> _kategoriSampah = ['Item 1', 'Item 2', 'Item 3'];
  final List<String> _lokasiList = [
    'Lokasi 1',
    'Lokasi 2',
    'Lokasi 3',
    'Lokasi 4'
  ]; // Daftar lokasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jemput Sampah"),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mohon isi data dibawah ini dengan benar",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTextField("Nama Pengguna", "Masukan nama lengkap", _namaController),
                const SizedBox(height: 10),
                _buildDropdownField(),
                const SizedBox(height: 10),
                _buildDropdownLokasiField(), // Tambahkan Dropdown Lokasi
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBeratField("Berat (Kg)", _beratController),
                    _buildStaticField("Harga (per Kg)", "Rp. 1500/Kg"),
                  ],
                ),
                const SizedBox(height: 10),
                _buildTextField("Tanggal Penjemputan", "Masukan tanggal", _tanggalController,
                    keyboardType: TextInputType.datetime),
                const SizedBox(height: 10),
                _buildTextField("Alamat", "Masukan alamat", _alamatController),
                const SizedBox(height: 10),
                _buildTextField(
                    "Catatan Tambahan (Opsional)", "Masukan catatan tambahan anda", _catatanController),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmation();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: const Text("Jemput Sekarang",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dropdown Lokasi Field Builder
  Widget _buildDropdownLokasiField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pilih Lokasi", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedLokasi,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          items: _lokasiList.map((lokasi) {
            return DropdownMenuItem(
              value: lokasi,
              child: Text(lokasi),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLokasi = value!;
            });
          },
        ),
      ],
    );
  }

  // TextField Builder
  Widget _buildTextField(String label, String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$label tidak boleh kosong";
            }
            return null;
          },
        ),
      ],
    );
  }

  // Berat Field with Validator for Max 50Kg
  Widget _buildBeratField(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Masukkan berat (maks 50Kg)",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "$label tidak boleh kosong";
              }
              final berat = int.tryParse(value);
              if (berat == null || berat < 1 || berat > 50) {
                return "Berat harus antara 1 - 50 Kg";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Static Field Builder
  Widget _buildStaticField(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  // Dropdown Builder
  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Kategori Sampah", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _selectedItem,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          items: _kategoriSampah.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value!;
            });
          },
        ),
      ],
    );
  }

  // Confirmation Dialog
  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Permintaan jemput sampah berhasil dikirim!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
