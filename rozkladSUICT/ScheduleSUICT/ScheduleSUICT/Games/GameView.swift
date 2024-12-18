import SwiftUI
import Firebase

struct GameView: View {
    
    @StateObject var game = Game()
    
    var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                VStack(spacing: 16) {
                    TitleView(game: game)
                    TimerView(game: game, geometry: geometry)
                    DashBoardView(game: game)
                    GameGridsView(game: game)
                    if game.combo != 0 {
                        withAnimation(.linear(duration: 0.4)) {
                            Text("Комбо ")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 120/255, green: 111/255, blue: 102/255))
                            +
                            Text("\(game.combo)")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 236/255, green: 140/255, blue: 85/255))
                            +
                            Text(" !")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 120/255, green: 111/255, blue: 102/255))
                        }
                    }
                    Spacer()
                }.task {
                    Analytics.setUserProperty("\(game.bestScore)", forName: "Best_game_score")
                }
                .padding(.horizontal)
            }
            .background(Color(red: 250/255, green: 248/255, blue: 239/255))
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
