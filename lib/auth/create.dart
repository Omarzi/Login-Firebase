import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {

  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(500, 150, 150, 234),
      body: ListView(

        children: [
          SizedBox(
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              children: [
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
              child: Form(key:formKey ,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      const Text("Create new account",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (text){
                            if(text!.isEmpty ||text==null){
                              return "Please Enter Your Name";
                            };
                          },
                          decoration: const InputDecoration(
                              label: Text("Name")
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                              label: Text("Email")
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (text){
                            if(text!.isEmpty || text==null ){
                              return "Please Enter Your Phone Number";
                            }
                          },
                          decoration: const InputDecoration(
                              label: Text("Phone Number")
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (text){
                            if(text!.isEmpty ||text==null){
                              return "Please Enter Your Password";
                            };
                            if(text.length <8){
                              return "password should at least 8 char";
                            }
                          },
                          decoration: const InputDecoration(
                              label: Text("Password")
                          ),
                        ),
                      ),

                      const SizedBox(height: 15,),
                      Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(500, 150, 150, 234)
                        ),
                        child: MaterialButton( child: const Text("Sin up",style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold
                        ),),
                          onPressed:(){
                            if(formKey.currentState!.validate()){
                             create(emailController.text, passwordController.text);
                            }
                          },),
                      ),
                    ],

                  ),
                ),
              )
          )
        ],
      ),
    );
  }
  Future<void> create (String email ,String pass) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}