import 'package:banana/home/bloc/bloc_bloc.dart';
import 'package:banana/utils/appbarcustom.dart';
import 'package:banana/utils/variable_static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:intl/intl.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  late String filter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarCustom(
          title: 'Flutter Challenge 2023',
        ),
      ),
      body: BlocProvider(
        create: (context) => BlocBloc()..add(GetProducto()),
        child: BlocListener<BlocBloc, BlocState>(
          listener: (context, state) {
            if (state is NextState) {
              Modular.to.navigate('/home');
              return;
            }
            var scaffoldMessengerKey = NavigationService.navigatorKey;
            if (state is ErrorState) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  content: Column(
                    children: const [
                      Text('Se produjo un error intente mas tarde'),
                    ],
                  ),
                ),
              );
              return;
            }
          },
          child: BlocBuilder<BlocBloc, BlocState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: 'Buscar Producto',
                      ),
                      onChanged: (value) {
                        context.read<BlocBloc>().add(
                              Filter(
                                value,
                              ),
                            );
                        filter = value;
                      },
                      onTap: () {
                        context.read<BlocBloc>().add(
                              Filter(
                                filter,
                              ),
                            );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: (state is LoginState)
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: state.model.producto?.length ?? 0,
                            itemBuilder: (_, i) {
                              var product = state.model.producto?[i];
                              return GestureDetector(
                                onTap: () {
                                  Modular.to
                                      .pushNamed('detalle', arguments: product);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18, left: 18, right: 18),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  product?.title ?? '',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Text(
                                                'USD ${oCcy.format(product?.price).toString()}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            product?.brand ?? '',
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Text(
                                            product?.description ?? '',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Text(
                                            'Stock: ${product?.stock.toString()}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
