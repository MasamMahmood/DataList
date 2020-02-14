//
//  ViewController.swift
//  DataList
//
//  Created by Masam Mahmood on 14.02.2020.
//  Copyright © 2020 xyz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var AppData: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.delegate = self
       tableView.dataSource = self
       self.tableView.rowHeight = 49

       let nib = UINib.init(nibName: "DictionaryTableViewCell", bundle: nil)
       self.tableView.register(nib, forCellReuseIdentifier: "DictionaryTableViewCell")
        loadData()
    }
    
    func loadData() {
        
        if let url = Bundle.main.url(forResource: "dataList", withExtension: "json") {
            do {
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(PickListData.self, from: data)
                let res = response.items?.filter { $0.actionType == 103}
                AppData = res?.first
                              
                print(AppData)
                self.tableView.reloadData()
            } catch {
                print("error:\(error)")
            }
        }
        
       
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.text = self.tableView(tableView, titleForHeaderInSection: forSection)
            headerView.textLabel?.textColor = .black
            headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AppData?.pickList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AppData?.pickList?[section].title
            
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData?.pickList?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryTableViewCell", for: indexPath) as! DictionaryTableViewCell
        let dic = AppData?.pickList?[indexPath.section].items?[indexPath.row]
        cell.titleView?.text = dic?.textField
        
        cell.delegate = self

        return cell
    }
}

extension ViewController: DictionaryTableDelegate {
    func didAddnewRow(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? DictionaryTableViewCell,
              let indexPath = self.tableView.indexPath(for: cell) {
              if let selectedItem = AppData?.pickList?[indexPath.section].items?[indexPath.row] {
                
                let insertIndexPath = IndexPath(item: (AppData?.pickList?[0].items?.count ?? 0) - 1 , section: 0)

                if (AppData?.pickList?.contains(where: {$0.title != "Selected" }))! {

                    AppData?.pickList?.append(SectionList(title: "Selected", items: [selectedItem]))
                    print(AppData?.pickList?.count)
                    tableView.reloadData()
                    
                    //tableView.insertSections(IndexSet(integer: 0), with: .automatic)

                    // tableView.insertSections(IndexSet([selectedItem]), with: .automatic)

          } else {

            AppData?.pickList?[0].items?.append(selectedItem)
        }


                  cell.btnAdd.isHidden = true
                  cell.btnDelete.isHidden = false
                  tableView.beginUpdates()
                  tableView.insertRows(at: [insertIndexPath], with: .automatic)
                  tableView.endUpdates()

              }
          }
    }
    
    func didDeleteRow(_ sender: UIButton) {
        print("delete")
    }
    
    
}


