import 'package:equatable/equatable.dart';

class SliderObject extends Equatable {
  final String title;
  final String subtitle;
  final String image;

  const SliderObject(this.title, this.subtitle, this.image);

  @override
  List<Object> get props => [title, subtitle, image];
}

class SliderViewObject extends Equatable {
  final SliderObject sliderObject;
  final int currentIndex;
  final int numOfSlides;

  const SliderViewObject(
      {required this.sliderObject,
      required this.currentIndex,
      required this.numOfSlides});

  @override
  List<Object> get props => [sliderObject, currentIndex, numOfSlides];
}
