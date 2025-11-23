class ValidationErrorTypes {
  
}

abstract class BaseInputValidator<T> {
  String? validator(T? value);

  
}

class TextFieldValidator extends BaseInputValidator<String> {
  

  @override
  String? validator(String? value) {
    // TODO: implement validator
    try {

    } catch (e) {
      throw UnimplementedError(e.toString());
    }
  }
}
