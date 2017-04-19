//
//  ChartsViewController.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-14.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, MenuTransitionManagerDelegate {
    
    
    
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var to: UITextField!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
        
    
    let menuTransitionManager = MenuTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        to.text = formatter.string(from: Date())
        
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date())
        from.text = formatter.string(from: sevenDaysAgo!)
        
        self.navigationItem.title = "Diapers"
        
        pieChartView.notifyDataSetChanged()
        
        buildChart()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! MenuChartsViewController
        self.navigationItem.title = sourceController.currentItem
        
        buildChart()
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.destination as! MenuChartsViewController
        menuTableViewController.currentItem = self.navigationItem.title!
        menuTableViewController.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
    }
    
    @IBAction func txtFrom(sender: UITextField) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector(("handleDatePicker:")), for: UIControlEvents.valueChanged)

        
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        from.text = dateFormatter.string(from: sender.date)
    }
    
    func setBarChart() {
        
        chartView.isHidden = false

        let formatter:ChartFormatterMonths = ChartFormatterMonths()
        let xaxis:XAxis = XAxis()
        
        let dataPoints = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let values = [120.0,140.0, 134.0, 154.0, 130.0, 103.0, 120.0, 134.0, 154.0, 134.0, 152.0, 130.0]
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(  x: Double(i), yValues: [values[i]] )
            dataEntries.append(dataEntry)
            formatter.stringForValue(Double(i), axis: xaxis)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Diapers")
        chartDataSet.colors = [UIColor(red: 260/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartView.chartDescription?.text = ""
        chartView.scaleYEnabled = false
        chartView.scaleXEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        xaxis.valueFormatter = formatter
        chartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        chartView.data = chartData
        
    }
    
    func setPieChart() {
     
        pieChartView.isHidden = false

        let dataPoints = ["Botle", "Breast"]
        let values = [20.0, 80.0]
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i])
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartView.legend.enabled = false
        pieChartView.chartDescription?.text = ""
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        colors.append(UIColor.purple)
        colors.append(UIColor.lightGray)
       
        pieChartDataSet.colors = colors
        
    }
    
    func setLineChart() {
        
        lineChartView.isHidden = false
        
        let formatter:ChartFormatterDays = ChartFormatterDays()
        let xaxis:XAxis = XAxis()
        
        let dataPoints = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        let values = [10.0, 9.0, 11.0, 7.0, 12.0, 8.0, 10.0]
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            formatter.stringForValue(Double(i), axis: xaxis)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Sleep (hrs)")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartView.chartDescription?.text = ""
        lineChartView.scaleYEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        xaxis.valueFormatter = formatter
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        lineChartView.data = lineChartData
        
    }
    
    func removeAllCharts() {
        
       chartView.isHidden = true
       lineChartView.isHidden = true
       pieChartView.isHidden = true

    }
    
    func buildChart() {
        
        let value:String = self.navigationItem.title!
        
        removeAllCharts()
        
        switch value {
            
            case "Diapers":
                setBarChart()
            case "Sleep":
                setLineChart()
            case "Feeding":
                setPieChart()
            default:
                setBarChart()
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

@objc(ChartFormatterMonths)
public class ChartFormatterMonths: NSObject, IAxisValueFormatter{
    
    var months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        return months[Int(value)]
    }
}

@objc(ChartFormatterDays)
public class ChartFormatterDays: NSObject, IAxisValueFormatter{
    
    var days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        return days[Int(value)]
    }
}
