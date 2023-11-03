class Cart_Item {
  String cid;
  String name;
  String img;
  int price;
  int qty;
  bool selected;

  Cart_Item(
      {required this.cid,
      required this.name,
      required this.img,
      required this.price,
      required this.qty,
      required this.selected});

  factory Cart_Item.fromJson(Map<String, dynamic> res) {
    return Cart_Item(
        cid: res['cid'],
        name: res['name'],
        img: res['img'],
        price: res['price'],
        qty: res['qty'],
        selected: res['selected']);
  }
}
