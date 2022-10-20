class Audisi{
    int? id;
    String? nama_asli;
    String? nama_panggung;
    String? no_telepon;
    String? posisi;
    String? entertaiment;
    
    Audisi({this.id, this.nama_asli, this.nama_panggung, this.no_telepon, this.posisi, this.entertaiment});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
    
        if (id != null) {
          map['id'] = id;
        }
        map['nama_asli'] = nama_asli;
        map['nama_panggung'] = nama_panggung;
        map['no_telepon'] = no_telepon;
        map['posisi'] = posisi;
        map['entertaiment'] = entertaiment;
        
        return map;
    }
    
    Audisi.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.nama_asli = map['nama_asli'];
        this.nama_panggung = map['nama_panggung'];
        this.no_telepon = map['no_telepon'];
        this.posisi = map['posisi'];
        this.entertaiment = map['entertaiment'];
    }
}

