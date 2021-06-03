import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '/src/data/models/company_model.dart';
import '/src/bloc/interview_bloc/interview_bloc.dart';

class ModifyInterviewForms extends StatelessWidget {

  final companyController = TextEditingController();
  final commentController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final maskFormatter = new MaskTextInputFormatter(mask: '+## (###) ### ####', filter: { "#": RegExp(r'[0-9]') },);

  final GlobalKey<FormState> modifyInterviewFormKey;

  ModifyInterviewForms({
    required this.modifyInterviewFormKey
  });

  @override
  Widget build(BuildContext context) {

    final interviewBloc = BlocProvider.of<InterviewBloc>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    int key = 0;
    bool formsEnabled = true;
    double formFontSize = 18.0; 
    double iconsSize = 24.0;
    double iconsSplashSize = 20.0;

    final formTextStyle = TextStyle( fontSize: formFontSize );

    if ( screenSize.width > 425 ) {
      formFontSize = ( screenSize.width > 768 ) ? 25.0 : 20.0;
      iconsSize = ( screenSize.width > 768 ) ? 32.0 : 28.0;
    }

    iconsSplashSize = iconsSize - 4;

    return BlocBuilder<InterviewBloc, InterviewState>(
      buildWhen: ( _ , current ) {
        if ( current is ModifyingInterview ) return true;
        if ( current is WatchingInterview ) return true;
        return false;
      },
      builder: ( _ , state) {
        if ( state is WatchingInterview ) {
          formsEnabled = false;
          key = state.interview!.key!;
          _getInterviewDetails(state.interview!);
        } else if ( state is ModifyingInterview ) {
          key = state.interview!.key!;
          _getInterviewDetails(state.interview!);
        }
        return Container(
          height: 300.0,
          width: double.infinity,
          child: Form(
            key: this.modifyInterviewFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: companyController,
                      readOnly: !formsEnabled,
                      style: formTextStyle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Company'
                      ),
                      validator: (value) {
                        if ( value == null || value.isEmpty ) return 'Company name is necessary';
                        return null;
                      },
                      onChanged: ( value ) => interviewBloc.add( OnUserWriteCompanyName(key, value.trim()) ),
                    ),
                    SizedBox( height: 15.0 ),
                    TextFormField(
                      controller: commentController,
                      readOnly: !formsEnabled,
                      style: formTextStyle,
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
                      readOnly: !formsEnabled,
                      style: formTextStyle,
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
                            readOnly: true,
                            style: formTextStyle,
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
                          splashRadius: iconsSplashSize,
                          iconSize: iconsSize,
                          icon: Icon(Icons.date_range),
                          onPressed: formsEnabled ? () async {
                            final date = await _pickDateTime( context );
                            if ( date != '' ) {
                              interviewBloc.add( OnUserSelectDateTime(key, date) );
                              final selectedDate = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                              dateController.text = selectedDate;
                            }
                          }
                          : null
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

  void _getInterviewDetails( CompanyModel interview ) {
    if ( interview.enterprise != null ) companyController.text = interview.enterprise!;
    if ( interview.comment != null ) commentController.text = interview.comment!;
    if ( interview.number != null ) numberController.text = interview.number!;
    if ( interview.date != null ) {
      final date = interview.date;
      final selectedDate = '${date?.day}/${date?.month}/${date?.year} ${date?.hour}:${date?.minute}';
      dateController.text = selectedDate;
    }
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