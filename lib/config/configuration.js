import 'package:firebase_core/firebase_core.dart';


function runConfiguration() {
  var firebaseConfig = {
    apiKey: "AIzaSyCX_Ls_qhQlGW4cwCD11fVluCKeiYAaARw",
    authDomain: "unitrade-website-e84fc.firebaseapp.com",
    projectId: "unitrade-website-e84fc",
    storageBucket: "unitrade-website-e84fc.appspot.com",
    messagingSenderId: "587714154392",
    appId: "1:587714154392:web:1f95c5d9b2487da581e5ed"
  };
  firebase.intialize(firebaseConfig);
  
}
runConfiguration();