part of 'widgets.dart';

class SpinkitLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: SpinKitWanderingCubes(
        color: iconColor,
        size: 50,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
