import 'package:tria/models/log.dart';

abstract class LogInterface {
  openDb(dbName);

  init();
  addLogs(Log log);
  Future<List<Log>> getLogs();
  deleteLogs(int logId);
  close();
}
