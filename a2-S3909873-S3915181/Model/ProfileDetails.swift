//
//  ProfileDetails.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 10/10/2024.
//

import Foundation
/// 'ProfileDetails' is a class that contains the observable object protocol, enabling the class to manage and store user profile details in different views. The class includes methods for saving user information with `UserDefaults`, validating emails and creating initials.
class ProfileDetails: ObservableObject {
    /// A published variable that holds the key for the user's profile name, which is stored in `UserDefaults`
    @Published var nameKey = "NAME_KEY"
    /// A published variable that holds the key for the user's profile initials, which is stored in `UserDefaults`
    @Published var initialKey = "INITIAL_KEY"
    /// A published variable that holds the key for the user's profile email, which is stored in `UserDefaults`
    @Published var emailKey = "EMAIL_KEY"
    /// A published variable that holds the key for the user's profile username, which is stored in `UserDefaults`
    @Published var userKey = "USER_KEY"

    
    /// A variable that stores and retrieves the user's profile name
    ///
    /// A Getter method used to retrieve the user's profile name from `UserDefaults`. It will return an empty string if the name is not found
    /// ```swift
    /// get { UserDefaults.standard.string(forKey: nameKey) ?? ""}
    /// ```
    ///
    /// A Setter method used to store the provided user's profile name in `UserDefaults`
    /// ```swift
    /// set { UserDefaults.standard.set(newValue, forKey: nameKey)}
    /// ```
    var profileName: String {
        get {
            UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    /// A variable that stores and retrieves the user's profile initials
    ///
    /// A Getter method used to retrieve the user's profile initials from `UserDefaults`. It will return an empty string if the initials is not found
    /// ```swift
    /// get { UserDefaults.standard.string(forKey: nameKey) ?? ""}
    /// ```
    ///
    /// A Setter method used to store the provided user's profile initials in `UserDefaults`
    /// ```swift
    /// set { UserDefaults.standard.set(newValue, forKey: nameKey)}
    /// ```
    var nameInitials: String {
        get {
            UserDefaults.standard.string(forKey: initialKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: initialKey)
        }
    }

    
    /// A variable that stores and retrieves the user's profile email
    ///
    /// A Getter method used to retrieve the user's profile email from `UserDefaults`. It will return an empty string if the email is not found
    /// ```swift
    /// get { UserDefaults.standard.string(forKey: nameKey) ?? ""}
    /// ```
    ///
    /// A Setter method used to store the provided user's profile email in `UserDefaults`
    /// ```swift
    /// set { UserDefaults.standard.set(newValue, forKey: nameKey)}
    /// ```
    var email: String {
        get {
            UserDefaults.standard.string(forKey: emailKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }

    /// A variable that stores and retrieves the user's profile username
    ///
    /// A Getter method used to retrieve the user's profile username from `UserDefaults`. It will return an empty string if the username is not found
    /// ```swift
    /// get { UserDefaults.standard.string(forKey: nameKey) ?? ""}
    /// ```
    ///
    /// A Setter method used to store the provided user's profile username in `UserDefaults`
    /// ```swift
    /// set { UserDefaults.standard.set(newValue, forKey: nameKey)}
    /// ```
    var userName: String {
        get {
            UserDefaults.standard.string(forKey: userKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userKey)
        }
    }
    
    
    /// A function to save and update the user's profile name, email, username and initials in `UserDefaults`
    ///
    /// Once the parameter for `name` has been passed through, this code calls the ``saveInitial(from:)`` function to generate an initial. If successful, initials is then saved in the ``nameInitials`` property
    /// ```swift
    /// if let initials = saveInitial(from: name) {self.nameInitials = initials}
    /// ```
    /// - Parameters:
    ///   - name: A string that represents the user's profile name. This value will be stored in `UserDefaults`
    ///   - email: A string that represents the user's profile email. This value will be stored in `UserDefaults`
    ///   - userName: A string that represents the user's profile username. This value will be stored in `UserDefaults`
    func saveProfile(name: String, email: String, userName: String) {
        self.profileName = name
        self.email = email
        self.userName = userName
        
        if let initials = saveInitial(from: name) {
            self.nameInitials = initials
        }
    }
    
    
    //(Shoustin M 2014)
    /// A `Boolean` function that passes in a string input to validate whether the string provided is a valid or invalid email
    /// - Parameter email: The email address to be validated by the function
    /// - Returns: A `Boolean` value that specifies whether the email address is valid `(True)` or invalid `(False)`
    ///
    /// Returns a Boolean Value based on the evaluation whether the input email matches the specific regex format for email
    /// ```swift
    /// return emailPredicate.evaluate(with: email)
    /// ```
    func validateEmail(email:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)

    }
    
    //(Anoop4Real 2022)
    /// This method converts the provided name into initials. This function is called from ``saveProfile(name:email:userName:)``
    /// - Parameter name: The full name of the user
    /// - Returns: A string that contains the initials of the full name, or returns `nil`  if the name cannot be found or processed
    ///
    ///Returns a string containing the initials based on the users full name. Will return `nil`  if values are invalid or empty
    /// ```swift
    /// return formatter.string(from: components)
    /// }
    /// return nil
    /// ```
    func saveInitial(from name: String) -> String? {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return nil
    }
}
