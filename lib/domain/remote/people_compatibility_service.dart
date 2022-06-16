import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';

abstract class PeopleCompatibilityRepository {
  Future<CompatibilityResponse> getCompatibility(PersonDetails male, PersonDetails female);
}
