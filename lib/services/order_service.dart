import 'package:cryptop/app/dependency.dart';
import 'package:cryptop/models/order_model.dart';
import 'package:cryptop/models/order_models/limit_order_model.dart';
import 'package:cryptop/models/order_models/oco_model.dart';
import 'package:cryptop/models/order_models/stop_limit_model.dart';
import 'package:cryptop/services/rest_service..dart';

class OrderService {
  RestService get rest => dependency();

  Future<List<Order>?> getOpenOrders(Map<String, dynamic> order) async {
    final List json = await rest.get('orders/');
    if (json.isEmpty) return null;

    final data = json.map((e) {
      if (e['type'] == 'market') {
        return Order.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'limit') {
        return LimitOrder.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'oco') {
        return OCOOrder.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'stopLimit') {
        return StopLimitOrder.fromJson(e as Map<String, dynamic>);
      } else {
        return Order.fromJson(e as Map<String, dynamic>);
      }
    }).toList();

    return data;
  }

  Future<List<Order>?> getHistoricalOrders() async {
    final List json = await rest.get('orders/history');
    if (json.isEmpty) return null;

    final data = json.map((e) {
      if (e['type'] == 'market') {
        return Order.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'limit') {
        return LimitOrder.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'oco') {
        return OCOOrder.fromJson(e as Map<String, dynamic>);
      } else if (e['type'] == 'stopLimit') {
        return StopLimitOrder.fromJson(e as Map<String, dynamic>);
      } else {
        return Order.fromJson(e as Map<String, dynamic>);
      }
    }).toList();

    return data;
  }

  Future<Order?> createOrder(Map<String, dynamic> order) async {
    final json = await rest.post('orders/create', order);
    if (json == null) return null;

    if (json['type'] == 'market') {
      return Order.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'limit') {
      return LimitOrder.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'oco') {
      return OCOOrder.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'stopLimit') {
      return StopLimitOrder.fromJson(json as Map<String, dynamic>);
    } else {
      return Order.fromJson(json as Map<String, dynamic>);
    }
  }

  Future<bool> closeOrder(String orderId) async {
    final json = await rest.patch('orders/$orderId');

    if (json == null)
      return false;
    else
      return true;
  }

  Future<Order?> getOrder(String orderId) async {
    final json = await rest.get('orders/oneOrder/$orderId');
    if (json == null) return null;

    if (json['type'] == 'market') {
      return Order.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'limit') {
      return LimitOrder.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'oco') {
      return OCOOrder.fromJson(json as Map<String, dynamic>);
    } else if (json['type'] == 'stopLimit') {
      return StopLimitOrder.fromJson(json as Map<String, dynamic>);
    } else {
      return Order.fromJson(json as Map<String, dynamic>);
    }
  }
}
