//
//  ContentView.swift
//  Thirteen
//
//  Created by Alexander Burneikis on 7/6/2022.
//

import SwiftUI
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

let cards = ["1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "11S", "12S", "13S","1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "11D", "12D", "13D","1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C","1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "11H", "12H", "13H"]

var currentCards = cards

let green = UIColor(red:0,green:1,blue:0,alpha: 0.3)
let red = UIColor(red:1,green:0,blue:0,alpha: 0.3)

private struct pastCard: Identifiable {
    let name: String
    let win: Bool
    var id: String { name }
}

struct ContentView: View {
    @State private var currentCard = currentCards.randomElement()!
    @State private var lastCard = "gray_back"
    @State private var cardsUsed = 1
    @State private var score = 0
    
    @State private var pastCards: [pastCard] = [
    ]
    
    func isWin(isOver: Bool) -> Bool{
        var card1Value = Int(lastCard.trimmingCharacters(in: CharacterSet(charactersIn: "SDCH")))!
        var card2Value = Int(currentCard.trimmingCharacters(in: CharacterSet(charactersIn: "SDCH")))!
        if (card1Value > 10) {
            card1Value = 10
        }
        if (card2Value > 10) {
            card2Value = 10
        }
        
        if (isOver) {
            if (card1Value + card2Value > 13) {
                return true
            }
            else {
                return false
            }
        } else {
            if (card1Value + card2Value <= 13) {
                return true
            }
            else {
                return false
            }
        }
        
        //let closeness = abs(card1Value + card2Value - 13)
    }
    func makeCard() -> some View{
        return Image(currentCard)
            .resizable()
            .scaledToFit()
    }
    func makeLastCards() -> some View {
        return ScrollView(.horizontal) {
            HStack(spacing: -40) {
                ForEach(pastCards) { pastCard in
                    ZStack {
                        Image(pastCard.name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight * 0.15)
                        Color(pastCard.win ? green : red)
                            .frame(width: screenWidth * 0.21, height: screenHeight * 0.15)
                    }
                }
            }
        }
    }
    func makeTopButton() -> some View {
        return Color(red: 1, green: 1, blue: 1, opacity: 0.1)
            .onTapGesture {
                if (currentCards.count > 1) {
                    currentCards.remove(at:currentCards.firstIndex(of: currentCard)!)
                    lastCard = currentCard
                    currentCard = currentCards.randomElement()!
                    pastCards.insert(pastCard(name: lastCard, win: isWin(isOver:true)), at: 0)
                }
            }
    }
    func makeBottomButton() -> some View {
        return Color(red: 1, green: 1, blue: 1, opacity: 0.1)
            .onTapGesture {
                if (currentCards.count > 1) {
                    currentCards.remove(at:currentCards.firstIndex(of: currentCard)!)
                    lastCard = currentCard
                    currentCard = currentCards.randomElement()!
                    pastCards.insert(pastCard(name: lastCard, win: isWin(isOver:false)), at: 0)
                }
            }
    }
    func makeButtons() -> some View{
        return VStack(spacing: 0) {
            makeTopButton()
            makeBottomButton()
        }
    }
    var body: some View {
        VStack {
            NavigationView {
                HStack {}
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                            }

                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text(String(cardsUsed) + "/52")
                                .foregroundColor(Color.blue)
                        }
                        ToolbarItem(placement: .status) {
                            Text(String(score))
                                .foregroundColor(Color.blue)
                        }
                    }
            }
            .frame(height: screenHeight * 0.1)
            ZStack {
                VStack() {
                    makeCard()
                    makeLastCards()
                }
                makeButtons()
            }
            .frame(height: screenHeight * 0.9)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
