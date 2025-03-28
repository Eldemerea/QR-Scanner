//
//  ContentVievv.swift
//  QR Scanner
//
//  Created by mac on 26.03.2025.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    
    
    @State private var scannedCode:  String = "Scan a QR Code to get started"
    @State private var isPresentingScanner = false
    
    
    
    var scannerSheet: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        if case let .success(code) = result {
                            withAnimation {
                                self.scannedCode = code.string
                                openURL(code.string)
                            }
                            self.isPresentingScanner = false
                            
                        }
                    }
                )
                .clipShape(Rectangle())
                .frame(width: 250, height: 250)
                .cornerRadius(15)
                .overlay(
                RoundedRectangle(cornerRadius:15)
                    .stroke(Color.white, lineWidth: 3)
//                    .frame(width: 250, height: 250)
                )
                Spacer()
                Button(action: {
                    self.isPresentingScanner = false
                })
                {
                    Text("Back")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 30)
            }
            
        }
        
    }
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                Text(scannedCode)
                    .font(.headline)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                Button(action: {
                    self.isPresentingScanner = true
                }) {
                    Text("Scan QR Code ioioio")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .fullScreenCover(isPresented: $isPresentingScanner) {
                    scannerSheet
                }
                Spacer().frame(height:30)
            }
        }
    }
}

private func openURL(_ urlString: String) {
    
    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url){
        UIApplication.shared.open(url, options: [:], completionHandler: nil)    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
        
    }
    
}
