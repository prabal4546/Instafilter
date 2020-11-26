//
//  ContentView.swift
//  Instafilter
//
//  Created by PRABALJIT WALIA     on 18/11/20.
//
import SwiftUI

struct ContentView: View {
    
    @State private var image:Image?
    @State private var showingImagePicker = false
    @State private var inputImage:UIImage?
    var body: some View {
        
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button("select image"){
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
