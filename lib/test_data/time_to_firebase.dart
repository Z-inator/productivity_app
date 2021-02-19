import 'package:productivity_app/services/times_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimeToFirebase {
  User user;
  TimeToFirebase({this.user});

  List<Map<String, dynamic>> timeData = [
    {
      'entryName': 'morph holistic mindshare',
      'projectName': 'Riffpedia',
      'startTime': '2020-02-24T02:16:44Z',
      'endTime': '2020-06-28T19:38:23Z',
      'elapsedTime': 456
    },
    {
      'entryName': 'matrix virtual technologies',
      'projectName': 'Shufflester',
      'startTime': '2020-03-14T23:04:47Z',
      'endTime': '2021-02-16T00:49:31Z',
      'elapsedTime': 486
    },
    {
      'entryName': 'incubate B2B supply-chains',
      'projectName': 'Oodoo',
      'startTime': '2020-07-03T22:59:32Z',
      'endTime': '2020-02-29T20:19:42Z',
      'elapsedTime': 20
    },
    {
      'entryName': 'brand viral deliverables',
      'projectName': 'Buzzdog',
      'startTime': '2020-03-21T21:50:02Z',
      'endTime': '2020-07-11T04:15:23Z',
      'elapsedTime': 130
    },
    {
      'entryName': 'architect intuitive infomediaries',
      'projectName': 'Aimbo',
      'startTime': '2020-09-21T04:38:10Z',
      'endTime': '2020-03-19T03:46:30Z',
      'elapsedTime': 309
    },
    {
      'entryName': 'recontextualize e-business platforms',
      'projectName': 'Yabox',
      'startTime': '2020-12-16T05:30:47Z',
      'endTime': '2020-11-14T05:24:15Z',
      'elapsedTime': 479
    },
    {
      'entryName': 'brand holistic schemas',
      'projectName': 'Voonte',
      'startTime': '2020-10-03T22:26:04Z',
      'endTime': '2020-08-07T03:31:28Z',
      'elapsedTime': 224
    },
    {
      'entryName': 'aggregate clicks-and-mortar communities',
      'projectName': 'Fadeo',
      'startTime': '2020-11-17T06:53:21Z',
      'endTime': '2020-08-24T11:45:06Z',
      'elapsedTime': 68
    },
    {
      'entryName': 'iterate leading-edge models',
      'projectName': 'Blogspan',
      'startTime': '2020-12-07T19:20:08Z',
      'endTime': '2020-07-05T19:45:57Z',
      'elapsedTime': 110
    },
    {
      'entryName': 'enhance synergistic bandwidth',
      'projectName': 'Rhybox',
      'startTime': '2020-12-21T09:53:29Z',
      'endTime': '2020-07-07T21:02:45Z',
      'elapsedTime': 424
    },
    {
      'entryName': 'generate scalable channels',
      'projectName': 'Kazio',
      'startTime': '2020-05-26T08:36:26Z',
      'endTime': '2021-01-18T05:58:42Z',
      'elapsedTime': 421
    },
    {
      'entryName': 'scale mission-critical systems',
      'projectName': 'Bubblebox',
      'startTime': '2020-10-14T19:34:56Z',
      'endTime': '2021-02-06T15:02:31Z',
      'elapsedTime': 334
    },
    {
      'entryName': 'empower customized vortals',
      'projectName': 'Buzzster',
      'startTime': '2020-06-11T04:48:47Z',
      'endTime': '2020-11-13T04:43:46Z',
      'elapsedTime': 441
    },
    {
      'entryName': 'implement compelling systems',
      'projectName': 'Ntags',
      'startTime': '2020-05-15T10:38:12Z',
      'endTime': '2020-03-12T12:32:36Z',
      'elapsedTime': 110
    },
    {
      'entryName': 'reinvent revolutionary bandwidth',
      'projectName': 'Skyvu',
      'startTime': '2020-11-05T05:49:08Z',
      'endTime': '2021-01-30T16:34:49Z',
      'elapsedTime': 467
    },
    {
      'entryName': 'engage turn-key channels',
      'projectName': 'Edgepulse',
      'startTime': '2020-11-17T09:47:04Z',
      'endTime': '2021-03-05T14:32:16Z',
      'elapsedTime': 267
    },
    {
      'entryName': 'engage collaborative action-items',
      'projectName': 'Mycat',
      'startTime': '2020-11-24T20:40:39Z',
      'endTime': '2021-02-06T10:43:20Z',
      'elapsedTime': 46
    },
    {
      'entryName': 'expedite B2B web-readiness',
      'projectName': 'Flipopia',
      'startTime': '2020-07-28T00:24:52Z',
      'endTime': '2020-12-23T12:31:32Z',
      'elapsedTime': 289
    },
    {
      'entryName': 'implement synergistic convergence',
      'projectName': 'Yombu',
      'startTime': '2020-10-07T17:21:28Z',
      'endTime': '2020-08-09T02:50:28Z',
      'elapsedTime': 324
    },
    {
      'entryName': 'synthesize compelling e-services',
      'projectName': 'Twitterwire',
      'startTime': '2020-09-02T01:47:56Z',
      'endTime': '2020-06-27T14:52:38Z',
      'elapsedTime': 205
    },
    {
      'entryName': 'brand cross-platform e-tailers',
      'projectName': 'Katz',
      'startTime': '2020-10-24T22:21:19Z',
      'endTime': '2020-03-25T11:51:57Z',
      'elapsedTime': 439
    },
    {
      'entryName': 'reintermediate vertical metrics',
      'projectName': 'Thoughtstorm',
      'startTime': '2020-08-20T06:47:17Z',
      'endTime': '2020-09-19T02:50:41Z',
      'elapsedTime': 59
    },
    {
      'entryName': 'scale front-end content',
      'projectName': 'Aimbo',
      'startTime': '2020-05-12T12:14:14Z',
      'endTime': '2020-10-29T04:19:25Z',
      'elapsedTime': 300
    },
    {
      'entryName': 'morph innovative metrics',
      'projectName': 'Chatterbridge',
      'startTime': '2020-09-15T00:15:17Z',
      'endTime': '2020-12-07T12:02:33Z',
      'elapsedTime': 347
    },
    {
      'entryName': 'e-enable enterprise experiences',
      'projectName': 'Wikibox',
      'startTime': '2020-09-28T14:18:41Z',
      'endTime': '2021-01-31T17:48:03Z',
      'elapsedTime': 194
    },
    {
      'entryName': 'enhance killer schemas',
      'projectName': 'Quinu',
      'startTime': '2021-02-03T05:13:42Z',
      'endTime': '2020-06-05T17:29:30Z',
      'elapsedTime': 342
    },
    {
      'entryName': 'syndicate visionary e-services',
      'projectName': 'Trudoo',
      'startTime': '2020-07-12T18:54:24Z',
      'endTime': '2020-09-10T07:27:59Z',
      'elapsedTime': 266
    },
    {
      'entryName': 'benchmark turn-key users',
      'projectName': 'Twitterwire',
      'startTime': '2021-02-04T05:43:21Z',
      'endTime': '2020-04-09T20:21:28Z',
      'elapsedTime': 253
    },
    {
      'entryName': 'integrate robust technologies',
      'projectName': 'Cogidoo',
      'startTime': '2020-04-30T18:44:10Z',
      'endTime': '2020-11-05T12:11:19Z',
      'elapsedTime': 235
    },
    {
      'entryName': 'harness world-class e-tailers',
      'projectName': 'Eabox',
      'startTime': '2020-09-10T00:15:23Z',
      'endTime': '2021-02-27T21:46:57Z',
      'elapsedTime': 201
    },
    {
      'entryName': 'engineer dot-com e-services',
      'projectName': 'Edgepulse',
      'startTime': '2020-04-28T19:43:42Z',
      'endTime': '2020-03-28T19:29:43Z',
      'elapsedTime': 376
    },
    {
      'entryName': 'iterate user-centric supply-chains',
      'projectName': 'Eire',
      'startTime': '2020-11-21T23:08:50Z',
      'endTime': '2020-12-16T02:46:08Z',
      'elapsedTime': 174
    },
    {
      'entryName': 'generate interactive web services',
      'projectName': 'Tambee',
      'startTime': '2021-01-11T18:34:18Z',
      'endTime': '2020-03-26T22:57:18Z',
      'elapsedTime': 205
    },
    {
      'entryName': 'facilitate leading-edge applications',
      'projectName': 'Flashset',
      'startTime': '2020-12-08T00:36:52Z',
      'endTime': '2020-02-19T19:43:17Z',
      'elapsedTime': 187
    },
    {
      'entryName': 'redefine intuitive eyeballs',
      'projectName': 'Pixope',
      'startTime': '2020-11-06T13:09:23Z',
      'endTime': '2020-12-17T09:20:43Z',
      'elapsedTime': 394
    },
    {
      'entryName': 'expedite turn-key markets',
      'projectName': 'Avamba',
      'startTime': '2020-08-22T02:49:25Z',
      'endTime': '2021-01-15T09:01:02Z',
      'elapsedTime': 342
    },
    {
      'entryName': 'envisioneer ubiquitous mindshare',
      'projectName': 'Bluejam',
      'startTime': '2020-05-31T16:39:16Z',
      'endTime': '2020-08-07T15:42:20Z',
      'elapsedTime': 379
    },
    {
      'entryName': 'synthesize sticky relationships',
      'projectName': 'Zooveo',
      'startTime': '2020-11-09T09:04:50Z',
      'endTime': '2021-01-01T07:48:28Z',
      'elapsedTime': 40
    },
    {
      'entryName': 'productize magnetic convergence',
      'projectName': 'Yakijo',
      'startTime': '2020-03-15T20:07:21Z',
      'endTime': '2020-03-03T22:16:47Z',
      'elapsedTime': 447
    },
    {
      'entryName': 'harness clicks-and-mortar e-business',
      'projectName': 'Linkbuzz',
      'startTime': '2020-03-08T12:10:47Z',
      'endTime': '2020-03-14T14:13:49Z',
      'elapsedTime': 167
    },
    {
      'entryName': 'transition e-business infrastructures',
      'projectName': 'Mynte',
      'startTime': '2020-10-02T12:08:44Z',
      'endTime': '2020-10-19T14:25:20Z',
      'elapsedTime': 73
    },
    {
      'entryName': 'architect web-enabled systems',
      'projectName': 'Gabvine',
      'startTime': '2020-07-05T01:48:44Z',
      'endTime': '2020-04-02T03:10:26Z',
      'elapsedTime': 429
    },
    {
      'entryName': 'engineer granular communities',
      'projectName': 'Tambee',
      'startTime': '2021-02-14T20:23:15Z',
      'endTime': '2020-09-14T23:51:00Z',
      'elapsedTime': 236
    },
    {
      'entryName': 'orchestrate interactive partnerships',
      'projectName': 'Gabvine',
      'startTime': '2020-10-05T10:50:28Z',
      'endTime': '2020-04-29T06:40:40Z',
      'elapsedTime': 53
    },
    {
      'entryName': 'architect holistic eyeballs',
      'projectName': 'Muxo',
      'startTime': '2020-07-23T22:15:21Z',
      'endTime': '2020-11-21T12:02:27Z',
      'elapsedTime': 251
    },
    {
      'entryName': 'benchmark B2C communities',
      'projectName': 'Yata',
      'startTime': '2021-01-05T22:49:41Z',
      'endTime': '2020-07-19T18:49:11Z',
      'elapsedTime': 160
    },
    {
      'entryName': 'mesh viral e-commerce',
      'projectName': 'Nlounge',
      'startTime': '2020-05-06T16:47:39Z',
      'endTime': '2021-02-03T20:09:31Z',
      'elapsedTime': 161
    },
    {
      'entryName': 'e-enable global experiences',
      'projectName': 'Thoughtstorm',
      'startTime': '2020-07-29T10:58:57Z',
      'endTime': '2020-06-17T11:33:12Z',
      'elapsedTime': 166
    },
    {
      'entryName': 'revolutionize interactive systems',
      'projectName': 'Wordpedia',
      'startTime': '2020-07-17T10:49:35Z',
      'endTime': '2020-09-04T11:14:29Z',
      'elapsedTime': 101
    },
    {
      'entryName': 'matrix real-time experiences',
      'projectName': 'Linkbridge',
      'startTime': '2021-01-03T05:17:11Z',
      'endTime': '2020-03-07T22:40:40Z',
      'elapsedTime': 134
    }
  ];

  Future<void> uploadExampleData() {
    for (Map<String, dynamic> map in timeData) {
      TimeService(user: user).addTimeEntry(
          entryName: map['entryName'],
          projectName: map['projectName'],
          startTime: DateTime.parse(map['startTime']),
          endTime: DateTime.parse(map['endTime']),
          elapsedTime: map['elapsedTime']);
    }
  }
}
