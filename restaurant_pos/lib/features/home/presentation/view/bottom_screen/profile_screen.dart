import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/presentation/viewmodel/user_v_m.dart';
import 'package:restaurant_pos/features/home/presentation/viewmodel/home_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(userVMProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userVMProvider.notifier).getUserData();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          loadProfile(user: userState.user, context: context),
          ElevatedButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: const Text(
              "Logout",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

Widget loadProfile({
  StudentEntity? user,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Cover image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            "assets/images/splash.jpg", // default coverpage image
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    // Profile image
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: ( user!.image != "") 
                                  ? Image.network(
                                      ApiEndpoints.imageUrl + user.image!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/profile.jpg",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              Text(
                "${user.fname} ${user.lname}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    user.phone ?? "No phone number",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        )
      ],
    ),
  );
}

// Widget loadProfile({
//   StudentEntity? user,
//   required BuildContext context,
// }) {
//   return SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     physics: const BouncingScrollPhysics(),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child:  Container(
//                 height: 300,
//                 color: Colors.white,
//                 width: double.infinity,
//                 child: Stack(
//                   alignment: Alignment.topCenter,
//                   children: [
//                     // Cover image
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                           ),
//                           child: Image.asset(
//                             "assets/images/splash.jpg", // default coverpage image
//                             height: 220,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Profile image
//                     Positioned(
//                       bottom: 0,
//                       child: Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 80,
//                             backgroundColor: Colors.white,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: user!.image != null
//                                   ? Image.network(
//                                       ApiEndpoints.imageUrl + user.image!,
//                                       height: 150,
//                                       width: 150,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Image.asset(
//                                       "assets/images/profile.jpg",
//                                       height: 150,
//                                       width: 150,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

