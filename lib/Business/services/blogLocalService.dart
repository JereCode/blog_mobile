
import '../models/User.dart';

abstract class BloglocalService {
  Future<bool> sauvegarderUser(User user);
}