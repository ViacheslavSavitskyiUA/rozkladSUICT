//
//  ChoiceLinksView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 25.01.2024.
//

import SwiftUI

enum LinkType {
    case telegram, instagram, facebook
    
    var defaultColor: Color {
        switch self {
        case .telegram:
            return .cyan
        case .instagram:
            return .red
        case .facebook:
            return .blue
        }
    }
    
    var socialMediaLogoName: String {
        switch self {
        case .telegram:
            return "telegramLogo"
        case .instagram:
            return "instagramLogo"
        case .facebook:
            return "facebookLogo"
        }
    }
    
    var url: String {
        switch self {
        case .telegram:
            return "https://t.me/software_engineering_DUIKT"
        case .instagram:
            return "https://www.instagram.com/softwareengineering_duikt/"
        case .facebook:
            return "https://www.facebook.com/profile.php?id=61552426912433"
        }
    }
}

struct ChoiceLinksView: View {
    
    @Environment(\.openURL) var openURL
    let cancel: () -> ()
    
    var body: some View {
        ZStack {
            RoundedCorner(radius: 16)
                .padding(.horizontal)
                .foregroundColor(.white)
            VStack {
                Text("Наші соціальні мережі:")
                    .font(.gilroy(.bold, size: 20))
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .padding(.top, 20)
                Button(action: {
                    openURL(URL(string: LinkType.telegram.url)!)
                }, label: {
                    ZStack {
                        RoundedCorner(radius: 8)
                            .foregroundColor(LinkType.telegram.defaultColor.opacity(0.5))
                            .frame(height: 50)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(LinkType.telegram.defaultColor)
//                            }
                        Image(LinkType.telegram.socialMediaLogoName)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                })
                
                Button(action: {
                    openURL(URL(string: LinkType.instagram.url)!)
                }, label: {
                    ZStack {
                        RoundedCorner(radius: 8)
                            .foregroundColor(LinkType.instagram.defaultColor.opacity(0.5))
                            .frame(height: 50)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(LinkType.instagram.defaultColor)
//                            }
                        Image(LinkType.instagram.socialMediaLogoName)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                })
                
                Button(action: {
                    openURL(URL(string: LinkType.facebook.url)!)
                }, label: {
                    ZStack {
                        RoundedCorner(radius: 8)
                            .foregroundColor(LinkType.facebook.defaultColor.opacity(0.5))
                            .frame(height: 50)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(LinkType.facebook.defaultColor)
//                            }
                        Image(LinkType.facebook.socialMediaLogoName)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                })
            }
            .padding([.horizontal, .bottom], 30)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ChoiceLinksView(cancel: {})
}
