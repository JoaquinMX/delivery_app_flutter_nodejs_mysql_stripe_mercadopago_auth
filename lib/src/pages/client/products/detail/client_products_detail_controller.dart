import 'package:delivery_app/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController {
  var counter = 0.obs;
  var price = 0.0.obs;
  List<Product> selectedProducts = <Product>[];


  void checkIfProductWasAdded(Product product) {
    price.value = product.price ?? 999999.9;

    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_bag');
        int index = selectedProducts.indexWhere((element) => element.id == product.id);
        if (index != -1) {
          counter.value = selectedProducts[index].quantity!;
          price.value = product.price! * counter.value;
        }
      }
      else {
        List<dynamic> myList = GetStorage().read('shopping_bag');
        selectedProducts = Product.fromJsonList(myList);
        int index = selectedProducts.indexWhere((element) => element.id == product.id);
        print(index);
        if (index != -1) {
          counter.value = selectedProducts[index].quantity!;
          price.value = product.price! * counter.value;
        }

      }
    }
  }

  void addItem(Product product) {
    counter.value = counter.value + 1;
    price.value = product.price! * counter.value;
  }

  void removeItem(Product product) {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      price.value = product.price! * counter.value;
    }
  }

  void addToBag(Product product) {

    if (counter.value > 0) {
      //Validar si el producto ya fue agregado con getstorage a la sesion del dispisitivo
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if (index == -1) { // No ha sido agregado
        if (product.quantity == null) {
          product.quantity = counter.value;
        }
        selectedProducts.add(product);
      }

      else { // El producto ya ha sido agregado en storage
        selectedProducts[index].quantity = counter.value;
      }

      GetStorage().write('shopping_bag', selectedProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');
    }

    else {
      Fluttertoast.showToast(msg: 'Selecciona por lo menos 1 unidad para agregarlo');
    }
  }
}