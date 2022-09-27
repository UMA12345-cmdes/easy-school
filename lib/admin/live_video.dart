// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';

// class LiveVideo extends StatefulWidget {
//   static String routeName = '/live-video';
//   LiveVideo({Key? key}) : super(key: key);

//   @override
//   State<LiveVideo> createState() => _LiveVideoState();
// }

// class _LiveVideoState extends State<LiveVideo> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: "<--Add your App Id here-->",
//       channelName: "test",
//       username: "user",
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             AgoraVideoViewer(
//               client: client,
//               layoutType: Layout.floating,
//               enableHostControls: true, // Add this to enable host controls
//             ),
//             AgoraVideoButtons(
//               client: client,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
