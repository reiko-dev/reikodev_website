import 'package:flutter/material.dart';
import 'package:reikodev_website/app/controller/entities/hability.dart';

class ExpertisePanelItem extends StatelessWidget {
  const ExpertisePanelItem(
      {super.key, required this.title, required this.habilities});

  final String title;
  final List<Expertise> habilities;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, bc) {
        return size.width < 770
            ? SizedBox(
                width: bc.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: bc.maxWidth * .7,
                      height: bc.maxWidth * .15,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.topLeft,
                        child: Text(
                          title.toUpperCase(),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(width: bc.maxWidth * .075),
                    Padding(
                      padding: EdgeInsets.only(top: bc.maxWidth * .02),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: habilities.length,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          habilities[i].name.toUpperCase(),
                                        ),
                                        //
                                        if (habilities[i].info != null)
                                          Text(
                                            habilities[i].info!.toUpperCase(),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: bc.maxWidth * .35,
                    height: bc.maxWidth * .075,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topLeft,
                      child: Text(
                        title.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: bc.maxWidth * .075),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: bc.maxWidth * .02),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: habilities.length,
                          itemBuilder: (c, i) {
                            return FractionallySizedBox(
                              widthFactor: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            habilities[i].name.toUpperCase(),
                                            maxLines: 2,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        if (habilities[i].info != null)
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              habilities[i].info!.toUpperCase(),
                                              textAlign: TextAlign.end,
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
