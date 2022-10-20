import 'package:flutter/material.dart';
import 'form_audisi.dart';
import 'database/db_helper.dart';
import 'model/audisi.dart';
    
    class ListAudisiPage extends StatefulWidget {
        const ListAudisiPage({ Key? key }) : super(key: key);
    
        @override
        _ListAudisiPageState createState() => _ListAudisiPageState();
    }
    
    class _ListAudisiPageState extends State<ListAudisiPage> {
        List<Audisi> listAudisi = [];
        DbHelper db = DbHelper();
    
        @override
        void initState() {
        _getAllAudisi();
        super.initState();
        }
    
        @override
        Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Color.fromARGB(221, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.black87,
                title: Center(
                child: Text("DAFTAR AUDISI IDOL KPOP",
                style: TextStyle(fontFamily: "Retrophilia", fontSize: 28),
                ),
                ),
            ),
            body: ListView.builder(
                itemCount: listAudisi.length,
                itemBuilder: (context, index) {
                    Audisi audisi = listAudisi[index];
                    return Padding(
                    padding: const EdgeInsets.only(
                        top: 10
                    ),
                    child: ListTile(
                        leading: Icon(
                        Icons.person_pin_rounded,
                        color: Color.fromARGB(255, 223, 66, 66), 
                        size: 45,
                        
                        ),
                        title: Text(
                        '${audisi.nama_asli}'
                        ),
                        subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 4, 
                            ),
                            child: Text("Nama Panggung: ${audisi.nama_panggung}"),
                            ), 
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 4,
                            ),
                            child: Text("No Telepon: ${audisi.no_telepon}"),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 4,
                            ),
                            child: Text("Posisi: ${audisi.posisi}"),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 4, 
                            ),
                            child: Text("Entertaiment: ${audisi.entertaiment}"),
                            )
                        ],
                        ),
                        trailing: 
                        FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                            children: [
                            IconButton(
                                onPressed: () {
                                _openFormEdit(audisi);
                                },
                                icon: Icon(Icons.edit,
                                color: Color.fromARGB(255, 0, 0, 0),)
                            ),
                            IconButton(
                                icon: Icon(Icons.delete,
                                color: Color.fromARGB(255, 0, 0, 0),),
                                onPressed: (){
                                //membuat dialog konfirmasi hapus
                                AlertDialog hapus = AlertDialog(
                                    title: Text("Information"),
                                    content: Container(
                                    height: 100, 
                                    child: Column(
                                        children: [
                                        Text(
                                            "Yakin ingin Menghapus Data ${audisi.nama_asli}"
                                        )
                                        ],
                                    ),
                                    ),
                                    //terdapat 2 button.
                                    //jika ya maka jalankan _deleteAudisi() dan tutup dialog
                                    //jika tidak maka tutup dialog
                                    actions: [
                                    TextButton(
                                        onPressed: (){
                                        _deleteAudisi(audisi, index);
                                        Navigator.pop(context);
                                        }, 
                                        child: Text("Ya")
                                    ), 
                                    TextButton(
                                        child: Text('Tidak'),
                                        onPressed: () {
                                        Navigator.pop(context);
                                        },
                                    ),
                                    ],
                                );
                                showDialog(context: context, builder: (context) => hapus);
                                }, 
                            )
                            ],
                        ),
                        ),
                    ),
                    );
                }),
                //membuat button mengapung di bagian bawah kanan layar
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 223, 66, 66),
                    child: Icon(Icons.add), 
                    onPressed: (){
                    _openFormCreate();
                    },
                ),
            
        );
        }
    
        //mengambil semua data Audisi
        Future<void> _getAllAudisi() async {
        //list menampung data dari database
        var list = await db.getAllAudisi();
    
        //ada perubahanan state
        setState(() {
            //hapus data pada listAudisi
            listAudisi.clear();
    
            //lakukan perulangan pada variabel list
            list!.forEach((audisi) {
            
            //masukan data ke listAudisi
            listAudisi.add(Audisi.fromMap(audisi));
            });
        });
        }
    
        //menghapus data Audisi
        Future<void> _deleteAudisi(Audisi audisi, int position) async {
        await db.deleteAudisi(audisi.id!);
        setState(() {
            listAudisi.removeAt(position);
        });
        }
    
        // membuka halaman tambah Audisi
        Future<void> _openFormCreate() async {
        var result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormAudisi()));
        if (result == 'save') {
            await _getAllAudisi();
        }
        }
    
        //membuka halaman edit Audisi
        Future<void> _openFormEdit(Audisi audisi) async {
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => FormAudisi(audisi: audisi)));
        if (result == 'update') {
            await _getAllAudisi();
        }
        }
    }