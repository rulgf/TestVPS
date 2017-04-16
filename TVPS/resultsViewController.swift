//
//  resultsViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 15/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import Charts

class resultsViewController: UIViewController, ChartViewDelegate {
    
    var subtests:[String]!
    
    var results: [Double]!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var test:Test?
    
    var birth:String?
    
    var rawResults: [Int]!
    
    var scaledScore: [Double]!
    
    @IBOutlet weak var res1: UILabel!
    @IBOutlet weak var res2: UILabel!
    @IBOutlet weak var res3: UILabel!
    @IBOutlet weak var res4: UILabel!
    @IBOutlet weak var res5: UILabel!
    @IBOutlet weak var res6: UILabel!
    @IBOutlet weak var res7: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        subtests = ["DIS" , "MEM", "SPA", "CON", "SEQ", "FGR", "CLO"]
        
        results = [10, 16, 8, 9, 10, 17, 4]
        
        rawResults = [(test?.res1)!, (test?.res2)!, (test?.res3)!, (test?.res4)!, (test?.res5)!, (test?.res6)!, (test?.res7)!]
        
        scaledScore = AppendixB.rawToScaled(rawScore: rawResults, birth: self.birth!, dateOfTest: (self.test?.date)!)
        
        print(scaledScore)
        
        setChart(dataPoints: subtests, values: scaledScore)
        
        res1.text = "\((test?.res1)!)"
        res2.text = "\((test?.res2)!)"
        res3.text = "\((test?.res3)!)"
        res4.text = "\((test?.res4)!)"
        res5.text = "\((test?.res5)!)"
        res6.text = "\((test?.res6)!)"
        res7.text = "\((test?.res7)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Scaled Score")
        
        var dataSets : [BarChartDataSet] = [BarChartDataSet]()
        dataSets.append(chartDataSet)
        
        let data: BarChartData = BarChartData(dataSets: dataSets)
        
        self.barChartView.data = data
        
        let xaxis = self.barChartView.xAxis
        xaxis.valueFormatter = MyXAxisFormatter(subtests)
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let ll = ChartLimitLine(limit: 10.0, label: "Media")
        barChartView.rightAxis.addLimitLine(ll)
        
        barChartView.chartDescription?.text = ""
        
        chartDataSet.colors = [UIColor(red: 102/255, green: 102/255, blue: 255/255, alpha: 1)]
        
        barChartView.leftAxis.axisMinValue = 0.0
        barChartView.leftAxis.axisMaxValue = 19.9
        
        barChartView.rightAxis.axisMinValue = 0.0
        barChartView.rightAxis.axisMaxValue = 19.9
    }
    
    
}
class MyXAxisFormatter: NSObject, IAxisValueFormatter {
    
    let subtests: [String]
    
    init(_ subtests: [String]) {
        self.subtests = subtests
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return subtests[Int(value)]
    }
    
}
