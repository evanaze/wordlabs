
          body: SafeArea(
              child: FutureBuilder<String>(
                  future: _content,
                  builder: (context, snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Html(
                          data: snapshot.data,
                          style: {
                            'h1': Style(color: Colors.red),
                            'p': Style(
                                color: Colors.black87,
                                fontSize: FontSize.medium),
                            'ul': Style(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20))
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        )
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children,
                      ),
                    );
                  })),