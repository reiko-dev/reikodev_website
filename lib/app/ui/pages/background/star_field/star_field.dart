import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:reikodev_website/app/ui/pages/background/star_field/star_field_painter.dart';

class StarField extends StatefulWidget {
  final double starSpeed;
  final int starCount;

  const StarField({Key? key, this.starSpeed = 3, this.starCount = 150})
      : super(key: key);

  @override
  _StarFieldState createState() => _StarFieldState();
}

class _StarFieldState extends AnimatedState<StarField> {
  List<Star>? _stars;
  final double _maxZ = 500;
  final double _minZ = 1;
  ui.Image? _glowImage;

  @override
  void initState() {
    super.initState();
    initController(duration: const Duration(milliseconds: 1000));
    controller.repeat();
    _initStars();
  }

  void _initStars() async {
    if (_stars != null) return;
    //Start async image load

    //Create stars, randomize their starting values
    _stars = [];
    for (var i = widget.starCount; i-- > 0;) {
      var s = _randomizeStar(Star(), true);
      _stars?.add(s);
    }
    controller.addListener(() => advanceStars(widget.starSpeed));

    if (mounted) {
      await _loadGlowImage();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _glowImage == null
          ? const SizedBox.shrink()
          : CustomPaint(
              painter: StarFieldPainter(
                _stars!,
                Theme.of(context).colorScheme.background,
                glowImage: _glowImage!,
                controller: controller,
              ),
            ),
    );
  }

  void advanceStars(double distance) {
    _stars?.forEach((s) {
      //Move stars on the z, and reset them when they reach the viewport
      s.z -= distance; // * elapsed.inMilliseconds;
      if (s.z < _minZ) {
        _randomizeStar(s, false);
      } else if (s.z > _maxZ) {
        s.z = _minZ;
      }
    });
  }

  Star _randomizeStar(Star star, bool randomZ) {
    Random rand = Random();
    star.x = (-1 + rand.nextDouble() * 2) * 75;
    star.y = (-1 + rand.nextDouble() * 2) * 75;
    star.z = randomZ ? rand.nextDouble() * _maxZ : _maxZ;
    star.rotation = rand.nextDouble() * pi * 2;

    //Some fraction of stars are yellow, and bigger than the rest
    if (rand.nextDouble() < .1) {
      star.color = const Color(0xFFE89E4A);
      star.size = 2 + rand.nextDouble() * 2;
    } else {
      star.size = .5 + rand.nextDouble() * 2;
    }
    //Makes the star a little bit smaller.
    star.size *= 1.15;
    return star;
  }

  Future<void> _loadGlowImage() async {
    final c = Completer();
    final ByteData data = await rootBundle.load('assets/glow.png');
    ui.decodeImageFromList(Uint8List.view(data.buffer), (img) {
      _glowImage = img;
      c.complete();
    });

    return c.future;
  }
}
