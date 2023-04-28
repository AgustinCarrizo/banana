import 'package:banana/detalle/bloc/bloc_bloc.dart';
import 'package:banana/model/producto.dart';
import 'package:banana/utils/appbarcustom.dart';
import 'package:banana/utils/buttonaction.dart';
import 'package:banana/utils/variable_static.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Page extends StatefulWidget {
  final Producto producto;
  const Page({super.key, required this.producto});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarCustom(
          title: widget.producto.title ?? '',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: BlocProvider(
          create: (context) =>
              BlocBloc()..add(GetProduct(widget.producto.id ?? 0)),
          child: BlocListener<BlocBloc, BlocState>(
            listener: (context, state) {
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
                return (state is LoginState)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  state.model.producto?.images?.length ?? 0,
                              itemBuilder: (_, i) {
                                var imagen = state.model.producto?.images?[i];
                                return CachedNetworkImage(
                                  imageUrl: imagen ?? '',
                                  placeholder: (context, url) => const SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.model.producto?.description ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'USD ${oCcy.format(state.model.producto?.price ?? 0).toString()}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          ButtonAction(
                            text: 'Agregar Carrito',
                            ontop: () {},
                          )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
