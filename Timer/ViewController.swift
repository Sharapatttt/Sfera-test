//
//  ViewController.swift
//  Timer
//
//  Created by Sharapat Azamat on 8/28/21.
//

import UIKit
import SnapKit

struct TimersModel {
    var name: String?
    var time: Double?
}

class ViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var timer: Timer?
    private var timerArray: [TimersModel] = []
    private var isRemoved = false
    var selectedIndex: Int?
    
    //MARK: - UI Components
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: "first")
        tableView.register(SecondTableViewCell.self, forCellReuseIdentifier: "second")
        
        return tableView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        makeConstraints()
        playTime()
    }
}

//MARK: - Actions
extension ViewController {
    func addTime(name: String, time: Double) {
        timerArray.append(TimersModel(name: name, time: time))
        timerArray.sort { (arr1, arr2) -> Bool in
            if let time1 = arr1.time, let time2 = arr2.time {
                return time1 > time2
            }
            return true
        }
        self.tableView.reloadData()
    }
    
    func playTime() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timers) in
            self.isRemoved = false
            var timeArr = self.timerArray
            if self.timerArray.count != 0 {
                for i in 0..<self.timerArray.count {
                    if let time = self.timerArray[i].time {
                        if self.selectedIndex == nil {
                            timeArr[i].time = time - 1.0
                        } else {
                            if i != self.selectedIndex {
                                timeArr[i].time = time - 1.0
                            }
                        }
                    }
                }
            }
            
            var count = timeArr.count - 1
            while count >= 0 {
                if timeArr[count].time == 0 {
                    timeArr.remove(at: count)
                    self.isRemoved = true
                }
                count -= 1
            }

            self.timerArray = timeArr
            self.tableView.reloadSections([1], with: self.isRemoved ? .fade : .none)
        })
    }
}

//MARK: - UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timerArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "first", for: indexPath) as? FirstTableViewCell
            cell?.clickAdd = { name, time in
                self.addTime(name: name, time: time)
            }
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "second", for: indexPath) as? SecondTableViewCell
            cell?.name = timerArray[indexPath.row].name
            cell?.time = timerArray[indexPath.row].time
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        if section == 0 {
            view.title = "Добавление таймеров"
        } else {
            view.title = "Таймеры"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
    }
}

//MARK: - ConfigUI
extension ViewController {
    func configUI() {
        title = "TIMER"
        view.backgroundColor = .white

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}
