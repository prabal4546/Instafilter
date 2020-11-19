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
    var body: some View {
        
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform:loadImage)
    }
    func loadImage(){
        image = Image("")
        guard let inputImage = UIImage(named: "")
        else {return}
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage
        else{return}
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
