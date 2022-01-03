//
//  View+Hidden.swift
//  CommonUI
//
//  Created by Stanislav Kirichok on 02.01.2022.
//

import SwiftUI

public extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
