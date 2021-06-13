import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:photo_view/photo_view.dart';

class FullscreenImage extends StatelessWidget {
  final String tag;
  final String url;
  const FullscreenImage({Key key, @required this.tag, @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const String herotag = widget.tag;
    final bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("image"),
        // ),
        // backgroundColor: Colors.white,
        //     body: Stack(
        //   alignment: AlignmentDirectional.topEnd,
        //   children: [
        //     Hero(
        //       tag: widget.tag,
        //       // child: Center(
        //       //   child: CachedNetworkImage(
        //       //     imageUrl: widget.url,
        //       //   ),
        //       //   // child: Text(widget.tag),
        //       // ),
        //       child: PhotoView(
        //         imageProvider: CachedNetworkImageProvider(
        //           widget.url,
        //         ),
        //       ),
        //     ),
        // RawMaterialButton(
        //   constraints: BoxConstraints(minWidth: 30.0, minHeight: 30.0),
        //   elevation: 2.0,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: new Icon(
        //     Icons.close,
        //     color: Colors.white,
        //     size: 20,
        //   ),
        //   // shape: CircleBorder(),
        //   // fillColor: Colors.white,
        //   // padding: const EdgeInsets.all(10.0),
        // ),
        //   ],
        // )
        body: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        PhotoView(
          imageProvider: CachedNetworkImageProvider(
            url,
          ),
          heroAttributes: PhotoViewHeroAttributes(
            tag: tag,
            transitionOnUserGestures: true,
          ),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minWidth: 30.0, minHeight: 30.0),
          elevation: 2.0,
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    ));
    //   onTap: () => Navigator.pop(context),
    // );
  }
}

// class FullscreenImage extends StatefulWidget {
//   final String tag;
//   final String url;

//   const FullscreenImage({Key key, @required this.tag, @required this.url})
//       : super(key: key);

//   @override
//   _FullscreenImageState createState() => _FullscreenImageState();
// }

// class _FullscreenImageState extends State<FullscreenImage> {
//   @override
//   initState() {
//     // SystemChrome.setEnabledSystemUIOverlays([]);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     //SystemChrome.restoreSystemUIOverlays();
//     // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const String herotag = widget.tag;
//     final bool isDesktop = Responsive.isDesktop(context);
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text("image"),
//         // ),
//         // backgroundColor: Colors.white,
//         body: Stack(
//       alignment: AlignmentDirectional.topEnd,
//       children: [
//         Hero(
//           tag: widget.tag,
//           // child: Center(
//           //   child: CachedNetworkImage(
//           //     imageUrl: widget.url,
//           //   ),
//           //   // child: Text(widget.tag),
//           // ),
//           child: PhotoView(
//             imageProvider: CachedNetworkImageProvider(
//               widget.url,
//             ),
//           ),
//         ),
//         RawMaterialButton(
//           constraints: BoxConstraints(minWidth: 30.0, minHeight: 30.0),
//           elevation: 2.0,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: new Icon(
//             Icons.close,
//             color: Colors.white,
//             size: 20,
//           ),
//           // shape: CircleBorder(),
//           // fillColor: Colors.white,
//           // padding: const EdgeInsets.all(10.0),
//         ),
//       ],
//     )
//         // body: PhotoView(
//         //   imageProvider: CachedNetworkImageProvider(
//         //     widget.url,
//         //   ),
//         //   heroAttributes: const PhotoViewHeroAttributes(
//         //     tag: "abc",
//         //     transitionOnUserGestures: true,
//         //   ),
//         // ),
//         );
//     //   onTap: () => Navigator.pop(context),
//     // );
//   }
// }
