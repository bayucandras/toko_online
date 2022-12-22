import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/add_product.dart';
import 'package:toko_online/screens/edit_product.dart';
import 'package:toko_online/screens/product_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  final String Url = 'https://semedhi.my.id/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(Url));
    // ignore: avoid_print
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String productId) async {
    String url = 'https://semedhi.my.id/api/products/' + productId;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (contex) => AddProduct()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('BayPedia'),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text('gagal');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => ProductDetail(
                                            product: snapshot.data['data']
                                                [index])));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  snapshot.data['data'][index]['image_url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data['data'][index]
                                          ['description']),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  EditProduct(
                                                                    product: snapshot
                                                                            .data['data']
                                                                        [index],
                                                                  )));
                                                },
                                                child: const Icon(Icons.edit)),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(snapshot
                                                          .data['data'][index]
                                                              ['id']
                                                          .toString())
                                                      .then((value) => {
                                                            setState(
                                                              () {},
                                                            ),
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('delete success'))),
                                                          });
                                                },
                                                child:
                                                    const Icon(Icons.delete)),
                                          ],
                                        ),
                                        Text(snapshot.data['data'][index]
                                            ['price']),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
