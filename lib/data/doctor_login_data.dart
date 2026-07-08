class DoctorAccount {

  final String name;
  final String email;
  final String password;


  DoctorAccount({

    required this.name,
    required this.email,
    required this.password,

  });

}



// temporary doctor accounts

List<DoctorAccount> doctorAccounts = [

  DoctorAccount(

    name: "Dr. Amit Sharma",

    email: "amit@gmail.com",

    password: "1234",

  ),


  DoctorAccount(

    name: "Dr. Neha Gupta",

    email: "neha@gmail.com",

    password: "1234",

  ),

];




// currently logged doctor

DoctorAccount? currentDoctor;