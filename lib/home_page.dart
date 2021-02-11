import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sest_senat/model/car.dart';
import 'package:sest_senat/edit_page.dart';
import 'package:sest_senat/criar_page.dart';
import 'package:sest_senat/providers/db_provider.dart';
import 'package:sest_senat/providers/car_api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    // bloc.getCar();
  }

  _copiarTabelas() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.copyTable();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = CarApiProvider();
    await apiProvider.getAllCars();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllCars();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All Cars deleted');
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Loading data from API..."), CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomePage(CarResponse data) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListView.builder(
          itemCount: data.results.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${data.results[index].brand}'),
            );
          },
        ),
      ],
    ));
  }

  _buildCarListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllCars(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Nenhum Carro Encontrado, clique para popular!'),
          );
        } else {
          if ((snapshot.data).isEmpty){
            return Center(
              child: Text('Nenhum Carro Encontrado! Clique nos botões do título: Novo, sincronizar tabelas (principal e backup), criar a tabela principal, deletar tudo'),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black12,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPage(data: snapshot.data[index])),
                  );
                }, child: ListTile(
                  title:Text("${snapshot.data[index].id}"),
                  leading:
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index].photo),
                  ),
                  subtitle: Wrap(children: [
                    Text("Marca: ${snapshot.data[index].brand}"),
                    Text("Ano: ${snapshot.data[index].year}"),
                    Text("modelo: ${snapshot.data[index].model}"),
                    Text("Price: ${snapshot.data[index].price}"),
                  ]),
                ),

                );
              },
            );
          }
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exemplo'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CriarPage()),
                  );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.sync_alt),
              onPressed: () async {
                await _copiarTabelas();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: Container(
            child: _buildCarListView(),
            ),
      // ),
      // body: isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : _buildCarListView(),
    );
  }
}
