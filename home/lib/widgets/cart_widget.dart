import 'package:flutter/material.dart';
import 'package:home/models/cart_item.dart';

class CartWidget extends StatefulWidget {
  final Cart_Item cart_item;
  const CartWidget({Key? key, required this.cart_item}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final List<int> qty_list = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    var cart_item = widget.cart_item;
    return Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: InkWell(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    Image.network(cart_item.img, height: 90, width: 90),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Text(
                            cart_item.name,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        DropdownButton(
                          value: cart_item.qty,
                          items: qty_list.map((val) {
                            return DropdownMenuItem<int>(
                                value: val, child: Text('${val}'));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              cart_item.qty = value!;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Checkbox(
                  value: cart_item.selected,
                  onChanged: (value) {
                    setState(() {
                      cart_item.selected = value!;
                    });
                  },
                )
              ],
            )
          ]),
        ));
  }
}
