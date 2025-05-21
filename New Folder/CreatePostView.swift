//
//  CreatePostView.swift
//  van
//
//  Created by 김상현 on 5/13/25.
//
// 피드 뷰 에서 + 눌러서 사진을 추가하거나 글을 작성하는 탭



import SwiftUI
import PhotosUI

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedDate = Date()
    @State private var selectedImages: [UIImage] = []
    @State private var caption: String = ""
    @State private var showingImagePicker = false
    @State private var photoPickerItems: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // 날짜 선택 (날짜 선택을 하면 캘린더가 나오고 날짜를 지정하면 캘린더는 닫혀야 한다.)
                    HStack {
                        Text("날짜")
                            .font(.headline)
                        
                        Spacer()
                        
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }
                    .padding(.horizontal)
                    
                    // 사진 선택 영역
                    Text("사진 추가 (최대 5장)").padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(selectedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // PhotosPicker
                    PhotosPicker(
                        selection: $photoPickerItems,
                        maxSelectionCount: 5,
                        matching: .images
                    ) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("사진 선택")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center) // ✅ 중앙 정렬!
                    
                    
                    
                    .task(id: photoPickerItems) {
                        selectedImages = [] // 기존 이미지 초기화
                        for item in photoPickerItems {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImages.append(uiImage)
                            }
                        }
                    }
                    
                    
                    
                    // 메모 입력
                    Text("내용")
                        .padding(.horizontal)
                    
                    ZStack(alignment: .topLeading) {
                        if caption.isEmpty {
                            Text("내용을 입력해 주세요...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        
                        TextEditor(text: $caption)
                            .padding()
                            .frame(height: 140)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    
                }
                .navigationTitle("✎Memory")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("저장") {
                            // 👉 추후 저장 처리
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("취소") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
