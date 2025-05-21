//
//  vanApp.swift
//  van
//
//  Created by 김상현 on 5/9/25.
//

import SwiftUI

@main
struct vanApp: App {
    var body: some Scene {
        WindowGroup {
           PetFeedView()
        }
    }
}

#Preview {
    PetFeedView()
}
