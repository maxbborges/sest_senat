import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sest_senat/model/car.dart';
import 'package:sest_senat/providers/db_provider.dart';
import 'package:sest_senat/home_page.dart';
class EditPage extends StatefulWidget {
  final Car data;

  const EditPage({Key key,@required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _EditPage();
}

class _EditPage extends State<EditPage>{
  @override
  Widget build(BuildContext context) {
    Car data=widget.data;

    final _brand = TextEditingController(
      text:('${data.brand}'),
    );
    final _model = TextEditingController(
      text:('${data.model}'),
    );
    final _year = TextEditingController(
      text:('${data.year}'),
    );
    final _price = TextEditingController(
      text:('${data.price}'),
    );
    final _photo = TextEditingController(
      text:('${data.photo}'),
    );

    _update() async {
      String username = _brand.text;
      await DBProvider.db.updateCar(username,data.id);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }

    _back(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Carro: ${data.id}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Brand'
            ),
            controller: _brand,
            onChanged: (text) => {},
          ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Modelo'
              ),
              controller: _model,
              onChanged: (text) => {},
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Ano'
              ),
              controller: _year,
              onChanged: (text) => {},
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Preço'
              ),
              controller: _price,
              onChanged: (text) => {},
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Foto'
              ),
              controller: _photo,
              onChanged: (text) => {},
            ),
            RaisedButton(
              onPressed: _update,
              child: Text('Alterar'),
            ),
            RaisedButton(
              onPressed: _back,
              child: Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}