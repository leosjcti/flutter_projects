

String authErrorsString(String? code) {
  switch(code) {
    case 'INVALID CREDENTIALS':
      return 'Email ou senha inválidos';
    default:
      return 'Um erro indefinido ocorreu';
  }
}