import 'package:flutter/material.dart';

class PaginationProvider extends ChangeNotifier {
  bool isPaginationLoading = false;

// Updating the status for pagination loader
  updatePaginationLoading(bool status) {
    isPaginationLoading = status;
    notifyListeners();
  }
}
