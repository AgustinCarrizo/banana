import 'package:banana/login/bloc/bloc_bloc.dart';
import 'package:banana/model/login.dart';
import 'package:banana/utils/variable_static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => BlocBloc(),
          child: BlocListener<BlocBloc, BlocState>(
            listener: (context, state) {
              if (state is NextState) {
                Modular.to.navigate('/home');
                return;
              }
              var scaffoldMessengerKey = NavigationService.navigatorKey;
              if (state is ErrorCredencialState) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Column(
                      children: const [
                        Text('Usuario o Contrasenia son invalidas '),
                      ],
                    ),
                  ),
                );
                return;
              }
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
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Flexible(
                          flex: 4,
                          child: Align(
                            child: Text(
                              'Bienvenidos',
                              style: TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TextFormFieldCustom(
                          labelText: 'Usuario',
                          regExp: r'^(?=.*?[a-z]).{10,}$',
                          valueString: (value) {
                            email = value;
                          },
                          obscureText: false,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                            labelText: 'Contraseñia',
                            regExp: r'^(?=.*?[A-Z])(?=.*?[a-z]).{7,}$',
                            valueString: (value) {
                              password = value;
                            }),
                        (state is LoginState)
                            ? const Flexible(
                                child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularProgressIndicator(),
                              ))
                            : Flexible(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.purple),
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.zero))),
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          var login = Login(
                                              email ?? '', password ?? '');
                                          context.read<BlocBloc>().add(
                                                LoginPost(
                                                  login,
                                                ),
                                              );
                                        }
                                      },
                                      child: const Text('Ingresar'),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.valueString,
    required this.regExp,
    required this.labelText,
    this.obscureText = true,
  });
  final Function(String?)? valueString;
  final String regExp;
  final String labelText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        labelText: labelText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Introducir un $labelText';
        } else {
          RegExp regex = RegExp(regExp);
          if (!regex.hasMatch(value)) {
            return 'Introducir $labelText valida ';
          } else {
            return null;
          }
        }
      },
      onChanged: valueString,
    );
  }
}
