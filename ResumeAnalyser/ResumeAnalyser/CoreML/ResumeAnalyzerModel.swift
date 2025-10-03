//
//  ResumeAnalyzerModel.swift
//  ResumeAnalyser
//
//  Created on 03/10/25.
//

import CoreML

class ResumeAnalyzerModel {
    
    static let shared = ResumeAnalyzerModel()
    
    let model = try? JobRoleTextClassifier(configuration: MLModelConfiguration())
    
    func predict(_ resumeText: String)-> String {
        do {
            let prediction = try model?.prediction(text: resumeText)
            return prediction?.label ?? ""
        } catch {
            print("Error during prediction: \(error)")
            return ""
        }
    }
}
