import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '/src/bloc/interview_bloc/interview_bloc.dart';

class AddInterviewForms extends StatelessWidget {

  final companyController = TextEditingController();
  final commentController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final maskFormatter = new MaskTextInputFormatter(mask: '+## (###) ### ####', filter: { "#": RegExp(r'[0-9]') },);

  final GlobalKey<FormState> interviewFormKey;

  AddInterviewForms({
    required this.interviewFormKey
  });

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);
    int key = 0;

    return BlocBuilder<InterviewBloc, InterviewState>(
      buildWhen: ( _ , __ ) => false,
      builder: ( _ , state) {
        if ( state is AddingNewInterview ) key = state.key!;
        return Container(
          height: 300.0,
          width: double.infinity,
          child: Form(
            key: this.interviewFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: companyController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Company'
                    ),
                    validator: (value) {
                      if ( value == null || value.isEmpty ) return 'Copmany name is necessary';
                      return null;
                    },
                    onChanged: ( value ) => interviewBloc.add( OnUserWriteCompanyName(key, value.trim()) ),
                  ),
                  SizedBox( height: 15.0 ),
                  TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Comment'
                    ),
                    validator: (value) {
                      if ( value == null || value.isEmpty ) return 'This field is necessary';
                      return null;
                    },
                    onChanged: ( value ) => interviewBloc.add( OnUserWriteComment(key, value.trim()) ),
                  ),
                  SizedBox( height: 15.0 ),
                  TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatter],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number'
                    ),
                    validator: (value) {
                      if ( value == null || value.isEmpty ) return 'Copmany number is necessary';
                      return null;
                    },
                    onChanged: ( value ) => interviewBloc.add( OnUserWriteNumber(key, value.trim()) ),
                  ),
                  SizedBox( height: 15.0 ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: dateController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date',
                          ),
                          validator: (value) {
                            if ( value == null || value.isEmpty ) return 'The date is necessary';
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        splashRadius: 20.0,
                        icon: Icon(Icons.date_range),
                        onPressed: () async {
                          final date = await _pickDateTime( context );
                          dateController.text = date;
                          print(dateController.text);
                        }
                      )
                    ],
                  ),
                  SizedBox( height: 15.0 ),
                ],
              ),
            )
          ),
        );
      }
    );
  }

  Future<String> _pickDateTime( BuildContext context ) async {
    final date = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime( 2021 ), 
      lastDate: DateTime( 2022 )
    );
    final time = DateTime.now();
    DateTime newDate = DateTime(2021);
    if ( date != null ) {
      newDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      final selectedDate = '${newDate.day}/${newDate.month}/${newDate.year} ${newDate.hour}:${newDate.minute}';
      return selectedDate;
    }
    return '';
  }

}