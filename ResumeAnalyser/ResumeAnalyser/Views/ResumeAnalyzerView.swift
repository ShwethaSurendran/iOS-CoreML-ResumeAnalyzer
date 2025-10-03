//
//  ResumeAnalyzerView.swift
//  ResumeAnalyser
//
//  Created on 03/10/25.
//

import SwiftUI

struct ResumeAnalyzerView: View {
    
    @State private var showPicker: Bool = false
    @Bindable private var viewModel = ResumeAnalyzerViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                
                // MARK: Upload Button
                Button(action: {
                    showPicker.toggle()
                }) {
                    HStack {
                        Image(systemName: "doc.fill.badge.plus")
                        Text("Upload Resume (PDF)")
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .fileImporter(
                    isPresented: $showPicker,
                    allowedContentTypes: [.pdf],
                    allowsMultipleSelection: false
                ) { result in
                    viewModel.handleImport(result: result)
                }
                
                Spacer()
                
                // MARK: File Info
                if let fileName = viewModel.selectedFileName {
                    HStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(.gray)
                        Text("Loaded: \(fileName)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                // MARK: Resume Text Display
                if !viewModel.resumeText.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Extracted Resume Text:")
                            .font(.headline)
                        TextEditor(text: $viewModel.resumeText)
                            .frame(minHeight: 200)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            })
                    }
                    
                    // MARK: Analyze Button
                    Button(action: {
                        viewModel.predictedJobRole = ResumeAnalyzerModel.shared.predict(viewModel.resumeText)
                    }) {
                        HStack {
                            Image(systemName: "brain.head.profile")
                            Text("Analyze Resume")
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    // MARK: Prediction Result
                    if let result = viewModel.predictedJobRole {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Predicted Job Role:")
                                .font(.headline)
                            Text(result)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.purple)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
            .navigationTitle("Resume Analyzer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        viewModel.reset()
                    }
                }
            }
        }
    }

}

#Preview {
    NavigationView {
        ResumeAnalyzerView()
    }
}
