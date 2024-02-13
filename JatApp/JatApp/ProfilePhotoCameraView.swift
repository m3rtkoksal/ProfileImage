//
//  ProfilePhotoCameraView.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import SwiftUI

struct ProfilePhotoCameraView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var vm = ProfilePhotoCameraViewModel()
    @StateObject var model = CameraModel()
    @State var currentZoomFactor: CGFloat = 1.0
    
    var captureButton: some View {
        Button(action: {
            model.capturePhoto(viewModel: vm)
            vm.showIndicator = true
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
   
    var flipCameraButton: some View {
        Button(action: {
            model.flipCamera()
        }, label: {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        })
    }
    var body: some View {
        ZStack {
                NavigationLink(
                    destination: ProfilePhotoEditView(capturedImage: $vm.image),
                    isActive: $vm.goToPhotoEdit
                ) {
                    EmptyView()
                }
                GeometryReader { reader in
                    ZStack {
                        Color.black.edgesIgnoringSafeArea(.all)
                        VStack {
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image("left_arrow")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 16, height: 12)
                                        .padding(.leading, 16)
                                        .foregroundColor(.solidWhite)
                                }
                                Spacer()
                                Button(action: {
                                    model.switchFlash()
                                }, label: {
                                    Image(systemName: model.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                        .font(.system(size: 20, weight: .medium, design: .default))
                                })
                                .accentColor(model.isFlashOn ? .yellow : .white)
                            }
                            
                            CameraPreview(session: model.session)
                                .onDisappear {
                                    model.session.stopRunning()
                                }
                                .onAppear {
                                    model.configure()
                                }
                                .alert(isPresented: $model.showAlertError,
                                       content: {
                                    Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                                        model.alertError.primaryAction?()
                                    }))
                                })
                                .overlay(
                                    Group {
                                        if model.willCapturePhoto {
                                            Color.black
                                        }
                                    }
                                )
                                .animation(.easeInOut)
                            
                                HStack {
                                    captureButton
                                    Spacer()
                                    flipCameraButton
                                }
                                .padding(.leading, UIScreen.screenWidth / 2.5)
                        }
                    }
                }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

struct ProfilePhotoCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoCameraView()
    }
}
