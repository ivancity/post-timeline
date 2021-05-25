//
//  HomeViewModel.swift
//  KoombeaTest
//
//  Created by Ivan on 5/23/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    let mainRepo = MainRepo()
    
    @Published var userPosts: [UserPost] = []
    @Published var showRefreshView = false
    
    func handleOnAppear() {
        if loadUI() < 1 {
            onStartView()
        }
    }
    
    func onStartView() {
        showRefreshView = true
        mainRepo.getAllPosts() {[weak self] counter in
            guard counter > 0 else {
                // TODO we might want to show an error messsage here, or do something else before loading data back to the UI
                let _ = self?.loadUI()
                self?.showRefreshView = false
                return
            }
            let _ = self?.loadUI()
            self?.showRefreshView = false
        }
    }
    
    func loadUI() -> Int {
        self.userPosts = mainRepo.getUserPosts()
        return self.userPosts.count
    }
}
