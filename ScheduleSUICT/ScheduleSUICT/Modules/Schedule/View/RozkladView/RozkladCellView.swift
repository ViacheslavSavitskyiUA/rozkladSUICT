//
//  RozkladListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import SwiftUI

struct RozkladCellView: View {
    
    @ObservedObject var viewModel: RozkladCellViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(12)
                .foregroundStyle(Color.pastelBianca)
                .padding(.horizontal, 20)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(viewModel.discipline)
                        .font(.gilroy(.semibold, size: 16))
                    
                    Text(viewModel.auditory)
                        .font(.gilroy(.medium, size: 16))
                    
                    Text(viewModel.groupAuditory)
                        .font(.gilroy(.medium, size: 16))
                }
                .padding(.vertical, 20)
                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .shadow(color: .pastelBianca, radius: 8, x: 0, y: 3)
    }
}

#Preview {
    RozkladCellView(viewModel: .init(discipline: "sdcdscsdcscdscssdcdscsdcscdscssdcdscsdcscdscssdcdscsdcscdscs", auditory: "sdcdscsdcscdscs", groupAuditory: "sdcdscsdcscdscs"))
        .previewLayout(.sizeThatFits)
}


