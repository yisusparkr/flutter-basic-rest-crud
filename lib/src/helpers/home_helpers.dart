part of 'helpers.dart';

void showSendingDialog( BuildContext context ) {

  final screenSize = MediaQuery.of(context).size;
  double alertFontSize = 18.0; 
  double containerSize = 100.0;

  if ( screenSize.width > 425 ) {
    alertFontSize = ( screenSize.width > 768 ) ? 25.0 : 20.0;
    containerSize = ( screenSize.width > 768 ) ? 200.0 : 150.0;
  }

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(
        '${constants.uploadingInterviewsTitle}',
        style: TextStyle( fontSize: alertFontSize ),
      ),
      content: Container(
        height: containerSize,
        width: containerSize,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 1.5,
          ),
        ),
      ),
    ),
  );
}

void showSendSnackBar( BuildContext context, String message, bool pop, bool isError ) {

  final screenSize = MediaQuery.of(context).size;
  double errorFontSize = 16.0; 
  double iconsSize = 24.0;

  if ( screenSize.width > 425 ) {
    errorFontSize = ( screenSize.width > 768 ) ? 18.0 : 24.0;
    iconsSize = ( screenSize.width > 768 ) ? 32.0 : 28.0;
  }

  if ( pop ) Navigator.of(context).pop();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if ( isError ) Icon(Icons.error, size: iconsSize, color: Colors.red),
          if ( !isError ) Icon(Icons.check, size: iconsSize, color: Colors.green),
          SizedBox( width: 10.0 ),
          Flexible(
            child: Text(
              message,
              style: TextStyle( fontSize: errorFontSize ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      )
    )
  );
}