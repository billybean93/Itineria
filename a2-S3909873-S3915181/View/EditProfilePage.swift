//
//  EditProfilePage.swift
//  a1-S3909873-S3915181
//
//  Created by Bill Nguyen on 25/8/2024.
//

import SwiftUI
import SwiftData

/// 'EditProfilePage' is a view that displays the user profile informaton and provides an interface for editing profile details. These details include name, username and email.
struct EditProfilePage: View {
    /// A state variable that holds the name of the profile name that is input by the user
    @State private var profileName: String = ""
    /// A state variable that holds the email of the profile email that is input by the user
    @State private var email: String = ""
    /// A state variable that holds the username of the profile username that is input by the user
    @State private var userName: String = ""
    /// A state object that manages the user details. Enables ``EditProfilePage`` to access and display the stored information
    @StateObject private var profileDetails = ProfileDetails()
    /// An optional state variable that presents an error message if email input is incorrect
    @State private var emailError: String? = nil

    var body: some View {
        ZStack{
            //Displays profile details
            VStack{
                Rectangle()
                    .fill(.green)
                    .cornerRadius(50)
                    .frame(width: .infinity ,height:600)
                    .ignoresSafeArea()
                Spacer()
            }
            Spacer()
            Rectangle()
                .fill(.white)
                .cornerRadius(50)
                .frame(width: 325, height: 650, alignment: .bottom)
            
            VStack{
                Text("Edit Profile")
                    .font(.title2)
                    .bold()
                    .padding(.top, 60)
                Circle()
                    .fill(Color.red)
                    .shadow(color: Color.red, radius: 5, x: 2, y: 2)
                
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(profileDetails.nameInitials)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    )
                    .padding(.top, 30)
                
                VStack{
                    
                    Text(profileDetails.profileName)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                    VStack{
                        Text("@" + profileDetails.userName)
                        Text(profileDetails.email)
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                }
                Divider()
                    .frame(maxWidth: 325)
                
                //Form for user input to change profile details
                ZStack {
                    VStack {
                        Form {
                            Section(header: Text("Profile Name")
                                .font(.system(size: 12))
                            ) {
                                TextField("Name", text: $profileName)
                                    .font(.system(size: 12))
                                    .padding(10)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1) // Border color and width
                                    )
                                    .shadow(radius: 1)
                                    .cornerRadius(10)
                            }
                            Section(header: Text("Username")
                                .font(.system(size: 12))
                            ) {
                                TextField("Enter Username", text: $userName)
                                    .font(.system(size: 12))
                                    .padding(10)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1) // Border color and width
                                    )
                                    .shadow(radius: 1)
                                    .cornerRadius(10)
                                
                            }
                            
                            Section(header: Text("Email")
                                .font(.system(size: 12)))
                            {
                                TextField(profileDetails.email.isEmpty ? "daniel@icloud.com": email, text: $email)
                                    .font(.system(size: 12))
                                    .padding(10)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1) // Border color and width
                                    )
                                    .shadow(radius: 1)
                                    .cornerRadius(10)
                                
                                if let error = emailError {
                                    Text(error)
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }
                            Section {
                                Button("Save Profile") {
                                    if profileDetails.validateEmail(email: email){
                                        emailError = nil
                                        profileDetails.saveProfile(name: profileName, email: email, userName: userName)
                                    }
                                    else{
                                        emailError = "Please enter a valid email address."
                                    }
                                }
                            }
                        }
                        .background(Color.white) // Background color of the form
                        .foregroundColor(.blue)
                        .scrollContentBackground(.hidden) // Hide default background of Form

                    }


                }
                .frame(maxWidth: 325, maxHeight: 600)
            }
            .edgesIgnoringSafeArea(.top) // Ignore safe area for top bar, as padding is applied            }
            .frame(maxHeight: .infinity, alignment: .top)
            .foregroundColor(.white)
        }
        //Make the stack fill all the space
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
    



/// A Preview for ``EditProfilePage``
struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePage()
    }
}
