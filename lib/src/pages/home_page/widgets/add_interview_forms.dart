import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '/src/bloc/interview_bloc/interview_bloc.dart';

class AddInterviewForms extends StatefulWidget {

  final GlobalKey<FormState> addInterviewFormKey;

  AddInterviewForms({
    required this.addInterviewFormKey
  });

  @override
  _AddInterviewFormsState createState() => _AddInterviewFormsState();
}

class _AddInterviewFormsState extends State<AddInterviewForms> {

  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);
    int key = 0;

    return BlocBuilder<InterviewBloc, InterviewState>(
      buildWhen: ( _ , current ) => current is AddingNewInterview ? true : false,
      builder: ( _ , state) {
        if ( state is AddingNewInterview ) key = state.key!;
        return Container(
          height: 300.0,
          width: double.infinity,
          child: Form(
            key: this.widget.addInterviewFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
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
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '(###) ### ####', filter: { '#': RegExp(r'[0-9]') })
                      ],
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
                            readOnly: true,
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
                            if ( date != '' ) {
                              interviewBloc.add( OnUserSelectDateTime(key, date) );
                              final selectedDate = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                              dateController.text = selectedDate;
                            }
                          }
                        )
                      ],
                    ),
                    SizedBox( height: 15.0 ),
                  ],
                ),
              ),
            )
          ),
        );
      }
    );
  }

  Future<dynamic> _pickDateTime( BuildContext context ) async {
    final date = await showDatePicker(
      context: context, 
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(), 
      firstDate: DateTime( 2021 ), 
      lastDate: DateTime( 2022 )
    );
    final time = DateTime.now();
    DateTime newDate = DateTime.now();
    if ( date != null ) {
      newDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      return newDate;
    }
    return '';
  }
}