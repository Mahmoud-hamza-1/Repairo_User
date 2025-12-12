// import 'package:repairo_app_new/business_logic/RequestDetailsCubit/request_details_cubit.dart';
// import 'package:repairo_app_new/business_logic/UserRequestsCubit/user_requests_cubit.dart';
// import 'package:repairo_app_new/business_logic/UserRequestsCubit/user_requests_states.dart';
// import 'package:repairo_app_new/core/constants/app_constants.dart';
// import 'package:repairo_app_new/data/models/user_requests_model.dart';
// import 'package:repairo_app_new/data/repository/requset_details_repository.dart';
// import 'package:repairo_app_new/data/web_services/request_details_webservices.dart';
// import 'package:repairo_app_new/presentation/screens/request_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class UserRequests extends StatefulWidget {
//   @override
//   UserRequestsState createState() => UserRequestsState();
// }

// class UserRequestsState extends State<UserRequests> {
//   String? status;
//   String searchKeyword = '';

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<UserRequestsCubit>(context).getUserRequests();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildFilterOptions(),
//           Expanded(child: buildBlocWidget()),
//         ],
//       ),
//     );
//   }

//   Widget buildFilterOptions() {
//     return Padding(
//         padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               hint: Text("Status"),
//               value: status,
//               items: [
//                 null,
//                 'accepted',
//                 'ended',
//                 'canceled',
//                 'pending',
//                 'rejected'
//               ].map((status) {
//                 return DropdownMenuItem(
//                   value: status,
//                   child: Text(
//                     status == null ? "كل الطلبات" : status.toString(),
//                     style: TextStyle(fontFamily: "Cairo"),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   status = value;
//                   print(status);
//                 });
//                 context
//                     .read<UserRequestsCubit>()
//                     .getUserRequests(status: status);
//               },
//             ),
//           ],
//         ));
//   }

//   Widget buildBlocWidget() {
//     return BlocBuilder<UserRequestsCubit, UserRequestsStates>(
//       builder: (context, state) {
//         if (state is UserRequestsLoaded) {
//           final requests = state.requests;

//           // فلترة حسب الاسم
//           final filteredrequests = requests.where((requsest) {
//             final name = requsest.id!.toLowerCase() ?? '';
//             return name.contains(searchKeyword);
//           }).toList();

//           if (filteredrequests.isEmpty) {
//             return Center(
//                 child: Text(
//               "لا يوجد حجوزات لعرضها",
//               style: TextStyle(fontFamily: "Cairo"),
//             ));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             itemCount: filteredrequests.length,
//             itemBuilder: (ctx, index) =>
//                 buildRequestCard(filteredrequests[index]),
//           );
//         } else {
//           return Center(
//               child: CircularProgressIndicator(color: Colors.deepPurple));
//         }
//       },
//     );
//   }

//   Widget buildRequestCard(RUserRequestData request) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => MultiBlocProvider(
//               providers: [
//                 BlocProvider(
//                   create: (context) => RequestDetailsCubit(
//                       RequsetDetailsRepository(RequestDetailsWebservices())),
//                 ),
//               ],
//               child: RequestDetailsScreen(
//                 id: request.id!,
//               ),
//             ));
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 4,
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // صورة الطلب
//             //if (request.image != null && request.image!.isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               child: Image.network(
//                 request.service!.image
//                     .toString()
//                     .  ('127.0.0.1', AppConstants.baseaddress),
//                 width: double.infinity,
//                 height: 180,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   height: 180,
//                   width: double.infinity,
//                   color: Colors.grey[300],
//                   child: Icon(Icons.broken_image, size: 40),
//                 ),
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.settings, size: 16, color: Colors.grey[700]),
//                       SizedBox(width: 6),
//                       Text(
//                         'الخدمة: ${request.service?.name ?? request.technicianAccount?.name ?? "غير معروف"}',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.person, size: 16, color: Colors.grey[700]),
//                       SizedBox(width: 6),
//                       Text(
//                         'المهني: ${request.technicianAccount?.name ?? "غير معروف"}',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   // التاريخ والوقت
//                   Row(
//                     children: [
//                       Icon(Icons.calendar_today,
//                           size: 16, color: Colors.grey[700]),
//                       SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           '${request.scheduledDate ?? "--"} - ${request.scheduledTime ?? "--"}',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Container(
//                           width: 65,
//                           height: 20,
//                           decoration: BoxDecoration(
//                               color: request.status == 'accepted'
//                                   ? Colors.green
//                                   : request.status == "rejected"
//                                       ? Colors.red
//                                       : request.status == "ongoing"
//                                           ? Colors.blueGrey
//                                           : request.status == "pending"
//                                               ? Colors.grey
//                                               : Colors.amber,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                           child: Center(
//                               child: Text(
//                             "${request.status}",
//                             style: TextStyle(),
//                           )))
//                     ],
//                   ),
//                   SizedBox(height: 8),

