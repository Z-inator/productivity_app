import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/screens/base_framework.dart';
import 'package:productivity_app/models/data.dart';

void main() => runApp(ProductivityApp());

class ProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
          child: BaseFramework()
        ),
    );
  }
}


/// Flutter code sample for NestedScrollView

// This simple example shows a [NestedScrollView] whose header contains a
// floating [SliverAppBar]. By using the [floatHeaderSlivers] property, the
// floating behavior is coordinated between the outer and inner [Scrollable]s,
// so it behaves as it would in a single scrollable.

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// /// This is the main application widget.
// class MyApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: MyStatelessWidget(),
//     );
//   }
// }

// /// This is the stateless widget that the main application instantiates.
// class MyStatelessWidget extends StatelessWidget {
//   MyStatelessWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: NestedScrollView(
//             // Setting floatHeaderSlivers to true is required in order to float
//             // the outer slivers over the inner scrollable.
//             floatHeaderSlivers: true,
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   title: const Text('Floating Nested SliverAppBar'),
//                   floating: true,
//                   expandedHeight: 200.0,
//                   forceElevated: innerBoxIsScrolled,
//                 ),
//               ];
//             },
//             body: ListView.builder(
//                 padding: const EdgeInsets.all(8),
//                 itemCount: 30,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     height: 50,
//                     child: Center(child: Text('Item $index')),
//                   );
//                 })));
//   }
// }



/// Flutter code sample for NestedScrollView

// This simple example shows a [NestedScrollView] whose header contains a
// snapping, floating [SliverAppBar]. _Without_ setting any additional flags,
// e.g [NestedScrollView.floatHeaderSlivers], the [SliverAppBar] will animate
// in and out without floating. The [SliverOverlapAbsorber] and
// [SliverOverlapInjector] maintain the proper alignment between the two
// separate scroll views.

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// /// This is the main application widget.
// class MyApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: MyStatelessWidget(),
//     );
//   }
// }

// /// This is the stateless widget that the main application instantiates.
// class MyStatelessWidget extends StatelessWidget {
//   MyStatelessWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: NestedScrollView(headerSliverBuilder:
//             (BuildContext context, bool innerBoxIsScrolled) {
//       return <Widget>[
//         SliverOverlapAbsorber(
//           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//           sliver: SliverAppBar(
//             title: const Text('Snapping Nested SliverAppBar'),
//             floating: true,
//             snap: true,
//             expandedHeight: 200.0,
//             forceElevated: innerBoxIsScrolled,
//           ),
//         )
//       ];
//     }, body: Builder(builder: (BuildContext context) {
//       return CustomScrollView(
//         // The "controller" and "primary" members should be left
//         // unset, so that the NestedScrollView can control this
//         // inner scroll view.
//         // If the "controller" property is set, then this scroll
//         // view will not be associated with the NestedScrollView.
//         slivers: <Widget>[
//           SliverOverlapInjector(
//               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
//           SliverFixedExtentList(
//             itemExtent: 48.0,
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) =>
//                   ListTile(title: Text('Item $index')),
//               childCount: 30,
//             ),
//           ),
//         ],
//       );
//     })));
//   }
// }