// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ChattingScreen extends StatelessWidget {
//   ChattingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage: NetworkImage(
//                 "https://i.pravatar.cc/150?img=3", // صورة وهمية للعميل
//               ),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "محمد اليوسف",
//                   style: GoogleFonts.cairo(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   "متصل الآن",
//                   style: GoogleFonts.cairo(fontSize: 12, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.call, color: Colors.white),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // قائمة الرسائل
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(12),
//               children: [
//                 _buildMessage("مرحبا أستاذ، حابب احجز موعد", false),
//                 _buildMessage("أهلا وسهلا، فيك بكرا الساعة 4؟", true),
//                 _buildMessage("تمام، شكرا كتير 🙏", false),
//                 _buildMessage("على راسي 🌹", true),
//               ],
//             ),
//           ),
//           // حقل الإدخال
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.add_circle_outline,
//                     color: Colors.teal,
//                   ),
//                   onPressed: () {},
//                 ),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "اكتب رسالتك...",
//                       hintStyle: GoogleFonts.cairo(),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Colors.teal),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessage(String text, bool isMe) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.teal : Colors.grey[300],
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(14),
//             topRight: const Radius.circular(14),
//             bottomLeft:
//                 isMe ? const Radius.circular(14) : const Radius.circular(0),
//             bottomRight:
//                 isMe ? const Radius.circular(0) : const Radius.circular(14),
//           ),
//         ),
//         child: Text(
//           text,
//           style: GoogleFonts.cairo(
//             fontSize: 14,
//             color: isMe ? Colors.white : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:repairo_app_new/business_logic/SendChatMessageCubit/send_chat_message_cubit.dart';
// import 'package:repairo_app_new/core/constants/app_constants.dart';
// import 'package:repairo_app_new/data/models/chatting_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:repairo_app_new/business_logic/ShowChatCubit/show_chat_cubit.dart';
// import 'package:repairo_app_new/business_logic/ShowChatCubit/show_chat_states.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ChattingScreen extends StatefulWidget {
//   final String requestId;
//   final String currentUser; // اسم أو id المرسل الحالي

//   const ChattingScreen({
//     Key? key,
//     required this.requestId,
//     required this.currentUser,
//   }) : super(key: key);

//   @override
//   State<ChattingScreen> createState() => _ChattingScreenState();
// }

// class _ChattingScreenState extends State<ChattingScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   RChatData? _chat;

//   @override
//   void initState() {
//     super.initState();
//     context.read<ShowChatCubit>().showChat(widget.requestId);
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0.0, // بسبب reverse:true
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: Colors.teal,
//           titleSpacing: 0,
//           title: Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: NetworkImage(
//                   _chat?.userImage?.  (
//                           "127.0.0.1", AppConstants.baseaddress) ??
//                       "https://i.pravatar.cc/150?img=3", // صورة المستخدم الآخر
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _chat?.userName ?? "المهني",
//                     style: GoogleFonts.cairo(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     "متصل الآن",
//                     style:
//                         GoogleFonts.cairo(fontSize: 12, color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocConsumer<ShowChatCubit, ShowChatStates>(
//                 listener: (context, state) {
//                   if (state is ShowChatSuccess) {
//                     setState(() {
//                       _chat = (state).chat;
//                     });
//                     _scrollToBottom();
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is ShowChatLoading && _chat == null) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final messages = _chat?.messages ?? [];

//                   if (messages.isEmpty) {
//                     return const Center(child: Text("لا توجد رسائل"));
//                   }

//                   return ListView.builder(
//                     controller: _scrollController,
//                     reverse: true,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 12),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final msg = messages[messages.length - 1 - index];
//                       final isMe = msg.sender == widget.currentUser;

//                       print(
//                           "msg.sender: ${msg.sender} - type: ${msg.sender.runtimeType}");
//                       print(
//                           "currentUser: ${widget.currentUser} - type: ${widget.currentUser.runtimeType}");

//                       return MessageBubble(message: msg, isMe: isMe);
//                     },
//                   );
//                 },
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         hintText: "اكتب رسالتك...",
//                         hintStyle: GoogleFonts.cairo(),
//                         border: InputBorder.none,
//                       ),
//                       minLines: 1,
//                       maxLines: 5,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send, color: Colors.teal),
//                     onPressed: () async {
//                       final text = _controller.text.trim();
//                       if (text.isNotEmpty) {
//                         //////////////////////////////////////////////////////////////////
//                         final prefs = await SharedPreferences.getInstance();
//                         var token = prefs.getString('auth_token');

