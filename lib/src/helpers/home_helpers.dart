part of 'helpers.dart';

void showSendingDialog( BuildContext context ) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(
        '${constants.uploadingInterviewsTitle}',
        style: TextStyle( fontSize: 16.0 ),
      ),
      content: Container(
        height: 100.0,
        width: 100.0,
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

  if ( pop ) Navigator.of(context).pop();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if ( isError ) Icon(Icons.error, size: 24.0, color: Colors.red),
          if ( !isError ) Icon(Icons.check, size: 24.0, color: Colors.green),
          SizedBox( width: 10.0 ),
          Flexible(
            child: Text(
              message,
              style: TextStyle( fontSize: 16.0 ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      )
    )
  );
}