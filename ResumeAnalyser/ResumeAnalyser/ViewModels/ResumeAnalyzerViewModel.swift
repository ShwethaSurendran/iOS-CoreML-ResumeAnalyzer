//
//  ResumeAnalyzerViewModel.swift
//  ResumeAnalyser
//
//  Created on 03/10/25.
//

import Foundation

@Observable
class ResumeAnalyzerViewModel {
    
    var predictedJobRole: String?
    var resumeText: String = ""
    var selectedFileURL: URL?
    var selectedFileName: String?
    
    
    // MARK: - Handle File Import
    func handleImport(result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            if let url = urls.first {
                selectedFileName = url.lastPathComponent
                resumeText = PDFExtractor.extractTextFromPDF(url: url)
            }
        case .failure(let error):
            print("Failed to import file: \(error.localizedDescription)")
        }
    }
    
    func analyzeResume() {
        guard !resumeText.isEmpty else { return }
        predictedJobRole = ResumeAnalyzerModel.shared.predict(resumeText)
    }
    
    func reset() {
        predictedJobRole = nil
        resumeText = ""
        selectedFileURL = nil
        selectedFileName = nil
    }
    
}