//                         var headers = {
//                           'Accept': 'application/json',
//                           'Authorization': 'Bearer $token'
//                         };
//                         final response = await http.post(
//                             Uri.parse(
//                                 '${AppConstants.baseUrl}/user/chat/message'),
//                             body: {
//                               'chat_id': _chat!.chatId!,
//                               'message': _controller.text,
//                             },
//                             headers: headers);
//                         if (response.statusCode == 200) {
//                           final data = jsonDecode(response.body);
//                           print(data.toString());
//                           return data;
//                         } else {
//                           print("Error happened");
//                           throw Exception('sending failed');
//                         }
//                       }
//                       _controller.clear();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   final Messages message;
//   final bool isMe;

//   const MessageBubble({Key? key, required this.message, required this.isMe})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bg = isMe ? Colors.teal : Colors.grey[300];
//     final textColor = isMe ? Colors.white : Colors.black87;
//     final radius = BorderRadius.only(
//       topLeft: const Radius.circular(14),
//       topRight: const Radius.circular(14),
//       bottomLeft: isMe ? const Radius.circular(14) : const Radius.circular(0),
//       bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(14),
//     );

//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: radius,
//         ),
//         child: Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message.content ?? "",
//               style: GoogleFonts.cairo(fontSize: 14, color: textColor),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               message.createdAt ?? "",
//               style: GoogleFonts.cairo(fontSize: 10, color: Colors.black45),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:repairo_app_new/core/config/pusher_config.dart';
import 'package:repairo_app_new/core/constants/app_constants.dart';
import 'package:repairo_app_new/core/services/main_services.dart';
import 'package:repairo_app_new/data/models/chatting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairo_app_new/business_logic/ChatCubit/chat_cubit.dart';
import 'package:repairo_app_new/business_logic/ChatCubit/chat_states.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// شاشة المحادثة الرئيسية
class ChattingScreen extends StatefulWidget {
  final String user_id;
  final String requestId; // رقم الطلب أو المحادثة
  final String currentUser; // المرسل الحالي (ممكن يكون ID أو اسم)
  final String techname;
  final String techimage;
  const ChattingScreen({
    super.key,
    required this.requestId,
    required this.currentUser,
    required this.user_id,
    required this.techname,
    required this.techimage,
  });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late PusherConfig pusherConfig;
  final TextEditingController _controller =
      TextEditingController(); // للتحكم بحقل الكتابة
  final ScrollController _scrollController =
      ScrollController(); // للتحكم بالتمرير في ListView

  RChatData? _chat; // الكائن يلي بيحتوي بيانات المحادثة + الرسائل
  File? currentSelectedImage;
  initializeRoom(roomID) async {
    pusherConfig = PusherConfig();

    pusherConfig.initPusher(onEvent, roomId: roomID);
  }

