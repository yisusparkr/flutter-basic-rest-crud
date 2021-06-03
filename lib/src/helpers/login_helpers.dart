part of 'helpers.dart';

void navigate( BuildContext context, Widget page ) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page));
}

void showLoadingDialog( BuildContext context, String title ) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle( fontSize: 18.0 ),
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

void showErrorSnackBar( BuildContext context, String message ) {

  Navigator.of(context).pop();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, size: 24.0, color: Colors.red),
          SizedBox( width: 10.0 ),
          Flexible(
            child: Text(
              message,
              style: TextStyle( fontSize: 15.0 ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      )
    )
  );
}