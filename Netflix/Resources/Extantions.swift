//
//  Extantions.swift
//  Netflix
//
//  Created by Denis Lebedinsky on 06.04.2022.
//

import Foundation

extension String {
    func capitalizeFirsLatter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
