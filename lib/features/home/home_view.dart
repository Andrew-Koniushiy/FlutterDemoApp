import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/data/model/choice_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/trans/translations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/features/home/home_view_model.dart';
import 'package:flutter_app/redux/action_report.dart';
import 'package:flutter_app/utils/progress_dialog.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => HomeViewContent(
            viewModel: viewModel,
          ),
    );
  }
}

class HomeViewContent extends StatefulWidget {
  final HomeViewModel viewModel;

  HomeViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _HomeViewContentState createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TrackingScrollController _scrollController = TrackingScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _status;
  var _processBar;

  @override
  void initState() {
    super.initState();
    if (this.widget.viewModel.photos.length == 0) {
      _status = ActionStatus.running;
      this.widget.viewModel.getPhotos(true, getPhotosCallback);
    }
  }

  void getPhotosCallback(ActionReport report) {
    setState(() {
      _status = report.status;
    });
  }

  void showError(String error) {
    final snackBar = SnackBar(content: Text(error));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    widget = NotificationListener(
        onNotification: _onNotification,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: this.widget.viewModel.photos.length + 1,
            itemBuilder: (_, int index) => _createItem(context, index),
          ),
        ));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("HomeView"),
		actions: _buildActionButton(),
      ),
	  drawer: _buildDrawer(),
      body: widget,
    );
  }
  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.extentAfter < 15.0) {
        // load more
        if (this._status != ActionStatus.running) {
          // have next page
          _loadMoreData();
          setState(() {});
        }
      }
    }

    return true;
  }

  Future<Null> _loadMoreData() {
    _status = ActionStatus.running;
    widget.viewModel.getPhotos(false, getPhotosCallback);
    return null;
  }

  Future<Null> _handleRefresh() async {
    _refreshIndicatorKey.currentState.show();
    _status = ActionStatus.running;
    widget.viewModel.getPhotos(true, getPhotosCallback);
    return null;
  }

  _createItem(BuildContext context, int index) {
    if (index < this.widget.viewModel.photos?.length) {
      return Container(
              child: _PhotoListItem(
                photo: this.widget.viewModel.photos[index],
                onTap: () {
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(
                  //    builder: (context) =>
                  //        ViewPhoto(photo: this.widget.viewModel.photos[index]),
                  //  ),
                  //);
                },
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))));
    }

    return Container(
      height: 44.0,
      child: Center(
        child: _getLoadMoreWidget(),
      ),
    );
  }

  Widget _getLoadMoreWidget() {
    if (this._status == ActionStatus.running) {
      return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator());
    } else {
      return SizedBox();
    }
  }

  Drawer _buildDrawer() {
    var fontFamily = "Roboto";
    var accountEmail = Text(
        "haystack1206@gmail.com",
        style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontFamily: fontFamily
        )
    );
    var accountName = Text(
        "HAY",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: fontFamily
        )
    );
    var accountPicture = CircleAvatar(
        child: Image.asset("assets/icons/ic_launcher.png"),
        backgroundColor: Theme.of(context).accentColor
    );

    var header = UserAccountsDrawerHeader(
      accountEmail: accountEmail,
      accountName: accountName,
      onDetailsPressed: _onTap,
      currentAccountPicture: accountPicture,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor
      ),
    );

    var tileItem1 = ListTile(
        leading: Icon(Icons.add_a_photo),
        title: Text("Add Photo"),
        subtitle: Text("Add a photo to your album"),
        onTap: _onTap
    );
    var tileItem2 = ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Exit"),
        onTap: _onTap
    );

    var listView = ListView(children: [header, tileItem1, tileItem2]);

    var drawer = Drawer(child: listView);

    return drawer;
  }

  void _onTap() {
    // Update the state of the app
    // ...
    // Then close the drawer
    Navigator.pop(context);
  }

  List<Widget> _buildActionButton() {
    return <Widget>[
      IconButton(
        icon: Icon(choices[0].icon),
        onPressed: () async {
          final Photo selected = await showSearch<Photo>(
            context: context,
            delegate: _PhotoSearchDelegate(this.widget.viewModel.searchPhoto),
          );
          if (selected != null) {
            setState(() {
              showError("you select $selected");
            });
          }
        },
      ),
    ];
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {});
  }

  void hideProcessBar() {
    if (_processBar != null && _processBar.isShowing()) {
      _processBar.hide();
      _processBar = null;
    }
  }

  void showProcessBar(String msg) {
    if (_processBar == null) {
      _processBar = new ProgressDialog(context);
    }
    _processBar.setMessage(msg);
    _processBar.show();
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Search', icon: Icons.search),
];

class _PhotoListItem extends ListTile {
  _PhotoListItem({Photo photo, GestureTapCallback onTap})
      : super(
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            leading: CircleAvatar(child: Text("T")),
            onTap: onTap);
}

class _PhotoSearchDelegate extends SearchDelegate<Photo> {
  List<String> _history = [];
  final Function(String) searchPhoto;

  _PhotoSearchDelegate(this.searchPhoto) {
    SharedPreferences.getInstance().then((prefs) {
      _history = prefs.getStringList("PhotosSearchHistory");
    });
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _history?.where((String sug) => sug.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions?.map((String sug) => '$sug')?.toList() ?? [],
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    } else {
      if (_history == null) {
        _history = [];
        _history.add(query);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setStringList("PhotosSearchHistory", _history);
        });
      } else if (!_history.contains(query)) {
        _history.add(query);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setStringList("PhotosSearchHistory", _history);
        });
      }

      searchPhoto(query);
    }

    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, viewModel) => ListView(
            children: viewModel.searchPhotos.map((photo) {
              return _ResultCard(
                item: photo,
                searchDelegate: this,
              );
            }).toList(),
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.item, this.searchDelegate});

  final Photo item;
  final SearchDelegate<Photo> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, item);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                '${item.id}',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
