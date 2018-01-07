import 'package:angel_framework/angel_framework.dart';
import 'package:angel_file_service/angel_file_service.dart';
import 'package:file/local.dart';
import 'package:logging/logging.dart';

main() async {
  var app = new Angel();
  var dbFile = const LocalFileSystem().file('todos_db.json');
  app.use('/api/todos', new JsonFileService(dbFile));

  app.logger = new Logger('angel')..onRecord.listen(print);

  var server = await app.startServer('127.0.0.1', 3000);
  print('Listening at http://${server.address.address}:${server.port}');
}