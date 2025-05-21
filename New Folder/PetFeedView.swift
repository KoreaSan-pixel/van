//
//  SwiftUIView.swift
//  van
//
//  Created by 김상현 on 5/9/25.
//

import SwiftUI

struct PetPost: Identifiable {
    let id = UUID()
    let userName: String
    let date: String
    let imageNames: [String]
    let caption: String
    let comments: [String]
}

struct PetFeedView: View {
    @State private var posts: [PetPost] = [
        PetPost(userName: "산이", date: "2025년 5월 11일", imageNames: ["pet1", "pet2"], caption: "오늘은 산책 잘 다녀왔어요! 🐾", comments: ["너무 귀여워요!", "와 진짜 힐링된다"]),
        PetPost(userName: "상현", date: "2025년 5월 10일", imageNames: ["pet3"], caption: "목욕하고 기분 좋아졌어요 🛁", comments: ["어떤 샴푸 쓰세요?", "물기 털기 장인!"])
    ]
    
    @State private var showCreatePost = false
    
    
    var body: some View {
        NavigationView {
 VStack(alignment: .leading) {
                      // ✅ 상단 타이틀 + 글쓰기 버튼
  
     HStack {
         Text("반려동물 기록")
             .font(.title)
             .fontWeight(.bold)

         Spacer() // 👈 이게 중요! 오른쪽으로 밀어줌

         Button(action: {
             showCreatePost = true
         }) {
             HStack(spacing: 4) {
                 Image(systemName: "plus")
                 
             }
             .padding(.horizontal, 10)
             .padding(.vertical, 6)
             .background(Color.blue)
             .foregroundColor(.white)
             .cornerRadius(8)
         }
     }
     .padding(.horizontal)
     .sheet(isPresented: $showCreatePost) {
         CreatePostView()
     }

     
                      .padding(.horizontal)
                      .padding(.top)

                      // ✅ 게시글 목록
                      ScrollView {
                          VStack(spacing: 20) {
                              ForEach(posts) { post in
                                  PetPostCard(post: post)
                              }
                          }
                          .padding(.vertical)
                      }
                  }
                  .navigationBarHidden(true)
              }
          }
    
    struct PetPostCard: View {
        let post: PetPost
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                // 👤 유저명 + 날짜
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text(post.userName).fontWeight(.semibold)
                        Text(post.date).font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // 🖼️ 사진들 (가로 스크롤)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(post.imageNames, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 📝 본문
                Text(post.caption)
                    .font(.body)
                    .padding(.horizontal)
                
                // 💬 댓글
                ForEach(post.comments, id: \.self) { comment in
                    HStack {
                        Image(systemName: "bubble.left.fill")
                        Text(comment)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                }
                
                Divider().padding(.top, 8)
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    PetFeedView()
}
