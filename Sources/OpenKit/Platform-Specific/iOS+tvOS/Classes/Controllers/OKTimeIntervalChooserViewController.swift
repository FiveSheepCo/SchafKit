//  Copyright (c) 2015 - 2019 Jann Schafranek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS)
import UIKit

public class OKTimeIntervalChooserViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    public enum GenericType {
        case timeInterval
        case timeInDay
        case date
    }
    
    private var picker : UIView!
    private let type : GenericType
    private let completionHandler : (TimeInterval) -> Void
    
    public init(initialValue : TimeInterval, type : GenericType = .timeInterval, completionHandler : @escaping (TimeInterval) -> Void) {
        self.type = type
        self.completionHandler = completionHandler
        
        super.init(nibName: nil, bundle: nil)
        
        preferredContentSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 180)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        if type == .timeInterval {
            let picker = UIPickerView(frame: .zero)
            picker.dataSource = self
            picker.delegate = self
            self.picker = picker
            
            var lastIndex : Int = 0
            for index in 1..<units.count {
                if initialValue.truncatingRemainder(dividingBy: units[index].timeInterval) == 0 {
                    lastIndex = index
                } else {
                    break
                }
            }
            
            picker.selectRow(lastIndex, inComponent: 1, animated: false)
            
            updateNumberOfItems()
            picker.reloadComponent(0)
            picker.selectRow(Int(initialValue / units[lastIndex].timeInterval) - 1, inComponent: 0, animated: false)
        } else {
            let picker = UIDatePicker(frame: .zero)
            picker.datePickerMode = (type == .timeInDay) ? .time : .dateAndTime
            
            
            picker.date = (type == .timeInDay) ? Calendar.current.startOfDay(for: Date()).addingTimeInterval(initialValue) : Date(timeIntervalSinceReferenceDate: initialValue)
            
            self.picker = picker
        }
    }
    
    @objc func cancel() {
        self.dismiss()
    }
    
    @objc func done() {
        if let picker = picker as? UIDatePicker {
            if type == .date {
                completionHandler(picker.date.timeIntervalSinceReferenceDate)
            } else {
                let interval = -NSCalendar.current.startOfDay(for: Date()).timeIntervalSince(picker.date)
                completionHandler(interval - interval.truncatingRemainder(dividingBy: 60))
            }
        } else if let picker = picker as? UIPickerView {
            completionHandler(units[picker.selectedRow(inComponent: 1)].timeInterval * TimeInterval(picker.selectedRow(inComponent: 0) + 1))
        }
        
        self.dismiss()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight)) //
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(blurView)
        blurView.contentView.addSubview(picker)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.navigationController?.navigationBar.frame.size.height ?? 0),
            blurView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            blurView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            picker.topAnchor.constraint(equalTo: blurView.topAnchor),
            picker.leftAnchor.constraint(equalTo: blurView.leftAnchor),
            picker.rightAnchor.constraint(equalTo: blurView.rightAnchor),
            picker.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
            ])
        
        updateNumberOfItems()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    let units : [OKTimeUnit] = [.second, .minute, .hour, .day, .week, .year]
    var numberOfItems : Int = 0
    func updateNumberOfItems() {
        guard let picker = picker as? UIPickerView else {
            return
        }
        
        let current = picker.selectedRow(inComponent: 1)
        if let nextUnit = units[ifExists: current + 1] {
            let currentUnit = units[current]
            
            numberOfItems = Int(nextUnit.rawValue / currentUnit.rawValue - 1)
            return
        }
        numberOfItems = 10
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return numberOfItems
        default:
            return units.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title(for: row, component: component)
    }
    
    func title(for row: Int, component : Int) -> String {
        switch component {
        case 0:
            return "\(row + 1)"
        default:
            return /*"   " +*/ units[row].name
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            updateNumberOfItems()
            pickerView.reloadComponent(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
