import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_pos/config/constants/hive_table_constant.dart';
import 'package:restaurant_pos/features/menu/data/model/menu_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(MenuHiveModelAdapter());

    // Add dummy data
    await addDummyMenu();
  }

// ======================== Batch Queries ========================
  Future<void> addMenu(MenuHiveModel menu) async {
    var box = await Hive.openBox<MenuHiveModel>(HiveTableConstant.menuBox);
    await box.put(menu.menuId, menu);
  }

  Future<List<MenuHiveModel>> getAllMenus() async {
    var box = await Hive.openBox<MenuHiveModel>(HiveTableConstant.menuBox);
    var menues = box.values.toList();
    box.close();
    return menues;
  }

// ======================== Student Queries ========================
// Future<void> addStudent(AuthHiveModel student) async {
//   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//   await box.put(student.studentId, student);
// }

// Future<List<AuthHiveModel>> getAllStudents() async {
//   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//   var students = box.values.toList();
//   box.close();
//   return students;
// }

// //Login
// Future<AuthHiveModel?> login(String username, String password) async {
//   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//   var student = box.values.firstWhere((element) =>
//       element.username == username && element.password == password);
//   box.close();
//   return student;
// }

// ======================== Insert Dummy Data ========================
// Batch Dummy Data
Future<void> addDummyMenu() async {
  // check of batch box is empty
  var box = await Hive.openBox<MenuHiveModel>(HiveTableConstant.menuBox);
  if (box.isEmpty) {
    final menu1 = MenuHiveModel(
        menuName: 'Momo', price: 12.99, image: '');
    final menu2 = MenuHiveModel(
        menuName: 'Pizza', price: 12.99, image: '');
    final menu3 = MenuHiveModel(
        menuName: 'Hamburger',
        price: 12.99,
        image: '');
    final menu4 = MenuHiveModel(
        menuName: 'Chowmin', price: 12.99, image: '');

    List<MenuHiveModel> menus = [menu1, menu2, menu3, menu4];

    // Insert batch with key
    for (var menu in menus) {
      await addMenu(menu);
    }
  }

  // ======================== Delete All Data ========================
  // Future<void> deleteAllData() async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
  //   await box.clear();
  // }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.menuBox);
    // await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
    // await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
    await Hive.deleteFromDisk();
  }
}
}