import 'package:flutter/material.dart';
import 'package:reikodev_website/internationalization.dart';
import 'package:reikodev_website/logic/scroll_data_controller.dart';

class GoodbyeSection extends StatelessWidget {
  const GoodbyeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(child: SizedBox.shrink()),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: lookingForValuablePerson + " ",
                    style: Theme.of(context).textTheme.headline3!,
                    children: [
                      TextSpan(
                        text: reikoEmail,
                        mouseCursor: SystemMouseCursors.click,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hoverColor,
                            ),
                      ),
                    ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ScrollToTopWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollToTopWidget extends StatelessWidget {
  const ScrollToTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 50,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        overlayColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.hovered)) {
            return Theme.of(context).hoverColor.withOpacity(.3);
          }
          return Colors.transparent;
        }),
        onTap: () {
          ScrollDataController.i.scrollController.value.animateTo(
            ScrollDataController
                .i.scrollController.value.position.minScrollExtent,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInSine,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              top.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_upward_outlined,
              color: Theme.of(context).textTheme.headline3!.color,
            ),
          ],
        ),
      ),
    );
  }
}
