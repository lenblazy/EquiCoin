//
//  ChartUIView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import SwiftUI
import Charts

struct ChartUIView: View {
    let sparkline: [Double]
    
    var body: some View {
        let minY = sparkline.min() ?? 0
        let maxY = sparkline.max() ?? 1
        
        Chart {
            ForEach(sparkline.indices, id: \.self) { index in
                LineMark(
                    x: .value("Index", index),
                    y: .value("Value", sparkline[index])
                )
                .interpolationMethod(.linear)
                .foregroundStyle(Color.green)
                .lineStyle(StrokeStyle(lineWidth: 2))
            }
        }
        .chartYScale(domain: minY...maxY)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 160)
        .background(Color.clear)
    }
}

#Preview {
    ChartUIView(sparkline: [
        0.000013344637297456,
        0.000013292200532586,
        0.00001330195895742,
        0.000013359673103978,
        0.000013397194431705,
        0.000013515076323996,
        0.00001357714795544,
        0.000013649958379422,
        0.000013560002608282,
        0.000013507267128888,
        0.000013676707367625,
        0.000013679766101032,
        0.000013690451094344,
        0.000013640482341905,
        0.000013597437612248,
        0.000013550643096463,
        0.00001363820032999,
        0.000013610857628591,
        0.000013519625191063,
        0.000013499227313144,
        0.000013546252429837,
        0.000013597858471042,
        0.000013628894976076,
        0.000013514773904932,
    ])
}
