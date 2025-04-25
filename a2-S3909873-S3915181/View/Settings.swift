//
//  Settings.swift
//  a1-S3909873-S3915181
//
//  Created by Bill Nguyen on 25/8/2024.
//

import SwiftUI

/// 'SettingsView' displays the user settings
struct SettingsView: View {
    /// A state object that manages the user details. Enables ``SettingsView`` to access and display the stored information
    @StateObject private var profileDetails = ProfileDetails()
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .fill(.green)
                    .cornerRadius(50)
                    .frame(width: .infinity ,height:600, alignment: .top)
                    .ignoresSafeArea()
                Spacer()
            }
            Spacer()
            Rectangle()
                .fill(.white)
                .cornerRadius(50)
                .frame(width: 325, height: 650, alignment: .bottom)
            
            VStack{
                Text("Settings")
                    .font(.title2)
                    .bold()
                    .padding(.top, 60)
                Circle()
                    .fill(Color.orange)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(profileDetails.nameInitials)
                            .font(.title)
                            .foregroundColor(.white)
                    )
                    .padding(.top, 30)
                
                Text(profileDetails.profileName)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.black)
                
                Text("@" + profileDetails.userName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                Divider()
                    .frame(maxWidth: 325)
                VStack{
                    List{
                        HStack {
                            Text("Privacy & Security")
                                .foregroundColor(.blue)
                            Spacer()
                        }

                
                        HStack {
                            Text("Change Password")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                    HStack {
                        Text("Notification")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    }
                    .listStyle(PlainListStyle())
                    .padding(.top, 20)
                    Spacer()
                    Text("About Us")
                        .foregroundColor(.blue)
                        
                }
                .frame(maxWidth: 325, maxHeight: 300)
            }
            .edgesIgnoringSafeArea(.top) // Ignore safe area for top bar, as padding is applied
            .frame(maxHeight: .infinity, alignment: .top)
            .foregroundColor(.white)
        }
        //Make the stack fill all the space
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
    }


/// A Preview for ``SettingsView``
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
