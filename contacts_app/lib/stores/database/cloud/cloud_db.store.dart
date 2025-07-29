import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';
import 'package:mobx/mobx.dart';
part 'cloud_db.store.g.dart';

class CloudDbStore = CloudDbStoreBase with _$CloudDbStore;

abstract class CloudDbStoreBase with Store {
  CloudDbStoreBase({required this.cloudDbService});
  final ICloudDbService cloudDbService;

}
