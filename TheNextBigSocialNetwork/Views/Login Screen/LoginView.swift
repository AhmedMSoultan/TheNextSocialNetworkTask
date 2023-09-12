//
//  LoginView.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 14/03/2023.
//

import SwiftUI

struct LoginView: View {
    let screenWidth = UIScreen.main.bounds.width
    @StateObject var LoginVM = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Image("login-Banner")
                .resizable()
                .scaledToFit()
            
            Text("Welcome")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(Color.accentColor)
            
            VStack {
                CustomTextField(inputText: $LoginVM.username,
                                titleText: "User Name",
                                promptText: "Enter your user name")
                
                CustomTextField(inputText: $LoginVM.password,
                                titleText: "Password",
                                promptText: "Enter your password",
                                withEye: true)
                
                Button {
                    LoginVM.login()
                } label: {
                    Text("Sign in")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                }
                .frame(width: (screenWidth - 32), height: 46)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .padding(.vertical, 40)
                .disabled(LoginVM.disableLoginBtn)
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $LoginVM.displayHomeView) {
            HomeView()
        }
        .alert(LoginVM.errorMessage ?? "Error", isPresented: $LoginVM.displayErrorMessage) {
                    Button("OK", role: .cancel) { }
                }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomTextField: View {
    @Binding var inputText: String
    var titleText: String
    var promptText: String
    var withEye: Bool = false
    @State private var showText = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(titleText)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(titleColor)
                Spacer()
            }
            HStack {
                if showText {
                    TextField(promptText, text: $inputText)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                } else {
                    SecureField(promptText, text: $inputText)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                }
                Spacer()
                
                if withEye {
                    Image("eye")
                        .resizable()
                        .frame(width: 18, height: 18, alignment: .center)
                        .scaledToFit()
                        .padding(16)
                        .onTapGesture {
                            showText.toggle()
                        }
                }
            }
            .frame(height: 42)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 1))
            .onAppear(){
                if withEye {
                    showText = false
                }
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(inputText: .constant(""),
                        titleText: "Password",
                        promptText: "Enter your password",
                        withEye: true)
    }
    // Username: kminchelle
    // Password: 0lelplR
    
}
