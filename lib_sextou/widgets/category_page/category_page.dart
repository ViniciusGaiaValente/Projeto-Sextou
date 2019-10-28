import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sextou/models/event.dart';
import 'package:sextou/models/firebase_connection.dart';
import 'package:sextou/models/globals.dart';
import 'package:sextou/models/navigation_bloc.dart';

class CategoryPage extends StatefulWidget {

  Category category;
  VoidCallback getBack;

  CategoryPage({@required this.category, @required this.getBack});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  FirebaseConnection _firebaseConnection;

  @override
  void initState() {
    _firebaseConnection = FirebaseConnection();
    super.initState();
  }

  @override
  void dispose() {
    _firebaseConnection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.getBack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _getHeader(
              context: context,
              category: widget.category,
            ),
            StreamBuilder(
              stream: _firebaseConnection.stream,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text("Erro ao Carregar os Eventos"),
                    ),
                  );
                }

                if (snapshot.data.isEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text("Nenhum Evento Cadastrado No Momento"),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: _getContent(
                    context: context,
                    events: snapshot.data,
                    category: widget.category,
                    getBack: () => NavigationBloc.shared.goToCategory(
                      category: widget.category,
                      getBack: widget.getBack,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}

_getHeader({@required BuildContext context, @required Category category}) {

  Image icon;
  ImageProvider bg;
  String text;

  switch (category) {
    case Category.mix:
      icon = Image.asset("assets/icone-mix.png");
      bg = AssetImage("assets/fundo-mix.png");
      text = "Essa aqui é pra quem prefere dançar ao som de estilos como sertanejo, brega, pagode, eletrônica, funk e muito mais! Aqui os roles são bem amplos e ideais pra quem gosta de ouvir (quase) de tudo. Gosta de algo mais eclético? Confira esse eventos";
      break;
    case Category.alternative:
      icon = Image.asset("assets/icone-alternativa.png");
      bg = AssetImage("assets/fundo-alternativa.png");
      text = "De música eletrônica a rock instrumental, essa categoria é pra galera que curte um ambiente mais diferenciado e adora sair de casa no estilo! Roles com direito a muita diversidade é um público de todos os tipos. Tá preparado(a)? Dá uma olhada!";
      break;
    case Category.lgbt:
      icon = Image.asset("assets/icone-lgbt.png");
      bg = AssetImage("assets/fundo-lgbt.png");
      text = "Curte um ambiente com música variada e muito close? As festas LGBT são pra você! Não importa a sua preferência sexual, você vai se sentir super à vontade nesses roles! Não prometemos nada, mas praticamente não tem como não se divertir nas festas dessa categoria! E então, preparadx para ir até o chão? A catuaba pode ajudar!";
      break;
    case Category.festival:
      icon = Image.asset("assets/icone-festival.png", fit: BoxFit.fitHeight,);
      bg = AssetImage("assets/fundo-festival.png");
      text = "Aqueles rolês que acontecem de vez em quando e você não pode perder! Periodicamente na cidade das mangueiras, aqui você vai encontrar shows, eventos, festivais... não deixe de conferir! ";
      break;
  }

  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: bg,
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50, bottom: 10),
          height: 100,
          child: icon,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: text,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
        ),
      ],
    ),
  );
}

_getContent({@required BuildContext context, @required List<Event> events, @required Category category, @required VoidCallback getBack}) {
  List<Widget> children = [];
  List<Event> filteredEvents = [];
  Function filter;

  switch (category) {
    case Category.mix:
      filter = (Event event) {
        return event.mix;
      };
      break;
    case Category.alternative:
      filter = (Event event) {
        return event.alternative;
      };
      break;
    case Category.festival:
      filter = (Event event) {
        return event.festival;
      };
      break;
    case Category.lgbt:
      filter = (Event event) {
        return event.lgbt;
      };
      break;
  }

  events.forEach((event) {
    if (filter(event)) {
      filteredEvents.add(event);
    }
  });

  filteredEvents.forEach((event) {

    var date  = event.date.toDate();

    if (date.isAtSameMomentAs(today) || date.isAfter(today)) {
      children.add(
        Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              )
          ),
          child: GestureDetector(
            onTap: () => NavigationBloc.shared.goToDetails(
              event: event,
              getBack: getBack,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: event.photoPath,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 100,
                    height: 100,
                  ),
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: event.name,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: event.description,
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: event.local.split(",")[0],
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: getFormattedDate(date: event.date.toDate()),
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  });

  if (children.isEmpty) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Center(
        child: Text("Nenhum Evento Nesta Categoria no Momento"),
      ),
    );
  } else {
    return Column(
      children: children,
    );
  }
}

