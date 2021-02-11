import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sest_senat/home_page.dart';
import 'package:sest_senat/model/car.dart';
import 'package:sest_senat/providers/db_provider.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CriarPage extends StatefulWidget {
  const CriarPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CriarPage();
}

class _CriarPage extends State<CriarPage>{
  File _image;
  final picker = ImagePicker();

  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _year = TextEditingController();
  final _price = TextEditingController();
  final _photo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    _create() async {
      final Map<String, dynamic> someMap = {
        'brand':'${_brand.text}',
        "model": '${_model.text}',
        "year": int.parse(_year.text),
        "price": int.parse(_price.text),
        "photo": 'https://www.guia4rodas.com.br/wp-content/uploads/2021/01/Volkswagem-Gol.png',
      };

      await DBProvider.db.createCarbkp(Car.fromJson(someMap));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }

    _back(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }


    return Scaffold(
        appBar: AppBar(
        title: Text("Criar"),
      ),
      body: Center(
      child: Column(
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Brand'
              ),
              controller: _brand,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Modelo'
              ),
              controller: _model,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Ano'
              ),
              controller: _year,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Preço'
              ),
              controller: _price,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            RaisedButton(
              onPressed: getImage,
              child: Text('Foto'),
            ),
            RaisedButton(
              onPressed: _create,
              child: Text('Criar'),
            ),
            RaisedButton(
              onPressed: _back,
              child: Text('Voltar'),
            )
          ]
        ),
      ),
    );
  }
}