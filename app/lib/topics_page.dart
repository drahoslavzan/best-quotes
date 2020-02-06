import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'database/topic_repository.dart';
import 'database/model/topic.dart';

class TopicsPage extends StatelessWidget {
  final String title;

  TopicsPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: TopicList()
      )
    );
  }
}

class TopicList extends StatefulWidget {
  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 0.8 * _scrollController.position.maxScrollExtent) {
        _fetch();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _topics.isEmpty
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        controller: _scrollController,
        itemCount: _topics.length + (_hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _topics.length) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: CupertinoActivityIndicator()
            );
          }

          return Card(
            child: ListTile(title: Text(_topics[index].name), onTap: () {
            })
          );
        }
      );
  }

  void _init() {
    if (_topicRepository != null) return;
    _topicRepository = Provider.of<TopicRepository>(context);
    _fetch();
  }

  void _fetch() async {
    if (_topicRepository == null || _fetching || !_hasMoreData) return;

    setState(() {
      _fetching = true;
    });

    final topics = await _topicRepository.fetch(count: _count, skip: _skip);
    _skip += _count;

    setState(() {
      _hasMoreData = topics.isNotEmpty;
      _fetching = false;
      _topics.addAll(topics);
    });
  }

  TopicRepository _topicRepository;
  var _skip = 0;
  var _fetching = false;
  var _hasMoreData = true;
  final _topics = List<Topic>();
  final _scrollController = ScrollController();
  final _count = 10;
}
