import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:stylish/Models/product_model.dart';
import 'package:stylish/Models/user_model.dart';

class ApiService {
  static const String baseUrl =
      'https://x8ki-letl-twmt.n7.xano.io/api:ULOa3tB6';
  static const String signupEndpoint = '$baseUrl/auth/signup';

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final client =
        HttpClient()..badCertificateCallback = (cert, host, port) => true;
    final httpClient = http.Client();
    try {
      final response = await httpClient.post(
        Uri.parse(signupEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    } finally {
      httpClient.close();
    }
  }

  //login user
  Future<User> login({required String email, required String password}) async {
    final body = jsonEncode({'email': email, 'password': password});
    print('API request URL: $baseUrl/auth/login');
    print('API request body: $body');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('API response status: ${response.statusCode}');
      print('API response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map<String, dynamic>) {
            return User.fromJson(jsonResponse);
          } else {
            return User(email: email, password: password);
          }
        } catch (e) {
          print('JSON parsing error: $e');
          return User(email: email, password: password);
        }
      } else if (response.statusCode == 405) {
        throw Exception(
          'Method not allowed. Please check the API endpoint configuration.',
        );
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password.');
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  // Fetch products
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(
      'https://x8ki-letl-twmt.n7.xano.io/api:t6rLUCEm/product',
    ); // Adjust endpoint if needed

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        // Convert each item in the list to a Product object
        List<Product> products =
            jsonList.map((json) => Product.fromMap(json)).toList();

        return products;
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception occurred while fetching products: $e');
      return [];
    }
  }
}
