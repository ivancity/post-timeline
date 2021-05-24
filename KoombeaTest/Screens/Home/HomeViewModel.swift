//
//  HomeViewModel.swift
//  KoombeaTest
//
//  Created by Ivan on 5/23/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    let mainRepo = MainRepo()
    
    func onStartView() {
        mainRepo.getAllPosts()
    }
}
