//
//  String + extension.swift
//  MoviesApp
//
//  Created by Ruslan on 14.05.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
