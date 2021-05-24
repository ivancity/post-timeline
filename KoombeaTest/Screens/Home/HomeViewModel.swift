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
        mainRepo.getAllPosts() {[weak self] counter in
            guard counter > 0 else {
                print("not able to get posts")
                // update UI
                self?.loadUI()
                return
            }
            // update UI
            self?.loadUI()
        }
    }
    
    func loadUI() {
        let userPosts = mainRepo.getUserPosts()
        print("here")
    }
}