  void onEvent(PusherEvent event) {
    print("event came: ${event.data}");
    try {
      print(event.eventName.toString());
      if (event.eventName == r"chat") {
        print("here");
        Messages? message;
        message = Messages.fromJson(jsonDecode(event.data)["data"]);

        _chat!.messages!.add(message);
      }

      setState(() {});
      _scrollToBottom();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    pusherConfig = PusherConfig();
    ChatCubit.get(context).showChat(widget.requestId);
  }

  @override
  void dispose() {
    pusherConfig.disconnect();
    super.dispose();
  }

  // دالة للتمرير لأسفل (آخر الرسائل)
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent, // التمرير
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // اتجاه الكتابة من اليمين لليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          titleSpacing: 0,
          title:
              //  BlocBuilder<ChatCubit, ChatStates>(
              //   builder: (context, state) {
              //     if (state is ShowChatSuccess) {
              //       return
              Row(
                children: [
                  // صورة المستخدم أو المهني
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.techimage.replaceFirst(
                            "127.0.0.1",
                            AppConstants.baseaddress,
                          ) ??
                          "https://i.pravatar.cc/150?img=3",
                    ),
                  ),
                  const SizedBox(width: 10),
                  // اسم + حالة الاتصال
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.techname ?? "المهني",
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "متصل الآن",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

          // }

          // return Row(
          //   children: [
          //     const CircleAvatar(
          //       radius: 20,
          //       backgroundImage:
          //           NetworkImage("https://i.pravatar.cc/150?img=3"),
          //     ),
          //     const SizedBox(width: 10),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "المهني",
          //           style: GoogleFonts.cairo(
          //             fontSize: 16,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.white,
          //           ),
          //         ),
          //         Text(
          //           "متصل الآن",
          //           style: GoogleFonts.cairo(
          //               fontSize: 12, color: Colors.white70),
          //         ),
          //       ],
          //     ),
          //   ],
          // );
          //   },
          // ),
        ),
        body: Column(
          children: [
            // جزء الرسائل
            Expanded(
              child: BlocConsumer<ChatCubit, ChatStates>(
                listener: (context, state) {
                  if (state is ShowChatSuccess) {
                    _chat = (state).chat;
                    // initializeRoom(_chat!.chatId!);
                    pusherConfig.initPusher(onEvent, roomId: _chat!.chatId!);
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  if (state is ShowChatLoading && _chat == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ShowChatSuccess) {}
                  final messages = _chat?.messages ?? [];

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true, // يعرض من الأسفل للأعلى
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      // نجيب الرسالة (مع عكس الترتيب)
                      final msg = messages[messages.length - 1 - index];
                      final isMe = msg.sender == widget.currentUser;
                      return MessageBubble(message: msg, isMe: isMe);
                    },
                  );
                },
              ),
            ),
            // إذا في صورة مختارة، نعرضها فوق صندوق الكتابة
            if (currentSelectedImage != null)
              Container(
                margin: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        currentSelectedImage!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => currentSelectedImage = null);
                        },
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      currentSelectedImage =
                          await MainServices.getImageUsingImagePicker(
                            ImageSource.gallery,
                          );
                      if (currentSelectedImage != null) {
                        setState(() {});
                      }
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.teal,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 2),

                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "اكتب رسالتك...",
                        hintStyle: GoogleFonts.cairo(),
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),

                  // زر الإرسال
                  // IconButton(
                  //   icon: const Icon(Icons.send, color: Colors.teal),
                  //   onPressed: () async {
                  //     final text = _controller.text.trim(); // النص المدخل
                  //     if (text.isNotEmpty && _chat != null) {
                  //       context
                  //           .read<ChatCubit>()
                  //           .sendmessage(_chat!.chatId!, _controller.text);
                  //       //initializeRoom(_chat!.chatId!);
                  //       _controller.clear(); // تفريغ الحقل
                  //     }
                  //   },
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.send, color: Colors.teal),
                  //   onPressed: () async {
                  //     if (_chat == null) return;

                  //     final text = _controller.text.trim();

                  //     if (currentSelectedImage != null) {
                  //       //   // ✨ هون ترفع الصورة على السيرفر وترجع الرابط
                  //       //  ChatCubit.get(context)
                  //       //       .sendmessage(_chat!.chatId!, null,currentSelectedImage.toString());

                  //       //   // بعدها تبعت رسالة صورة
                  //       context.read<ChatCubit>().sendmessage(
                  //           _chat!.chatId!,
                  //           null,
                  //           currentSelectedImage // مميز للرسائل يلي هي صور
                  //           );

                  //       setState(
                  //           () => currentSelectedImage = null); // مسح المعاينة
                  //     } else if (text.isNotEmpty) {
                  //       // رسالة نصية
                  //       context.read<ChatCubit>().sendmessage(
                  //           _chat!.chatId!, _controller.text, null);
                  //       _controller.clear();
                  //     }
                  //   },
                  // ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: () async {
                      if (_chat == null) return;

                      final text = _controller.text.trim();

                      if (currentSelectedImage != null) {
                        // ١. بعت رسالة صورة
                        context.read<ChatCubit>().sendmessage(
                          _chat!.chatId!,
                          null,
                          currentSelectedImage,
                        );

                        // ٢. أضف نسخة محلية للـ messages حتى تبين فوراً
                        setState(() {
                          _chat!.messages!.add(
                            Messages(
                              sender: widget.currentUser,
                              content: currentSelectedImage!
                                  .path, // مؤقتاً المسار، أو خليه "..."
                              createdAt: DateTime.now().toString(),
                            ),
                          );
                          currentSelectedImage = null;
                        });
                      } else if (text.isNotEmpty) {
                        // ١. بعت رسالة نصية
                        context.read<ChatCubit>().sendmessage(
                          _chat!.chatId!,
                          text,
                          null,
                        );

                        // ٢. أضف نسخة محلية للـ messages
                        setState(() {
                          _chat!.messages!.add(
                            Messages(
                              sender: widget.currentUser,
                              content: text,
                              createdAt: DateTime.now().toString(),
                            ),
                          );
                          _controller.clear();
                        });
                      }

                      _scrollToBottom();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Messages message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.teal : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(14),
      topRight: const Radius.circular(14),
      bottomLeft: isMe ? const Radius.circular(14) : const Radius.circular(0),
      bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(14),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: bg, borderRadius: radius),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (message.content!.startsWith("http") &&
                message.content!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  message.content!, // تصحيح الرابط
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              Text(
                message.content ?? "",
                style: GoogleFonts.cairo(fontSize: 14, color: textColor),
              ),
            const SizedBox(height: 4),
            Text(
              message.createdAt ?? "",
              style: GoogleFonts.cairo(fontSize: 10, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
