part of 'helpers.dart';

void navigate( BuildContext context, Widget page ) {
  Navigator.of(context).pop();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

void showLoadingDialog( BuildContext context, String title ) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(title),
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
          Icon(Icons.error, color: Colors.red),
          SizedBox( width: 10.0 ),
          Text(message)
        ],
      )
    )
  );
}