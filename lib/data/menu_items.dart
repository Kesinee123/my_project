import 'package:flutter/material.dart';
import 'package:my_project/models/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
      itemEdit,
      itemDelete
  ];
  static const itemEdit = MenuItem(
    text: 'แก้ไข',
    icon: Icons.edit
  );

  static const itemDelete = MenuItem(
    text: 'ลบ',
    icon: Icons.delete
  );
}