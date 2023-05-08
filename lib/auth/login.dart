import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/auth/create.dart';

class Login extends StatelessWidget {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController emailController =TextEditingController();
  TextEditingController paswwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(500, 150, 150, 234),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            child: Column( children: [
              Image.asset("assets/images/logo.png",width: 160,height: 160,),
              const SizedBox(height: 8,),
              const Text("Hello",style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),),
              const Text("in creative school",style: TextStyle(

                fontSize: 25,
                color: Colors.white,
              ),)
            ],

            ),
          ),
          Container(
              height: 480,
              decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),

                  )
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      const Text("Hi Student",style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      const SizedBox(height: 5,),
                      const Text("login to continue",style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: TextFormField(
                          controller: emailController,
                          validator: (text){
                            if(text!.isEmpty || text==null ){
                              return "Please Enter Your Email";
                            }
                            bool emailVaild= RegExp
                              (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
                            if(!emailVaild){
                              return "Email Not Vaild";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Email"),

                          ),

                        ),

                      ),


                      const SizedBox(height:20 ,),
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: TextFormField(
                          controller: paswwordController,
                          validator: (text){
                            if(text!.isEmpty ||text==null){
                              return "Please Enter Your Password";
                            };
                            if(text.length <8){
                              return "password should at least 8 char";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Password"),
                            suffixIcon: Icon(Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 20,),
                            child: Text("Forgot Passwors?",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(500, 150, 150, 234)
                            ),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40,),
                      Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(500, 150, 150, 234),
                        ),
                        child: MaterialButton( child: const Text("Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          onPressed:(){
                            if(formKey.currentState!.validate()){
                            login(emailController.text, paswwordController.text);
                            }

                          },),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Don't have an account?",style: TextStyle(
                              color: Colors.grey,

                              fontSize: 18,
                            ),),
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute
                                (builder: (context)=>CreateAccount()));

                            },
                            child: const Text("Create",style: TextStyle(
                              color: Color.fromARGB(500, 150, 150, 234),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),),
                          )
                        ],
                      )
                    ],

                  ),
                ),
              )


          ),

        ],

      ),
    );
  }
 Future<void> login(String email,String pass)async{
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: pass
     );
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
     }
   }
 }
}