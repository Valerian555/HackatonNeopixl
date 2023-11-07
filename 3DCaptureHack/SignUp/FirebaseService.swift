//
//  FirebaseService.swift
//  3DCaptureHack
//
//  Created by Student08 on 07/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


// Fonction permettant la création du compte
func createAccount(email: String, password: String, username: String) {
    Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
        
        if let error = error {
            print("Erreur lors de la création du compte : \(error.localizedDescription)")
        } else if let authResult = authResult {
            print("Compte créé avec succès. UID de l'utilisateur : \(authResult.user.uid)")
            
            //Une fois le compte créé avec succès, enregistrez les données utilisateur dans Firestore.
             let db = Firestore.firestore()
             let user = authResult.user
             
             db.collection("users").document(user.uid).setData([
                "username": username
             ]) { error in
             if let error = error {
             print("Erreur lors de la création du document utilisateur : \(error.localizedDescription)")
             } else {
                 
                 //Navigation
                 
             print("Document utilisateur créé avec succès dans Firestore.")
             }
             }
        }
    }
}
