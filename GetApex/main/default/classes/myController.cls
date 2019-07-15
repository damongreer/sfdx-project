public class myController {
     public string myString;
     public string getMyString(){
          return 'getMyString';
     }

     public String getStringMethod1() {

          return myString;

     }

     public String getStringMethod2() {

          if ( myString == NULL ) {

               myString = 'Method 2';

          }

          return myString;

     }

}