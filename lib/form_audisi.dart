import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/audisi.dart';
      
    class FormAudisi extends StatefulWidget {
        final Audisi? audisi;
    
        FormAudisi({this.audisi});
    
        @override
        _FormAudisiState createState() => _FormAudisiState();
    }
    
    class _FormAudisiState extends State<FormAudisi> {
        DbHelper db = DbHelper();
    
        TextEditingController? nama_asli;
        TextEditingController? nama_panggung;
        TextEditingController? no_telepon;
        TextEditingController? posisi;
        TextEditingController? entertaiment;

        String? jenisposisi;
          List jenisposisis = [
            "Center",
            "Visual",
            "Lead Vocal",
            "Main Vocal",
            "Main Dancer",
            "Main Rapper"
          ];
    
        @override
        void initState() {
        nama_asli = TextEditingController(
            text: widget.audisi == null ? '' : widget.audisi!.nama_asli);
    
        nama_panggung = TextEditingController(
            text: widget.audisi == null ? '' : widget.audisi!.nama_panggung);
    
        no_telepon = TextEditingController(
            text: widget.audisi == null ? '' : widget.audisi!.no_telepon);
    
        posisi = TextEditingController(
            text: widget.audisi == null ? '' : widget.audisi!.posisi);

        entertaiment = TextEditingController(
            text: widget.audisi == null ? '' : widget.audisi!.entertaiment);
            
        super.initState();
        }
    
        @override
        Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
            title: Text('Form Audisi',
            style: TextStyle(fontFamily: "Retrophilia", fontSize: 28),
            )
            ),
            body: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
                Padding(
                padding: const EdgeInsets.only(
                    top: 20,
                ),
                child: TextField(
                    controller: nama_asli,
                    decoration: InputDecoration(
                        labelText: 'Nama Asli',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        )),
                ),
                ),
                Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                ),
                child: TextField(
                    controller: nama_panggung,
                    decoration: InputDecoration(
                        labelText: 'Nama Panggung',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        )),
                ),
                ),
                Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                ),
                child: TextField(
                    controller: no_telepon,
                    decoration: InputDecoration(
                        labelText: 'No Telepon',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        )),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    hint: Text("Pilih Posisi"),
                    value: jenisposisi,
                    items: jenisposisis
                        .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        jenisposisi = value as String;
                        posisi!.text = jenisposisi!;
                      });
                    },
                  )
                )
              ),
              Padding(
              padding: const EdgeInsets.only(
                  top: 10,
              ),
              child: TextField(
                  controller: entertaiment,
                  decoration: InputDecoration(
                      labelText: 'Entertaiment',
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      )
                    ),
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 223, 66, 66)
                  ),
                    child: (widget.audisi == null)
                        ? Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                        )
                        : Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                        ),
                    onPressed: () {
                    upsertAudisi();
                    },
                ),
                )
            ],
            ),
        );
        }
    
        Future<void> upsertAudisi() async {
        if (widget.audisi != null) {
            //update
            await db.updateAudisi(Audisi.fromMap({
            'id' : widget.audisi!.id,
            'nama_asli' : nama_asli!.text,
            'nama_panggung' : nama_panggung!.text,
            'no_telepon' : no_telepon!.text,
            'posisi' : posisi!.text,
            'entertaiment' : entertaiment!.text
            }));
            Navigator.pop(context, 'update');
        } else {
            //insert
            await db.saveAudisi(Audisi(
            nama_asli: nama_asli!.text,
            nama_panggung: nama_panggung!.text,
            no_telepon: no_telepon!.text,
            posisi: posisi!.text,
            entertaiment: entertaiment!.text
            ));
            Navigator.pop(context, 'save');
        }
        }
    }