//
//  SpreadViewController_swift.swift
//  BigShow1949
//
//  Created by apple on 17/2/20.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

import UIKit


class SpreadViewController_swift: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableview: UITableView!
    
    let sentionTitles = ["开启设备","未能链接WIFI","配置网络/重置网络","声波配网失败原因"]
    
    let cellTitles = ["还不会如何开启设备吗？点击设备上的开 机按钮，设备会启动，听到开机音乐就证 明设备启动啦！",
                      "有可能是您的手机未启用WIFI网络。您可 以在手机的”设置”>“WLAN”中选择一个 可用的WIFI接入。如果您已接入WIFI网络， 请检查WIFI热点是否已接入互联网，或该 热点是否已允许您的设备访问互联网。",
                      "配置网络时，需要先将设备调至配置网络 模式，当听到 可以配网的提示音后，即可 进行配网操作。进入配网模式，请按住设 备 上一首按键 5秒钟以上即可。",
                      "声波配网目前不支持5G WIFI信号、请先 看下是否连接了可用WIFI。另外根据声音 的反馈，也可以定位到问题所在，例如密 码输入错误。如果手机音量较小，或配网 距离设备较远，请调大音量，并靠近设备 再次重试。"]
    let flagArray : NSMutableArray = NSMutableArray()
    
    let cellArray : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeData()
        self.setupTableView()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func makeData() {
        for _ : NSInteger in 0...sentionTitles.count - 1 {
            flagArray.add(false)
        }
    }
    func setupTableView() {
        tableview = UITableView.init(frame: CGRect(x:0, y:64, width:self.view.frame.size.width, height:self.view.frame.size.height), style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.white
        tableview.tableFooterView = UIView.init()
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview.estimatedRowHeight = 200
        tableview.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableview)
    }
    
    //MARK:-UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    //MARK:-UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sentionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flagArray[section] as! Bool {
            return 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HelpSectionHeader()
        view.tag = section + 2000
        view.spreadBtn.isSelected = flagArray[section] as! Bool
        view.spreadBlock = {(index : NSInteger,isSelected : Bool) in
            print(index)
            let ration : NSInteger = index - 2000
            if self.flagArray[ration] as! Bool {
                self.flagArray[ration] = false
            }else {
                self.flagArray[ration] = true
            }
            self.tableview.reloadSections(IndexSet.init(integer: index - 2000), with: UITableView.RowAnimation.automatic)
        }
        view.titleLabel.text = sentionTitles[section]
        return view
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell\(indexPath.section)\(indexPath.row)"
        self.tableview.register(UINib.init(nibName: "HelpTableCell", bundle: Bundle.main), forCellReuseIdentifier: identifier)
        let cell : HelpTableCell = tableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HelpTableCell
        
        let content : String = cellTitles[indexPath.section]
        
        let attributesString = NSMutableAttributedString.init(string : content)
        //创建NSMutableParagraphStyle
        let paraghStyle = NSMutableParagraphStyle()
        //设置行间距（同样这里可以设置行号，间距，对齐方式）
        paraghStyle.lineSpacing = cell.cellTitle.font.lineHeight
        //添加属性，设置行间距
        attributesString.addAttributes([NSAttributedString.Key.paragraphStyle : paraghStyle], range: NSMakeRange(0, content.count))
        cell.cellTitle.attributedText = attributesString
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
    
}
