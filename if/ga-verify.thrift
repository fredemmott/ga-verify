namespace rb GAVerify
enum Result {
  SUCCESS = 0,
  BAD_TOKEN = 1,
  BAD_USER = 2,
  NO_GOOGLE_AUTH = 3
}

service Verifier {
  Result check_user(1:string name, 2:i32 token);
}
