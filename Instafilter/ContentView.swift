//
//  ContentView.swift
//  Instafilter
//
//  Created by PRABALJIT WALIA     on 18/11/20.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image:Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var currentFilter:CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    var body: some View {
        
        let intensity = Binding<Double>{
            get:  do {
                self.filterIntensity
            },
            set:do {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        }
        
        return NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil{
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else{
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                }
                .onTapGesture {
                    //select an image
                    self.showingImagePicker = true
                }
                HStack{
                    Text("Intensity")
                        .padding(.horizontal)
                    Slider(value: intensity)
                }
                .padding(.vertical)
                HStack{
                    Button("Change Filter"){
                        //change filter
                    }
                    Spacer()
                    Button("Save"){
                        //save the picture
                    }
                }
            }
            
        }
        .padding([.horizontal,.bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showingImagePicker,onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
    func applyProcessing(){
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage
        else{return}
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            
        }
        
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
