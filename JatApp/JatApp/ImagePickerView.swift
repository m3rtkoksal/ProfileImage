//
//  ImagePickerView.swift
//  JatApp
//
//  Created by Mert Köksal on 13.02.2024.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var goToPhotoEdit: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
                parent.goToPhotoEdit = true
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImagePickerView:View {
    @Binding var selectedImage: UIImage?
    @Binding var goToPhotoEdit: Bool
    @StateObject private var viewModel = ImagePickerViewModel()
    var body: some View {
        ZStack {
            BaseView(
                currentViewModel: viewModel,
                background: .solidWhite
            ) {
                NavigationLink(
                    destination: ProfilePhotoEditView(capturedImage: $selectedImage),
                    isActive: $goToPhotoEdit
                ) {}
                Color.white // Background color of the view
                ImagePicker(selectedImage: $selectedImage, goToPhotoEdit: $goToPhotoEdit)
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
