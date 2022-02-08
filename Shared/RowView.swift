//
//  RowView.swift
//  TenForwrdle
//
//  Created by Tricia DiPiazza on 2/8/22.
//

import SwiftUI

let size: CGFloat = 30

enum LetterState {
    case correctOutOfPlace
    case correctInPlace
    case incorrect
    case unsubmitted
}

struct RowView: View {
    @State var firstLetterState: LetterState = .unsubmitted
    @State var secondLetterState: LetterState = .correctOutOfPlace
    @State var thirdLetterState: LetterState = .unsubmitted
    @State var fourthLetterState: LetterState = .correctInPlace
    @State var fifthLetterState: LetterState = .correctOutOfPlace
    
    var body: some View {
        HStack {
            LetterBoxView(letterState: $firstLetterState)
            LetterBoxView(letterState: $secondLetterState)
            LetterBoxView(letterState: $thirdLetterState)
            LetterBoxView(letterState: $fourthLetterState)
            LetterBoxView(letterState: $fifthLetterState)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}

struct LetterBoxView: View {
    
    @State private var letter: String = ""
    @Binding var letterState: LetterState
    
    var body: some View {
        Rectangle()
            .frame(width: size, height: size, alignment: .center)
            .foregroundColor(color)
            .border(.black)
            .overlay {
                TextField("", text: $letter)
                    .frame(width: size, height: size, alignment: .center)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.characters)
                    .disableAutocorrection(true)
                    .onReceive(letter.publisher.collect()) {
                        self.letter = String($0.prefix(1))
                    }
            }
    }
    
    var color: Color {
        switch letterState {
        case .correctOutOfPlace:
                return .yellow
        case .correctInPlace:
                return .green
        case .incorrect:
                return .gray
        case .unsubmitted:
                return .white
        }
    }
}
