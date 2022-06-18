import 'package:intl/intl.dart';

const weather_api_key='e7e6bbb42b41e6995fd516a684044c88';

String getFormattedDate(int date, String format)=>
    DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(date*1000));