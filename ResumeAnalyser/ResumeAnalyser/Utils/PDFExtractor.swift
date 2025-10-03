//
//  PDFExtractor.swift
//  ResumeAnalyser
//
//  Created on 03/10/25.
//

import PDFKit

struct PDFExtractor {
    
    static func extractTextFromPDF(url: URL)-> String {
        
        guard url.startAccessingSecurityScopedResource() else {
            print("Could not access security-scoped resource")
            return ""
        }
        
        defer { url.stopAccessingSecurityScopedResource() }
        
        guard let pdfDoc = PDFDocument(url: url) else {
            print("Failed to open PDF document.")
            return ""
        }

        var fullText = ""
        for i in 0..<pdfDoc.pageCount {
            if let page = pdfDoc.page(at: i), let text = page.string {
                fullText += text + "\n"
            }
        }

        return fullText
    }
    
}
