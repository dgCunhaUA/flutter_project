import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/client/cart/cart_manage_status.dart';
import 'package:flutter_project/screens/orders.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Carrinhos'),
              trailing: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.book, size: 16),
                label: const Text("Pedidos"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                    foregroundColor: Colors.black //<-- SEE HERE
                    ),
              ),
            )
          ];
        },
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            print(state.cartStatus);
            print(state.items);

            /* if (state.cartManageStatus is CartAddSuccess) {
              _showSnackBar(context, "Adicionado");
            } */

            if (state.cartStatus == CartStatus.empty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Image(
                      image: AssetImage("images/cart.png"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Adicione artigos para iniciar \n um carrinho',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Assim que adicionar artigos de um restaurante ou estabelecimento, o seu carrinho será apresentado aqui.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  print(state.items);
                  print(state.items[0]);

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.items[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Text(
                              state.items[index].desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => {
                            context.read<CartBloc>().add(
                                  AddItemToCart(item: state.items[index]),
                                ),
                            if (state.cartManageStatus is CartAddSuccess)
                              {
                                _showSnackBar(context, "Adicionado com sucesso",
                                    Colors.green),
                              }
                            else if (state.cartManageStatus is CartAddFailed)
                              {
                                _showSnackBar(
                                    context, "Erro ao adicionar", Colors.red),
                              }
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            context.read<CartBloc>().add(
                                  RemoveItemFromCart(item: state.items[index]),
                                ),
                            if (state.cartManageStatus is CartRemoveSuccess)
                              {
                                _showSnackBar(context, "Removido com sucesso",
                                    Colors.green),
                              }
                            else if (state.cartManageStatus is CartRemoveFailed)
                              {
                                _showSnackBar(
                                    context, "Erro ao remover", Colors.red),
                              }
                          },
                          child: const Icon(
                            Icons.minimize,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        ),
                        Image(
                          image: AssetImage("images/${state.items[index].img}"),
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
