import 'package:flutter/material.dart';
import 'package:viacepflutter/model/cepModel.dart';
import 'package:viacepflutter/data/DataController.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeViewPage(),
    );
  }
}

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  State<HomeViewPage> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewPage> {

  cepModel model = cepModel();
  final response_cep = TextEditingController();
  String cep = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Api cep"),
      ),
      body: Column(
          children: <Widget>[
            TextFormField(
              maxLength: 20,
              controller: response_cep,
              
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  cep = response_cep.text;
                });
              }, 
              child: Text("serch cep"),
              style: TextButton.styleFrom(
                fixedSize: Size(200, 50)
              ),
            ),
            Column(
              children: [
                FutureBuilder<cepModel?>(
                  future: DataController().getCep(cep),
                  builder: (context, snapshot){

                    if( snapshot.connectionState == ConnectionState.waiting ){
                      return CircularProgressIndicator();
                    }
                    if( snapshot.error == true){
                      return Text("Erro ao carregar");
                    }

                    model = snapshot.data ?? model;
                    return Container(
                              margin: EdgeInsets.all(20),
                              width: 400,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black12,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text("Cep ${model.cep ?? ""}",
                                      style: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Bairro: ${model.bairro ?? ""} \nuf: ${model.uf ?? ""}\ncidade: ${model.localidade ?? ""}",
                                      style: TextStyle(
                                        fontSize: 14 
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            );

                    // Row(
                    //   children: [
                            Card(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text("title"),
                                  Text("content")
                                ],
                              ),
                            );
                            Column(
                              children: [
                                Text("Cep ${model.cep ?? ""}",style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 20
                                ),),
                                Text("Bairro: ${model.bairro ?? ""} \nuf: ${model.uf ?? ""}\ncidade: ${model.localidade ?? ""}",style: TextStyle(
                                  fontSize: 18 
                                ),)
                              ],                              
                            );
                    //   ],
                    // );
                    // Text('cep: ${model.cep ?? ""}\nbairro: ${model.bairro ?? ""}\nuf: ${model.uf ?? ""}\ncidade: ${model.localidade ?? ""}');
                    
                  }
                )
              ],
            )
          ]
      ),
    );
  }
}
