import 'package:basic_rest_crud/src/data/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
    int key = 0;
    bool formsEnabled = true;

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
              child: Column(
                children: [
                  TextFormField(
                    controller: companyController,
                    enabled: formsEnabled,
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
                    enabled: formsEnabled,
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
                    enabled: formsEnabled,
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