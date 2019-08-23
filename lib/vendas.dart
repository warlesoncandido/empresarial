import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

TextEditingController data = TextEditingController();

class VendasPage extends StatefulWidget {
  @override
  _VendasPageState createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendas"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(

          children: <Widget>[
            DropdownButton(items: null, onChanged: null),
            Container(
              width: 200,
              child: MaskedTextField(
                escapeCharacter: "1",
                maxLength: 10,
                maskedTextFieldController: data,
                mask: "11/11/1111",
                keyboardType: TextInputType.datetime,
                inputDecoration: InputDecoration(labelText: "Data",
                ),
              ),
            ),
            TextField(
              controller:null ,
              decoration: InputDecoration(
                labelText: "Codigo da venda:",
                border: InputBorder.none
              ),
            ),
            IconButton(
                icon: Icon(Icons.add_box,color: Colors.blue,size: 50.0,),
                onPressed: null
            ),
            TextField(
              style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold ,color: Colors.black),
              controller: null,
              focusNode: FocusNode(),
              enabled: false,
              decoration: InputDecoration(
                labelText: "Total Itens:",
              ),
            ),TextField(
              style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold ,color: Colors.black),
              controller: null,
              focusNode: FocusNode(),
              enabled: false,
              decoration: InputDecoration(
                labelText: "Valor Total:",

              ),
            ),
          ],
        ),
      )),
    );

  }
}