//                   // الموقع
//                   Row(
//                     children: [
//                       Icon(Icons.location_on,
//                           size: 16, color: Colors.grey[700]),
//                       SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           request.location ?? "الموقع غير محدد",
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),

//                   // اسم الفني أو الخدمة
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:repairo_app_new/business_logic/RequestDetailsCubit/request_details_cubit.dart';
import 'package:repairo_app_new/business_logic/UserRequestsCubit/user_requests_cubit.dart';
import 'package:repairo_app_new/business_logic/UserRequestsCubit/user_requests_states.dart';
import 'package:repairo_app_new/core/constants/app_constants.dart';
import 'package:repairo_app_new/data/models/user_requests_model.dart';
import 'package:repairo_app_new/data/repository/requset_details_repository.dart';
import 'package:repairo_app_new/data/web_services/request_details_webservices.dart';
import 'package:repairo_app_new/presentation/screens/request_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icon.dart';

class UserRequests extends StatefulWidget {
  const UserRequests({super.key});

  @override
  UserRequestsState createState() => UserRequestsState();
}

class UserRequestsState extends State<UserRequests>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<UserRequestsCubit>(context).getUserRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.arrow_forward_ios_outlined,
        //       size: 20,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
        title: const Text(
          "طلباتي",
          style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        bottom: TabBar(
          labelStyle: const TextStyle(fontFamily: "Cairo"),
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: "النشطة"),
            Tab(text: "المنتهية"),
          ],
        ),
      ),
      body: BlocBuilder<UserRequestsCubit, UserRequestsStates>(
        builder: (context, state) {
          if (state is UserRequestsLoaded) {
            final requests = state.requests;
            final activeRequests = requests
                .where((request) => request.status != 'ended')
                .toList();
            final endedRequests = requests
                .where((request) => request.status == 'ended')
                .toList();

            return TabBarView(
              controller: _tabController,
              children: [
                buildRequestList(activeRequests),
                buildRequestList(endedRequests),
              ],
            );
          } else if (state is UserRequestsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          } else {
            return const Center(
              child: Text(
                "لا توجد طلبات لعرضها",
                style: TextStyle(fontFamily: "Cairo"),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildRequestList(List<RUserRequestData> requests) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.w,
              height: 60.h,
              child: Image.asset("assets/images/png/done.png"),
            ),
            const SizedBox(height: 16),
            const Text(
              "لا توجد طلبات في هذا القسم",
              style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final filteredRequests = requests.where((request) {
      final name = request.id?.toLowerCase() ?? '';
      return name.contains(searchKeyword);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredRequests.length,
      itemBuilder: (ctx, index) => buildRequestCard(filteredRequests[index]),
    );
  }

  Widget buildRequestCard(RUserRequestData request) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RequestDetailsCubit(
                  RequsetDetailsRepository(RequestDetailsWebservices()),
                ),
              ),
            ],
            child: RequestDetailsScreen(id: request.id!),
          ),
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const LineIcon(Icons.settings, size: 16),
                    SizedBox(width: 4.w),
                    const Text(
                      "الخدمة :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      request.service?.name ?? "غير معروف",
                      style: const TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 65,
                      height: 20,
                      decoration: BoxDecoration(
                        color: request.status == 'accepted'
                            ? Colors.green
                            : request.status == "rejected"
                            ? Colors.red
                            : request.status == "ongoing"
                            ? Colors.blueGrey
                            : request.status == "ended"
                            ? Colors.deepOrangeAccent
                            : request.status == "pending"
                            ? Colors.grey
                            : Colors.amber,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          request.status == "accepted"
                              ? "مقبول"
                              : request.status == "ended"
                              ? "منهي"
                              : request.status == "rejected"
                              ? "مرفوض"
                              : request.status == "ongoing"
                              ? "جاري"
                              : request.status == "pending"
                              ? "معلّق"
                              : request.status == "canceled"
                              ? "ملغي"
                              : "${request.status}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Cairo",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const LineIcon(Icons.date_range, size: 16),
                    SizedBox(width: 4.w),
                    const Text(
                      "الموعد المحدد :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${request.scheduledDate ?? "--"} - ${request.scheduledTime ?? "--"}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const LineIcon(Icons.location_on, size: 16),
                    SizedBox(width: 4.w),
                    const Text(
                      "موقع التنفيذ :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      request.location ?? "الموقع غير محدد",
                      style: const TextStyle(fontSize: 14, fontFamily: "Cairo"),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Dash(
                    direction: Axis.horizontal,
                    length: 320.w,
                    dashLength: 2,
                    dashColor: Colors.grey,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const LineIcon(
                        Icons.person,
                        size: 16,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const Text(
                      "المهني :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      request.technicianAccount?.name ?? "غير معروف",
                      style: const TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => RequestDetailsCubit(
                                  RequsetDetailsRepository(
                                    RequestDetailsWebservices(),
                                  ),
                                ),
                              ),
                            ],
                            child: RequestDetailsScreen(id: request.id!),
                          ),
                        );
                      },
                      child: Container(
                        width: 80.w,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LineIcon(
                                Icons.settings,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "إدارة الحجز",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      //  Card(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      //   elevation: 4,
      //   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       if (request.service?.image != null &&
      //           request.service!.image!.isNotEmpty)
      //         ClipRRect(
      //           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      //           child: Image.network(
      //             request.service!.image!
      //                 .  ('127.0.0.1', AppConstants.baseaddress),
      //             width: double.infinity,
      //             height: 180,
      //             fit: BoxFit.cover,
      //             errorBuilder: (context, error, stackTrace) => Container(
      //               height: 180,
      //               width: double.infinity,
      //               color: Colors.grey[300],
      //               child: Icon(Icons.broken_image, size: 40),
      //             ),
      //           ),
      //         ),
      //       Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                 Icon(Icons.settings, size: 16, color: Colors.grey[700]),
      //                 SizedBox(width: 6),
      //                 Text(
      //                   'الخدمة: ${request.service?.name ?? "غير معروف"}',
      //                   style: TextStyle(
      //                       fontSize: 14, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 8),
      //             Row(
      //               children: [
      //                 Icon(Icons.person, size: 16, color: Colors.grey[700]),
      //                 SizedBox(width: 6),
      //                 Text(
      //                   'المهني: ${request.technicianAccount?.name ?? "غير معروف"}',
      //                   style: TextStyle(
      //                       fontSize: 14, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 8),
      //             Row(
      //               children: [
      //                 Icon(Icons.calendar_today,
      //                     size: 16, color: Colors.grey[700]),
      //                 SizedBox(width: 6),
      //                 Expanded(
      //                   child: Text(
      //                     '${request.scheduledDate ?? "--"} - ${request.scheduledTime ?? "--"}',
      //                     style: TextStyle(
      //                         fontSize: 14, fontWeight: FontWeight.w500),
      //                   ),
      //                 ),
      //                 Container(
      //                   width: 65,
      //                   height: 20,
      //                   decoration: BoxDecoration(
      //                       color: request.status == 'accepted'
      //                           ? Colors.green
      //                           : request.status == "rejected"
      //                               ? Colors.red
      //                               : request.status == "ongoing"
      //                                   ? Colors.blueGrey
      //                                   : request.status == "pending"
      //                                       ? Colors.grey
      //                                       : Colors.amber,
      //                       borderRadius:
      //                           BorderRadius.all(Radius.circular(10))),
      //                   child: Center(
      //                     child: Text(
      //                       "${request.status}",
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 12,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 8),
      //             Row(
      //               children: [
      //                 Icon(Icons.location_on,
      //                     size: 16, color: Colors.grey[700]),
      //                 SizedBox(width: 6),
      //                 Expanded(
      //                   child: Text(
      //                     request.location ?? "الموقع غير محدد",
      //                     style: TextStyle(fontSize: 14),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
